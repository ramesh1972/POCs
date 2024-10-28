#include "rvXPCOMIDs.h"
#include "nsIXMLHttpRequest.h"
#include "nsIHTMLContentSink.h"
#include "rvMyMozApp.h"
#include "MyMozXmlDocument.h"
#include "nsWebBrowserChrome.h"
#include "nsIWindowListener.h"
#include "nsILoggingSink.h"
#include "nsWebCrawler.h"
#include "nsIThread.h"
#include "nsIRunnable.h"

#include "nsIContentSerializer.h"
extern rvMyMozApp* theApp;

static NS_DEFINE_IID(kLoggingSinkCID, NS_LOGGING_SINK_CID);


class RuleProcessorThread : public nsIRunnable
{
public:
	  NS_DECL_ISUPPORTS

public:
		nsIThread* mThread;
    NS_IMETHOD Run() 
		{
			while (true)
			{
				CRuleProcessor::ProcessRules();
				PR_Sleep(30000);
			}

			return NS_OK;
		}

		void StartThread()
		{
			CRuleProcessor* proc = new CRuleProcessor();
			proc->LoadRules();
      nsresult rv = NS_NewThread(&mThread, this, 0, PR_JOINABLE_THREAD);
      NS_ADDREF(mThread);
      NS_ASSERTION(NS_SUCCEEDED(rv), "new thread failed");
		}
};

NS_IMPL_THREADSAFE_ISUPPORTS1(RuleProcessorThread, nsIRunnable)

nsresult ProcessRule()
{
  nsresult											rv;
  nsCOMPtr<nsIURI>							pURI;
  nsCOMPtr<nsIChannel>					pChannel;
  nsCOMPtr<nsIInputStream>			pInputStream;
  nsCOMPtr<nsIDOMParser>				pDOMParser;
  nsCOMPtr<nsIDOMDocument>			pDOMDocument;
   
//  nsCOMPtr<nsILocalFile> pFile(do_CreateInstance("@mozilla.org/file/local;1"));
//  NS_ENSURE_TRUE(pFile, NS_ERROR_FAILURE);
		nsString file(NS_LITERAL_STRING("file:///c:/test0.html"));
//  pFile->InitWithPath(file);

//	char* buf = new char[1024];
//  nsCOMPtr<nsIServiceManager> servMgr;
//  NS_GetServiceManager(getter_AddRefs(servMgr));
  
	pDOMParser = do_CreateInstance( NS_DOMPARSER_CONTRACTID,&rv );
	rv = NS_NewURI(getter_AddRefs(pURI), file);

 if (NS_SUCCEEDED( rv )) 
 {
    rv = NS_NewChannel(getter_AddRefs( pChannel ),
											pURI,
											nsnull,
											nsnull );

    if (NS_SUCCEEDED( rv )) 
		{
				rv = pChannel->Open(getter_AddRefs(pInputStream));

        if (NS_SUCCEEDED( rv )) 
				{
						PRUint32 uiContentLength;
            rv = pInputStream->Available(&uiContentLength );
            if (NS_SUCCEEDED( rv )) 
						{
							//NS_NewLocalFileInputStream(getter_AddRefs(pInputStream), pFile, PR_RDONLY, PR_IRUSR, 0);
              //pDOMParser = do_CreateInstance( NS_DOMPARSER_CONTRACTID,&rv );

							//PRUint32 ret = 0;
							//pInputStream->Read(buf, 1024, &ret);
              if (NS_SUCCEEDED( rv )) 
							{
                pDOMParser->SetBaseURI(pURI);
				        rv = pDOMParser->ParseFromStream( pInputStream, nsnull, uiContentLength , "text/xml",
                                          getter_AddRefs( pDOMDocument ) );


                if (NS_SUCCEEDED( rv )) {
                  printf( "DOM parse of %s successful\n", "");
                }
                else {
                  printf( "DOM parse of %s NOT successful\n", "");
                }
              }
              else {
                printf( "do_CreateInstance of DOMParser failed for %s - %08X\n", "", rv );
              }
            }
            else {
              printf( "pInputSteam->Available failed for %s - %08X\n", "", rv );
            }
          }
          else {
            printf( "pChannel->OpenInputStream failed for %s - %08X\n", "", rv );
          }
        }
        else {
          printf( "NS_NewChannel failed for %s - %08X\n", "", rv );
        }
      }
      else {
        printf( "NS_NewURI failed for %s - %08X\n", "", rv );
      }


	    if (pDOMDocument) 
			{
				nsCOMPtr<nsIDOMElement> element;
				pDOMDocument->GetDocumentElement(getter_AddRefs(element));
				nsAutoString tagName;

//				_rules_doc->DumpNode(element);				
				if (element) element->GetTagName(tagName);
				char *s = ToNewCString(tagName);
				printf("Document element=\"%s\"\n",s);
				nsCRT::free(s);
				nsCOMPtr<nsIDocument> doc = do_QueryInterface(pDOMDocument);
				if (doc) 
				{
					nsCAutoString spec;
					doc->GetDocumentURI()->GetSpec(spec);
					printf("Document URI=\"%s\"\n",spec.get());
				}
			}

  pURI = nsnull;
  pChannel = nsnull;
  pInputStream = nsnull;
  pDOMParser = nsnull;
  pDOMDocument = nsnull;
  //pXMLHttpRequest = nsnull;

  return NS_OK;
}

nsresult LoadHTMLDocument()
{
	nsCOMPtr<nsIDocShell> docShell;
  PRInt32 charsetSource = kCharsetFromDocTypeDefault;
  nsCAutoString charset(NS_LITERAL_CSTRING("UTF-8"));

	nsCOMPtr<nsIURI> pURI;
	nsString file(NS_LITERAL_STRING("file:///c:/test0.html"));
	nsresult rv = NS_NewURI(getter_AddRefs(pURI), file);

  static NS_DEFINE_CID(kParserCID, NS_PARSER_CID);
	nsCOMPtr<nsIParser> parser(do_CreateInstance(kParserCID, &rv));
  NS_ENSURE_SUCCESS(rv, rv);

	nsCOMPtr<nsIChannel> pChannel;
  rv = NS_NewChannel(getter_AddRefs( pChannel ),pURI, nsnull,nsnull);

  nsCAutoString progId(NS_CONTENTSERIALIZER_CONTRACTID_PREFIX);
  progId.AppendWithConversion(MozStr("text/html"));

  // The syntax used here doesn't work
  nsCOMPtr<nsIContentSink> sink;
  sink = do_CreateInstance(NS_PLAINTEXTSINK_CONTRACTID);
  NS_ENSURE_TRUE(sink, NS_ERROR_FAILURE);
  nsCOMPtr<nsIHTMLContentSink> sinkh (do_QueryInterface(sink));

	nsCOMPtr<nsIDTD> dtd;
  NS_DEFINE_CID(kNavDTDCID, NS_CNAVDTD_CID);
  nsComponentManager::CreateInstance(kNavDTDCID, nsnull, NS_GET_IID(nsIDTD),(void**) &dtd);

  // Set the parser as the stream listener for the document loader...
	parser->RegisterDTD(dtd);
  parser->SetDocumentCharset(charset, charsetSource);
  parser->SetContentSink(sinkh);
//	parser->Parse(pURI);
	rv = parser->Parse(file, 0, NS_LossyConvertUCS2toASCII(MozStr("text/html")), PR_FALSE, PR_TRUE);
	rv = parser->ContinueParsing();

	PRBool com = parser->IsComplete();
	while (com == PR_FALSE)
		com = parser->IsComplete();

	nsIDOMHTMLDocument* doc;
	doc = (nsIDOMHTMLDocument*) sink->GetTarget();

	return NS_OK;
}

nsresult LoadHTMLDocument1()
{
	nsString file(NS_LITERAL_STRING("resource:/res/samples/sample.html"));
  nsCOMPtr<nsIDocShell> docShell(do_CreateInstance(kWebShellCID));
  docShell->SetAllowPlugins(PR_TRUE);

  // create the web crawler
  nsWebCrawler* mCrawler = new nsWebCrawler(theApp);
  mCrawler->SetBrowserWindow(nsnull);

	mCrawler->AddURL(file);
	nsIDOMDocument* doc = mCrawler->Start(docShell, file);
	nsIDOMElement* elem;
	doc->GetDocumentElement(&elem);
//	_rules_doc->DumpNode(elem);

	return NS_OK;
}

// test functions
nsresult ParseXmlFile() {

	  nsresult                 rv;
  nsCOMPtr<nsIURI>             pURI;
  nsCOMPtr<nsIChannel>         pChannel;
  nsCOMPtr<nsIInputStream> pInputStream;
  nsCOMPtr<nsIDOMParser>       pDOMParser;
  nsCOMPtr<nsIDOMDocument>     pDOMDocument;
//  nsCOMPtr<nsIXMLHttpRequest>  pXMLHttpRequest;
   
  nsCOMPtr<nsILocalFile> pFile(do_CreateInstance("@mozilla.org/file/local;1"));
  NS_ENSURE_TRUE(pFile, NS_ERROR_FAILURE);
	nsString file(NS_LITERAL_STRING("c:\\data.xml"));

  pFile->InitWithPath(file);

	char* buf = new char[1024];
  nsCOMPtr<nsIServiceManager> servMgr;
  NS_GetServiceManager(getter_AddRefs(servMgr));
  
	pDOMParser = do_CreateInstance( NS_DOMPARSER_CONTRACTID,
                                     &rv );
	// rv = NS_NewURI( getter_AddRefs( pURI ),file);

      if (NS_SUCCEEDED( rv )) {
    //    rv = NS_NewChannel( getter_AddRefs( pChannel ),
      //                   pURI,
        //                 nsnull,
          //               nsnull );

        if (NS_SUCCEEDED( rv )) {

          //rv = pChannel->Open(getter_AddRefs(pInputStream));



          if (NS_SUCCEEDED( rv )) {
            //rv = pInputStream->Available(&uiContentLength );

            if (NS_SUCCEEDED( rv )) {
							NS_NewLocalFileInputStream(getter_AddRefs(pInputStream), pFile, PR_RDONLY, PR_IRUSR, 0);
              pDOMParser = do_CreateInstance( NS_DOMPARSER_CONTRACTID,&rv );

			  PRUint32 ret = 0;
			  //pInputStream->Read(buf, 1024, &ret);
              if (NS_SUCCEEDED( rv )) {
                pDOMParser->SetBaseURI(pURI);

				
                rv = pDOMParser->ParseFromBuffer( (const unsigned char*) buf,ret, "text/xml",
                                          getter_AddRefs( pDOMDocument ) );


                if (NS_SUCCEEDED( rv )) {
                  printf( "DOM parse of %s successful\n", "");
                }
                else {
                  printf( "DOM parse of %s NOT successful\n", "");
                }
              }
              else {
                printf( "do_CreateInstance of DOMParser failed for %s - %08X\n", "", rv );
              }
            }
            else {
              printf( "pInputSteam->Available failed for %s - %08X\n", "", rv );
            }
          }
          else {
            printf( "pChannel->OpenInputStream failed for %s - %08X\n", "", rv );
          }
        }
        else {
          printf( "NS_NewChannel failed for %s - %08X\n", "", rv );
        }
      }
      else {
        printf( "NS_NewURI failed for %s - %08X\n", "", rv );
      }

	    if (pDOMDocument) 
			{
				nsCOMPtr<nsIDOMElement> element;
				pDOMDocument->GetDocumentElement(getter_AddRefs(element));
				nsAutoString tagName;
				if (element) element->GetTagName(tagName);
				char *s = ToNewCString(tagName);
				printf("Document element=\"%s\"\n",s);
				nsCRT::free(s);
				nsCOMPtr<nsIDocument> doc = do_QueryInterface(pDOMDocument);
				if (doc) 
				{
					nsCAutoString spec;
					doc->GetDocumentURI()->GetSpec(spec);
					printf("Document URI=\"%s\"\n",spec.get());
				}
			}

  pURI = nsnull;
  pChannel = nsnull;
  pInputStream = nsnull;
  pDOMParser = nsnull;
  pDOMDocument = nsnull;
  //pXMLHttpRequest = nsnull;

  return NS_OK;
}

nsresult ParseXmlFile1() 
{
	nsCOMPtr<nsIDOMHTMLDocument> xml_doc;
	
	nsresult rv;
  rv = nsComponentManager::CreateInstance(kIDOMDocumentIID, nsnull,
                                                   kIDOMHTMLDocumentIID,
                                                   getter_AddRefs(xml_doc));

	//PRBool result;
	//xml_doc->SetAsync(PR_FALSE);
	//xml_doc->Load(MozStr("file:///c:/mozilla/mozilla/obj-i586-pc-msvc/dist/bin/res/samples/test0.html"), &result);

	nsIDOMElement* doc_elem;
	xml_doc->GetDocumentElement(&doc_elem);
	
	nsAutoString name, value;
	doc_elem->GetNodeName(name);
	doc_elem->GetNodeValue(value);
	_ILOG(name);_ILOG(value);
	
	nsCOMPtr<nsILocalFile> file;
  NS_NewNativeLocalFile(nsDependentCString("c:\\data3.xml"), TRUE, getter_AddRefs(file));

  nsCOMPtr<nsILocalFile> dataPath;
  NS_NewNativeLocalFile(nsDependentCString("c:\\"), TRUE, getter_AddRefs(dataPath));
  

	const char* const kPersistContractID = "@mozilla.org/embedding/browser/nsWebBrowserPersist;1";
	nsCOMPtr<nsIWebBrowserPersist> persist(do_CreateInstance(kPersistContractID, &rv));
    if (!persist)
        return rv;

		persist->SaveDocument(xml_doc, file, dataPath, "text/html", nsIWebBrowserPersist::ENCODE_FLAGS_FORMATTED | nsIWebBrowserPersist::ENCODE_FLAGS_CR_LINEBREAKS | nsIWebBrowserPersist::ENCODE_FLAGS_LF_LINEBREAKS ,0);
	return rv;
}
/*
	l_id_matched = ProcessRule_MatchID(p_rule_node, p_dom_node);

	if (l_id_matched)	// The CHECK a2) 
	{
		l_tag_matched = ProcessRule_MatchTag(p_rule_node, p_dom_node);
		if (l_tag_matched)	// The CHECK b4)
		{
			l_pos_matched = ProcessRule_MatchPosition(p_rule_node, p_dom_node);
			if (l_pos_matched)	// The CHECK c4)
			{
				l_attr_matched = ProcessRule_MatchAttributes(p_rule_node, p_dom_node);
				if (l_attr_matched)	// The CHECK d1)
				{
					l_sib_matched = ProcessRule_MatchSiblings(p_rule_node, p_dom_node);
					if (l_sib_matched)	// The CHECK e7)
					{
						l_mixed_children_matched = ProcessRule_MatchMixedChildren(p_rule_node, p_dom_node);
					}
					else								// The CHECK e8)
					{
						l_mixed_children_matched = ProcessRule_MatchMixedChildren(p_rule_node, p_dom_node);
					}
				}
				else								// The CHECK d2)
				{
					l_sib_matched = ProcessRule_MatchSiblings(p_rule_node, p_dom_node);
				}
			}
			else								// The CHECK c2)
			{
				l_sib_matched = ProcessRule_MatchSiblings(p_rule_node, p_dom_node);
				if (l_sib_matched)	// The CHECK e3)
					return true;
				else								// The CHECK e4)
				{
					l_mixed_children_matched = ProcessRule_MatchMixedChildren(p_rule_node, p_dom_node);
				}
			}
		}
		else 								// The CHECK b3)
		{
			l_pos_matched = ProcessRule_MatchPosition(p_rule_node, p_dom_node);
			if (lpos__matched)	// The CHECK c5)
			{
				l_sib_matched = ProcessRule_MatchSiblings(p_rule_node, p_dom_node);
				if (l_sib_matched)	// The CHECK e9)
					return true; // probably true
				else								// The CHECK e10)
				{
					l_mixed_children_matched = ProcessRule_MatchMixedChildren(p_rule_node, p_dom_node);
				}
			}
			else 								// The CHECK c1)
			{
				l_sib_matched = ProcessRule_MatchSiblings(p_rule_node, p_dom_node);
				if (l_sib_matched)	// The CHECK e1)
				{
					l_sib_content_matched = ProcessRule_MatchSiblingsContent(p_rule_node, p_dom_node);
				}
				else								// The CHECK e2)
				{
					l_content_matched = ProcessRule_MatchContent(p_rule_node, p_dom_node);
				}
			}
		}
	}
	else							// The CHECK a1) 
	{
		l_tag_matched = ProcessRule_MatchTag(p_rule_node, p_dom_node);
		if(l_tag_matched)	// The CHECK b4)
		{
			l_pos_matched = ProcessRule_MatchPosition(p_rule_node, p_dom_node);
			if (l_pos_matched)	// The CHECK c6)
			{
				l_sib_matched = ProcessRule_MatchSiblings(p_rule_node, p_dom_node);
				if (l_sib_matched)
				{
						l_content_matched = ProcessRule_MatchContent(p_rule_node, p_dom_node);
				}
				else
				{
						l_content_matched = ProcessRule_MatchContent(p_rule_node, p_dom_node);
				}
			}
			else								// The CHECK c3)
			{
				l_sib_matched = ProcessRule_MatchSiblings(p_rule_node, p_dom_node);
				if (l_sib_matched)	// The CHECK e5)
				{
					l_content_matched = ProcessRule_MatchContent(p_rule_node, p_dom_node);
				}
				else								// The CHECK e6)
				{
					l_mixed_children_matched = ProcessRule_MatchMixedChildren(p_rule_node, p_dom_node);
				}
			}
		}
		else							// The CHECK b2)
			return false;
	}

		bool l_has_id = PR_FALSE;
	bool l_id_matched = PR_FALSE;
	bool l_tag_matched = PR_FALSE;
	bool l_pos_matched = PR_FALSE;
	bool l_attr_matched = PR_FALSE;
	bool l_sib_matched = PR_FALSE;
	bool l_sib_content_matched = PR_FALSE;
	bool l_content_matched = PR_FALSE;
	bool l_mixed_children_matched = PR_FALSE;
	
	l_id_matched = ProcessRule_MatchID(p_rule_node, p_dom_node);
	l_tag_matched = ProcessRule_MatchTag(p_rule_node, p_dom_node);

	// The CHECK a1), b2)
	// If id and tag are different then we are looking at the wrong node
	if (!l_id_matched && !l_tag_matched)
		return false; // 0%

	l_pos_matched = ProcessRule_MatchPosition(p_rule_node, p_dom_node);
	l_attr_matched = ProcessRule_MatchAttributes(p_rule_node, p_dom_node);
	l_sib_matched = ProcessRule_MatchSiblings(p_rule_node, p_dom_node);

	// The CHECK a2) b1) 
	// if both id and tag matched then mostly this is the node
	if (l_id_matched && l_tag_matched)
	{ // continue checks based on position and siblings

		// The CHECK c4) d1) e7)
		// if id, tag, pos and sib matched, then it is close to 100% sure this is the node
		if (l_pos_matched && l_sib_matched)
		{// continue checking based on attr

			// if id, tag, pos, sib and attributes matched, then it is 100% sure this is the node
			if (l_attr_matched)
				return true; // 100% sure

			// if id, tag, pos, sib matched, but not attributes, then it is 90% sure this is the node
			return true; // 90+% matched, calculate based on number of attributes that matched
		}

		// if only position matched, but siblings did not match, then check f the siblings are rearranged
		if (l_pos_matched) // sib did not match
		{
			l_mixed_children_matched = ProcessRule_MatchMixedChildren(p_rule_node, p_dom_node);

			// The CHECK c4) d2) e7)
			// if the siblings are misplaced
			if (l_mixed_children_matched)
			{
				// if id, tag, pos, attr matched and the siblings are only misplaced then 100% sure
				if (l_attr_matched)
					return true; // true 100%
				else
					return true; // true 90%, calculate based on number of attributes that matched
			}

			// if id, tag, pos matched, but not able to find siblings then 
			//	a) probably siblings are removed/replaced
			//	b) we are looking at the wrong node. May be there is someother node with same id, tag and pos
			//		 so check with parents
			if (l_attr_matched)
				return true; // probably true 50% - some problem with siblings

			// the attributes also did not match
			return true; // probably true 30% - calculate based on number of attributes that matched
		}

		// if id, tag, sib matched, but position is changed, may be due to nodes moving up and down
		if (l_sib_matched) // pos did not match
		{
			if (l_attr_matched)
				return true; // 100% sure, only the order has been changed

			return true; // 90% Sure,  calculate based on number of attributes that matched
		}

		// if id, tag matched, but not position and siblings, check if they are misplaced
		l_mixed_children_matched = ProcessRule_MatchMixedChildren(p_rule_node, p_dom_node);
		if (l_mixed_children_matched) // pos and sib are different, but atleast found siblings
		{
			// check with nodes around the sibling
			if (l_attr_matched)
				return true; // 50% sure, position is screwed, but siblings atleast exist

			return true; // 40% Sure,  calculate based on number of attributes that matched
		}
		
		return false; // NOT SURE, position, siblings are not getting mactched
	}

	// tag matched but not id, may be id was not set or it was changed (auto generated)
	if (l_tag_matched) 
	{
		l_content_matched = ProcessRule_MatchContent(p_rule_node, p_dom_node);

		// the id did not match, but the tag and content matched. return true based on pos, sib, mixed and attr
		if (l_content_matched)
		{
			l_mixed_children_matched = ProcessRule_MatchMixedChildren(p_rule_node, p_dom_node);
			if (l_pos_matched && l_sib_matched)
			{
				if (l_attr_matched)
					return true; // 95% sure, everything is fine, but only id has changed

				return true; // 85+% Sure, calculate based on number of attributes that matched
			}
			else if (l_pos_matched && !l_sib_matched)
			{
				// may be the siblings are thrown around
				if (l_mixed_children_matched) // pos is fine and sibblings are misplaced  
				{
					// check with nodes around the sibling
					if (l_attr_matched)
						return true; // 80% sure, id and siblings are screwed, but siblings atleast exist

					return true; // 70+% Sure,  calculate based on number of attributes that matched
				}

				return true; // 60% tag, position, content matched, id and siblings are probably changed/removed
			}
			else if (!l_pos_matched && !l_sib_matched)
			{// id, pos, sib are not matching
				if (l_mixed_children_matched) // atleast sibblings were found
				{
					return false; 	// have to check with nodes around the sibling
				}

				return false; // only tag and content seem ok, have to check for similar nodes in the tree. If not found this one should be good
			}
			else if (!l_pos_matched && l_sib_matched)
			{
					if (l_attr_matched)
						return true; // 80% sure, id and siblings are screwed, but siblings atleast exist

					return true; // 70+% Sure,  calculate based on number of attributes that matched
			}
			return true; // 95% sure, The id should have changed
		}
		else
			return false;
		
		l_sib_content_matched = ProcessRule_MatchSiblingsContent(p_rule_node, p_dom_node);
		if (l_pos_matched && l_sib_matched && l_sib_content_matched)
			return true; // 75% sure, The position and siblings are ok. But the id should have changed, the content should have changed.

*/

/*

void RulesProcessorInitiator(nsITimer* timer, void* Closure);
void RulesProcessorInitiator(nsITimer* timer, void* Closure)
{
	CRuleProcessor::ProcessRules(); 
}


void RulesProcessorInitiator(void* Closure);
void RulesProcessorInitiator(void* Closure)
{
	CRuleProcessor::ProcessRules(); 
}
*/

/*
void CRuleProcessor::InitRulesProcessingTimer()
{
	CRuleProcessor* rules = new CRuleProcessor();
	rules->LoadRules();
	
	PRThread* thread = PR_CreateThread(PR_USER_THREAD,
                     RulesProcessorInitiator,
                     nsnull,
                     PR_PRIORITY_NORMAL,
                     PR_LOCAL_THREAD,
                     PR_UNJOINABLE_THREAD,
                     1024);

	nsCOMPtr<nsITimer> timer = do_CreateInstance(NS_TIMER_CONTRACTID);
	nsTimerCallbackFunc func  = RulesProcessorInitiator;
	PRUint32 delay  = 10;

	nsresult rv = timer->InitWithFuncCallback(func, (void*)_rules_doc ,delay, nsITimer::TYPE_REPEATING_SLACK);
}

nsIDOMElement* CRuleProcessor::ProcessRule_SpotNode(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node)
{
		// MATCH
		if (p_dom_node == nsnull)
			return nsnull;

		// check tag name
		nsAutoString l_rule_dom_node_tag = _rules_doc->GetNodeAttributeValue(p_rule_node, MozStr("__rulenode_tagname"));
		nsAutoString l_dom_tag = _rules_doc->GetNodeName(p_dom_node);
		_ILOG(l_rule_dom_node_tag);_ILOG(l_dom_tag);
		if (l_dom_tag != l_rule_dom_node_tag)
			return nsnull;

		// check position
		PRInt32 error;
		nsAutoString rule_node_pos = _rules_doc->GetNodeAttributeValue(p_rule_node, MozStr("__rulenode_position")); 
		PRInt32 rule_dome_node_pos = rule_node_pos.ToInteger(&error);
		PRInt32 dom_node_pos = _rules_doc->GetNodePosition(p_dom_node); 
		if (rule_dome_node_pos != dom_node_pos)
			return nsnull;

		// Check the Children
		nsIDOMNodeList* rule_node_list, *dom_node_list;
		p_dom_node->GetChildNodes(&dom_node_list); 

		p_rule_node->GetChildNodes(&rule_node_list);
		PRUint32 len = 0; rule_node_list->GetLength(&len);
		if (len != 2)
			return p_dom_node;

		nsIDOMElement* l_sib_node;
		rule_node_list->Item(0, (nsIDOMNode**) &l_sib_node);
		nsIDOMElement* l_rule_node;
		rule_node_list->Item(1, (nsIDOMNode**) &l_rule_node);


		PRUint32 len_dom = 0; dom_node_list->GetLength(&len_dom);

		// -1 since, the rule node will always have a siblings node
		for (PRUint32 idx = 0; idx < len_dom; idx++)
		{
			nsIDOMElement *child_dom;
			dom_node_list->Item(idx, (nsIDOMNode**) &child_dom);
			
			nsIDOMElement* spotted_node = ProcessRule_SpotNode(l_rule_node, child_dom);
			if (spotted_node != nsnull) 
					return spotted_node;
		}

		return nsnull;
}
bool CRuleProcessor::SetURL()
{
	// Get the Owner document
	nsAutoString URL;
	nsIDOMDocument* l_doc;
	m_dom_node->GetOwnerDocument(&l_doc);

	// set the URL
	nsIDOMHTMLDocument* html_doc;
	l_doc->QueryInterface(kIDOMHTMLDocumentIID, (void**) &html_doc);
	html_doc->GetURL(URL);
	_rules_doc->AddAttribute(m_rule_root_node, MozStr("__ruleurl"), URL);

	_ILOG(URL);

	return PR_TRUE;
}

void CRuleProcessor::LoadRules()
{
	if (_rules_doc != nsnull)
		return;

	_rules_doc = new CMyMozXmlDocument();

	nsAutoString xml_rules_uri;
	xml_rules_uri.Append(NS_LITERAL_STRING(XMLDB_PATH));
	xml_rules_uri.Append(NS_LITERAL_STRING(RULES_FILE));

	if (_rules_doc->LoadFromFile(xml_rules_uri))
		return;

	// else create one
	_rules_doc->CreateEmptyDocument();

}

void CRuleProcessor::SaveRules()
{
	_rules_doc->Save();
}

bool CRuleProcessor::LoadRule(nsAutoString RuleName)
{
	_ILOG(RuleName);
	nsIDOMElement* node = _rules_doc->GetNode(RuleName); 

	nsAutoString name, value;
	node->GetNodeName(name);
	node->GetNodeValue(value);

	_ILOG(name);_ILOG(value);

	return nsnull;
}	

bool CRuleProcessor::SaveRule()
{
	_rules_doc->Save();
	return PR_TRUE;
}

// =================== UNUSED FUNCTIONS ===================
bool CRuleProcessor::SetNodeName()
{
	nsAutoString dom_node_tag_name;
	m_dom_node->GetNodeName(dom_node_tag_name);
	_ILOG(dom_node_tag_name);

	return PR_TRUE;
}

nsAutoString CRuleProcessor::SetNodeID()
{
	nsAutoString dom_node_id;
	nsIDOMNamedNodeMap* attrs;
	m_dom_node->GetAttributes(&attrs);

	nsIDOMElement* id_attr;
	if (attrs == nsnull)
		return NS_LITERAL_STRING("");

	attrs->GetNamedItem(nsString(NS_LITERAL_STRING("id")), (nsIDOMNode**) &id_attr);
	if (id_attr == nsnull)
		return NS_LITERAL_STRING("");

	id_attr->GetNodeValue(dom_node_id);
	_ILOG(dom_node_id);

	return dom_node_id;
}

bool CRuleProcessor::SetNodeValue()
{
	nsAutoString dom_node_val;
	nsIDOMElement* child;
	m_dom_node->GetFirstChild((nsIDOMNode**) &child);

	child->GetNodeValue(dom_node_val);
	_ILOG(dom_node_val);

	return PR_TRUE;
}


PRInt32 CRuleProcessor::ProcessRule_MatchChildren(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node)
{
		// Check the Children
		nsIDOMNodeList* rule_node_list, *dom_node_list;
		p_rule_node->GetChildNodes(&rule_node_list);
		p_dom_node->GetChildNodes(&dom_node_list); 

		PRUint32 len = 0; rule_node_list->GetLength(&len);
		PRUint32 len_dom = 0; dom_node_list->GetLength(&len);

		if (len == len_dom)
		{
			for (PRUint32 idx = 0; idx < len; idx++)
			{
				nsIDOMElement* child_rule, *child_dom;
				rule_node_list->Item(idx, (nsIDOMNode**) &child_rule);
				dom_node_list->Item(idx, (nsIDOMNode**) &child_dom);

				if (!ProcessRule_MatchID(child_rule, child_dom))
					return 0;
			}
		}

		return 10;
}

PRFloat64 CRuleProcessor::ProcessRule_GetIdentityMatchPercentage(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node)
{
	PRInt32 l_id_matched = 0;
	PRInt32 l_tag_matched = 0;
	
	l_id_matched = ProcessRule_MatchID(p_rule_node, p_dom_node);
	l_tag_matched = ProcessRule_MatchTagName(p_rule_node, p_dom_node);

	PRInt32 total_count = l_id_matched*MW_ID + l_tag_matched*	MW_TAG;
	PRFloat64 percentage = (total_count*100)/((MW_ID + MW_TAG)*10);
	return percentage;
}

PRFloat64 CRuleProcessor::ProcessRule_GetStructureMatchPercentage(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node)
{
	PRInt32 l_depth_matched = 0;
	PRInt32 l_pos_matched = 0;
	PRFloat64 l_child_count_matched = 0;
	
	l_depth_matched = ProcessRule_MatchDepth(p_rule_node, p_dom_node);
	l_pos_matched = ProcessRule_MatchPosition(p_rule_node, p_dom_node);
	l_child_count_matched = ProcessRule_MatchChildCount(p_rule_node, p_dom_node);

	PRInt32 total_count = l_depth_matched * MW_DEPTH + l_pos_matched*MW_POS + l_child_count_matched*MW_CHILDCOUNT;
	PRFloat64 percentage = (total_count/((MW_DEPTH + MW_POS + MW_CHILDCOUNT)*10))*100;
	return percentage;
}

PRFloat64 CRuleProcessor::ProcessRule_GetSiblingsMatchPercentage(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node)
{
	return ProcessRule_MatchSiblings(p_rule_node, p_dom_node);
}

PRFloat64 CRuleProcessor::ProcessRule_GetContentMatchPercentage(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node)
{
	return 100;
}
*/

/*
nsIDOMElement* CRuleProcessor::ProcessRule_SpotNode(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node)
{
		// MATCH
		if (p_dom_node == nsnull)
			return nsnull;

		// check tag name
		nsAutoString l_rule_dom_node_tag = _rules_doc->GetNodeAttributeValue(p_rule_node, MozStr("__rulenode_tagname"));
		nsAutoString l_dom_tag = _rules_doc->GetNodeName(p_dom_node);
		_ILOG(l_rule_dom_node_tag);_ILOG(l_dom_tag);
		if (l_dom_tag != l_rule_dom_node_tag)
			return nsnull;

		// check position
		PRInt32 error;
		nsAutoString rule_node_pos = _rules_doc->GetNodeAttributeValue(p_rule_node, MozStr("__rulenode_position")); 
		PRInt32 rule_dome_node_pos = rule_node_pos.ToInteger(&error);
		PRInt32 dom_node_pos = _rules_doc->GetNodePosition(p_dom_node); 
		if (rule_dome_node_pos != dom_node_pos)
			return nsnull;

		// Check the Children
		nsIDOMNodeList* rule_node_list, *dom_node_list;
		p_dom_node->GetChildNodes(&dom_node_list); 

		p_rule_node->GetChildNodes(&rule_node_list);
		PRUint32 len = 0; rule_node_list->GetLength(&len);
		if (len != 2)
			return p_dom_node;

		nsIDOMElement* l_sib_node;
		rule_node_list->Item(0, (nsIDOMNode**) &l_sib_node);
		nsIDOMElement* l_rule_node;
		rule_node_list->Item(1, (nsIDOMNode**) &l_rule_node);


		PRUint32 len_dom = 0; dom_node_list->GetLength(&len_dom);

		// -1 since, the rule node will always have a siblings node
		for (PRUint32 idx = 0; idx < len_dom; idx++)
		{
			nsIDOMElement *child_dom;
			dom_node_list->Item(idx, (nsIDOMNode**) &child_dom);
			
			nsIDOMElement* spotted_node = ProcessRule_SpotNode(l_rule_node, child_dom);
			if (spotted_node != nsnull) 
					return spotted_node;
		}

		return nsnull;
}
*/

/*
PRInt32 CRuleProcessor::ProcessRule_MatchChildren(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node)
{
		// Check the Children
		nsIDOMNodeList* rule_node_list, *dom_node_list;
		p_rule_node->GetChildNodes(&rule_node_list);
		p_dom_node->GetChildNodes(&dom_node_list); 

		PRUint32 len = 0; rule_node_list->GetLength(&len);
		PRUint32 len_dom = 0; dom_node_list->GetLength(&len);

		if (len == len_dom)
		{
			for (PRUint32 idx = 0; idx < len; idx++)
			{
				nsIDOMElement* child_rule, *child_dom;
				rule_node_list->Item(idx, (nsIDOMNode**) &child_rule);
				dom_node_list->Item(idx, (nsIDOMNode**) &child_dom);

				if (!ProcessRule_MatchID(child_rule, child_dom))
					return 0;
			}
		}

		return 10;
}

PRFloat64 CRuleProcessor::ProcessRule_GetIdentityMatchPercentage(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node)
{
	PRInt32 l_id_matched = 0;
	PRInt32 l_tag_matched = 0;
	
	l_id_matched = ProcessRule_MatchID(p_rule_node, p_dom_node);
	l_tag_matched = ProcessRule_MatchTagName(p_rule_node, p_dom_node);

	PRInt32 total_count = l_id_matched*MW_ID + l_tag_matched*	MW_TAG;
	PRFloat64 percentage = (total_count*100)/((MW_ID + MW_TAG)*10);
	return percentage;
}

PRFloat64 CRuleProcessor::ProcessRule_GetStructureMatchPercentage(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node)
{
	PRInt32 l_depth_matched = 0;
	PRInt32 l_pos_matched = 0;
	PRFloat64 l_child_count_matched = 0;
	
	l_depth_matched = ProcessRule_MatchDepth(p_rule_node, p_dom_node);
	l_pos_matched = ProcessRule_MatchPosition(p_rule_node, p_dom_node);
	l_child_count_matched = ProcessRule_MatchChildCount(p_rule_node, p_dom_node);

	PRInt32 total_count = l_depth_matched * MW_DEPTH + l_pos_matched*MW_POS + l_child_count_matched*MW_CHILDCOUNT;
	PRFloat64 percentage = (total_count/((MW_DEPTH + MW_POS + MW_CHILDCOUNT)*10))*100;
	return percentage;
}

PRFloat64 CRuleProcessor::ProcessRule_GetSiblingsMatchPercentage(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node)
{
	return ProcessRule_MatchSiblings(p_rule_node, p_dom_node);
}

PRFloat64 CRuleProcessor::ProcessRule_GetContentMatchPercentage(nsIDOMElement* p_rule_node, nsIDOMElement* p_dom_node)
{
	return 100;
}
*/

void LoadHTML(char* URL) 
{
  nsresult                     rv;
  nsCOMPtr<nsIDOMDocument>     pDOMDocument;
  nsCOMPtr<nsIXMLHttpRequest>  pXMLHttpRequest;

  // Synchronous Read
  pXMLHttpRequest = do_CreateInstance( NS_XMLHTTPREQUEST_CONTRACTID,
                                      &rv );

  if (NS_SUCCEEDED( rv )) 
	{
    const nsAString& emptyStr = EmptyString();
    rv = pXMLHttpRequest->OpenRequest( NS_LITERAL_CSTRING("GET"),
                                       nsDependentCString(URL),
                                       PR_FALSE, emptyStr, emptyStr );

    if (NS_SUCCEEDED( rv )) 
		{
      rv = pXMLHttpRequest->Send( nsnull );

      if (NS_SUCCEEDED( rv )) 
			{
        rv = pXMLHttpRequest->GetResponseXML( getter_AddRefs( pDOMDocument ) );

        if (NS_SUCCEEDED( rv )) 
				{
          if (pDOMDocument) 
					{
            printf( "Synchronous read successful, DOMDocument created\n");
          }
          else 
					{
            printf( "Synchronous read NOT successful, DOMDocument NOT created\n");
          }
        }
        else 
				{
          printf( "pXMLHttpRequest->GetResponseXML failed - %08X\n", rv );
        }
      }
      else 
			{
        printf( "pXMLHttpRequest->Send failed for %08X\n", rv );
      }
    }
    else 
		{
      printf( "pXMLHttpRequest->OpenRequest failed for - %08X\n", rv );
    }
  }
  else 
	{
    printf( "do_CreateInstance of XMLHttpRequest failed for %08X\n", rv );
  }

	if (pDOMDocument) 
	{
		nsCOMPtr<nsIDOMElement> element;
		pDOMDocument->GetDocumentElement(getter_AddRefs(element));
		nsAutoString tagName;
		if (element) element->GetTagName(tagName);
		char *s = ToNewCString(tagName);
		printf("Document element=\"%s\"\n",s);
		nsCRT::free(s);
		nsCOMPtr<nsIDocument> doc = do_QueryInterface(pDOMDocument);
		if (doc) 
		{
			nsCAutoString spec;
			doc->GetDocumentURI()->GetSpec(spec);
			printf("Document URI=\"%s\"\n",spec.get());
		}

		nsIDOMElement* elem;
		rv = pDOMDocument->CreateElement(MozStr("TestNode"), &elem);
		
		nsIDOMNode* old;
		rv = element->AppendChild(elem, &old);
  }

	
  const nsAString& emptyStr = EmptyString();
   rv = pXMLHttpRequest->OpenRequest( NS_LITERAL_CSTRING("POST"),
                                       nsDependentCString(URL),
                                       PR_FALSE, emptyStr, emptyStr );

  rv = pXMLHttpRequest->Send((nsIVariant*) &pDOMDocument);

  pDOMDocument = nsnull;
  pXMLHttpRequest = nsnull;

  return;
}

	// 1 Check based On ID and other information (goto The CHECK)
	//		1.1 If multiple doms with same ID exist then check each one (goto The CHECK) and pick the closest match
	// 2 If no node ID exist start from current top (initially the root) and 
	//		2.1 Check both rule and dom parent nodes (goto The CHECK)
	//		2.2 if match found check child rule and dom node till match is found
	//				2.2.1 if match failed somewhere down the line, goto the root of this search and do the hungry search (2.3-2.9)
	//				2.2.2 if match still failed, skip this matching process and goto, 2.3
	//		2.3 if match node not found, that is rule parent node is not found, check for the rule parent node in the dom child nodes of the parent rule node
	//		2.4 if match is found continue with rule parent node and dom child node of the parent dom node
	//				2.4.1 if match failed somewhere down the line, goto the root of this search and do the hungry search (2.2-2.9)
	//				2.4.2 if match still failed, skip this matching process and goto, 2.5
	//		2.5 if match not found, search for the parent rule node in grand child of the parent dom node and so on till a match is found
	//		2.6 if match is found continue with rule parent node and grand child dom node of the parent dom node
	//				2.6.1 if match failed somewhere down the line, goto the root of this search and do the hungry search (2.2-2.9)
	//				2.6.2 if match still failed, skip this matching process and goto, 2.7
	//		2.7 if match is not found, skip the parent rule node and start again (2) with each of the child parent rules with the parent dom node
	//		2.8 if match not found use the grand child of the rule node and start with the parent dom node
	// IMPORTANT: So it is important to go back to the last good match (step) and continue
	//
	// Every time 2 dom nodes are to be checked , the following formula should be used.
	// The CHECK: Check based on
	//		a) ID (either exists or not)
	//				1) If different check b
	//				2) if same check b
	//		b) tag name 
	//				1) if same and a) is true then check c)
	//				2) if different and a) is false then return false
	//				3) if different and a) is true the check c
	//				4) if same and a) is false check next child. if not match found return here. 
	//		c) position 
	//				1) if position is different and a) is true,  b) is false, then check e)
	//				2) if position is different and a) is true,  b) is true, then check e)
	//				3) if position is different and a) is false  b) is true, then check e) 
	//				4) if position is same      and a) is true   b) is true, check d)
	//				5) if position is same      and a) is true   b) is false , check e)
	//				6) if position is same      and a) is false  b) is true, check e)
	//		d) attributes 
	//				1) if same and c4) then check e)
	//				2) if different and c4) then check e)
  //		e) check siblings
	//				1) if same and c1) then check g) 
	//				2) if different and c1) then check f) 
	//				3) if same and c2) then return true
	//				4) if different and c2) then h)
	//				5) if same and c3) then check f)
	//				6) if different and c3) then check h)
	//			  7) if same and d1) then return true
	//				8) if different and d1) then check h)
	//				9) if same and c5) then return partial true
	//				10) if different and c5) then check h) 
	//				11) if same and c6) then check f) 
	//				12) if different and c6) then check f)
	//			  13) if same and d2) then g)
	//				14) if different and d2) then check h)
	//		f) content and children/content
	//				1) if similar and e2) 
	//		g) siblings children_content
	//		h) mixed children
	// If this check is positive then return the dom node or the parent and continue, till the dom node is found
	//
	// ******* When node is found check if the content has changed. If YES ALERT!! *******
	//
	// When node is not found at all, then either
	//		a) the node was not rendered
	//		b) the node was changed
	//		c) got the wrong page
	//			c1) may be something like session id was needed and got an page saying invalid
	//			c2) may be "log in required" page was needed
	//			c3) may be the page no longer exists.
	//			c4) may be the page is restricted for the server, but not for the client.
	//		d) It was always difficult to spot the node !!! I will never be able to spot it. But would like to keep a list.
	//		e) may be it is toggling between 2 or 3 structures
	//
	// Other things
	//		1) save the changed content in the rule node, as new version
	//		2) save the new structure of the dom node if different. May be store the old structures. Will be useful for e)
	//    3) save the times: last load time, last changed time, last 5 changed times, average change time, current interval, expected time of change, actual change of time, time remaining to refresh
	//    4) need to store the last n links and the path required to load the node in case for c)
	//		5) need to support post data
	//				1) if alert is set on a page which is result of a post then the post form is to be kept tracked
	//				2) that form will be starting point and the result node of automatic post on the result page will be checked.
	//				3) post data has to be stored somewhere in the form
	//				4) post form can also be shown to the user on request.
	//				5) in that case new post data has to stored and the old one archived.
	//		6) Auto Refreshes to be disabled.
	//		7) Redirect to be handled gracefully
	//		8) need to store the images, scripts, styles etc for the alert dom node in a unique place
	//		9) obviously the page/or the dom node is precreated and also can be instantly refreshed.


	// ******************* HTML Tags List *************************
	// Content/Leaf Tags
// a, Anchor
// abbr, Span
/*

// attributes

// nodes
a, Anchor
abbr, Span
acronym, Span)
address, Span)
b, Span)
bdo, Span)
bgsound, Span)
big, Span)
blink, Span)
center, Span)
cite, Span)
code, Span)
counter, Span)
dd, Span)
dfn, Span)
dt, Span)
em, Span)

applet, Applet)
area, Area)
base, SharedLeaf)
basefont, BaseFont)
blockquote, Quote)
body, Body)
br, BR)
button, Button)
caption, TableCaption)
col, TableCol)
colgroup, TableCol)
del, Del)
dir, Directory)
div, Div)
dl, DList)
embed, SharedLeaf)
endnote, Span)
fieldset, FieldSet)
font, Font)
form, NOTUSED)
frame, Frame)
frameset, FrameSet)
h1, Heading)
h2, Heading)
h3, Heading)
h4, Heading)
h5, Heading)
h6, Heading)
head, Head)
hr, HR)
html, Html)
i, Span)
iframe, IFrame)
image, Span)
img, Image)
input, Input)
ins, Ins)
isindex, SharedLeaf)
kbd, Span)
keygen, Span)
label, Label)
legend, Legend)
li, LI)
link, Link)
listing, Span)
map, Map)
marquee, Div)
menu, Menu)
meta, Meta)
multicol, Span)
nobr, Span)
noembed, Div)
noframes, Div)
noscript, Div)
object, Object)
ol, OList)
optgroup, OptGroup)
option, Option)
p, Paragraph)
param, SharedLeaf)
parsererror, Div)
plaintext, Span)
pre, Pre)
q, Quote)
s, Span)
samp, Span)
script, Script)
select, Select)
server, Span)
small, Span)
sound, Span)
sourcetext, Div)
spacer, SharedLeaf)
span, Span)
strike, Span)
strong, Span)
style, Style)
sub, Span)
sup, Span)
table, Table)
tbody, TableSection)
td, TableCell)
textarea, TextArea)
tfoot, TableSection)
th, TableCell)
thead, TableSection)
title, Title)
tr, TableRow)
tt, Span)
u, Span)
ul, UList)
var, Span)
wbr, SharedLeaf)
xmp, Span)

	// Container/Node Tags
*/
	
/*
(_baseHref, NS_HTML_BASE_HREF)
(_baseTarget, NS_HTML_BASE_TARGET)
(a, "a")
(abbr, "abbr")
(above, "above")
(accept, "accept")
(acceptcharset, "accept-charset")
(accesskey, "accesskey")
(action, "action")
(align, "align")
(alink, "alink")
(alt, "alt")
(applet, "applet")
(archive, "archive")
(area, "area")
(autocheck, "autocheck")
(axis, "axis")
(background, "background")
(base, "base")
(below, "below")
(bdo, "bdo")
(bgcolor, "bgcolor")
(big, "big")
(blockquote, "blockquote")
(body, "body")
(border, "border")
(bordercolor, "bordercolor")
(bottommargin, "bottommargin")
(bottompadding, "bottompadding")
(br, "br")
(b, "b")
(button, "button")
(caption, "caption")
(cellpadding, "cellpadding")
(cellspacing, "cellspacing")
(ch, "ch")
(_char, "char")
(charoff, "charoff")
(charset, "charset")
(checked, "checked")
(cite, "cite")
(kClass, "class")
(classid, "classid")
(clear, "clear")
(clip, "clip")
(code, "code")
(codebase, "codebase")
(codetype, "codetype")
(color, "color")
(col, "col")
(colgroup, "colgroup")
(cols, "cols")
(colspan, "colspan")
(combobox, "combobox")
(compact, "compact")
(content, "content")
(contentLocation, "content-location")
(coords, "coords")
(dd, "dd")
(defaultchecked, "defaultchecked")
(defaultselected, "defaultselected")
(defaultvalue, "defaultvalue")
(declare, "declare")
(defer, "defer")
(dir, "dir")
(div, "div")
(disabled, "disabled")
(dl, "dl")
(dt, "dt")
   
(datetime, "datetime")
(data, "data")
(dfn, "dfn")
(em, "em")
(embed, "embed")
(encoding, "encoding")
(enctype, "enctype")
(_event, "event")
(face, "face")
(fieldset, "fieldset")
(font, "font")
(fontWeight, "font-weight")
(_for, "for")
(form, "form")
(frame, "frame")
(frameborder, "frameborder")
(frameset, "frameset")
(gutter, "gutter")
(h1, "h1")
(h2, "h2")
(h3, "h3")
(h4, "h4")
(h5, "h5")
(h6, "h6")
(head, "head")
(headerContentLanguage, "content-language")
(headerContentScriptType, "content-script-type")
(headerContentStyleType, "content-style-type")
(headerContentType, "content-type")
(headerDefaultStyle, "default-style")
(headerWindowTarget, "window-target")
(headers, "headers")
(height, "height")
(hidden, "hidden")
(hr, "hr")
(href, "href")
(hreflang, "hreflang")
(hspace, "hspace")
(html, "html")
(httpEquiv, "http-equiv")
(i, "i")
(id, "id")
(iframe, "iframe")
(ilayer, "ilayer")
(img, "img")
(index, "index")
(input, "input")
(isindex, "isindex")
(ismap, "ismap")
(label, "label")
(lang, "lang")
(layer, "layer")
(layout, "layout")
(li, "li")
(link, "link")
(left, "left")
(leftmargin, "leftmargin")
(leftpadding, "leftpadding")
(legend, "legend")
(length, "length")
(longdesc, "longdesc")
(lowsrc, "lowsrc")
(map, "map")
(marginheight, "marginheight")
(marginwidth, "marginwidth")
(marquee, "marquee")
(maxlength, "maxlength")
(mayscript, "mayscript")
(media, "media")
(menu, "menu")
(meta, "meta")
(method, "method")
(msthemecompatible, "msthemecompatible")
(multicol, "multicol")
(multiple, "multiple")
(name, "name")
(noembed, "noembed")
(noframes, "noframes")
(nohref, "nohref")
(noresize, "noresize")
(noscript, "noscript")
(noshade, "noshade")
(nowrap, "nowrap")
(object, "object")
(ol, "ol")
(optgroup, "optgroup")
(option, "option")
(overflow, "overflow")
(p, "p")
(pagex, "pagex")
(pagey, "pagey")
(param, "param")
(plaintext, "plaintext")
(pointSize, "point-size")
(pre, "pre")
(profile, "profile")
(prompt, "prompt")
(readonly, "readonly")
(refresh, "refresh")
(rel, "rel")
(repeat, "repeat")
(rev, "rev")
(rightmargin, "rightmargin")
(rightpadding, "rightpadding")
(rows, "rows")
(rowspan, "rowspan")
(rules, "rules")
(s, "s")
(scheme, "scheme")
(scope, "scope")
(script, "script")
(scrolling, "scrolling")
(select, "select")
(selected, "selected")
(selectedindex, "selectedindex")
(setcookie, "set-cookie")
(shape, "shape")
(size, "size")
(small, "small")
(spacer, "spacer")
(span, "span")
(src, "src")
(standby, "standby")
(start, "start")
(strike, "strike")
(strong, "strong")
(style, "style")
(summary, "summary")
(tabindex, "tabindex")
(table, "table")
(target, "target")
(tbody, "tbody")
(td, "td")
(tfoot, "tfoot")
(thead, "thead")
(text, "text")
(textarea, "textarea")
(th, "th")
(title, "title")
(top, "top")
(topmargin, "topmargin")
(toppadding, "toppadding")
(tr, "tr")
(tt, "tt")
(type, "type")
(u, "u")
(ul, "ul")
(usemap, "usemap")
(valign, "valign")
(value, "value")
(valuetype, "valuetype")
(variable, "variable")
(vcard_name, "vcard_name")
(version, "version")
(visibility, "visibility")
(vlink, "vlink")
(vspace, "vspace")
(wbr, "wbr")
(width, "width")
(wrap, "wrap")
(wrappedFramePseudo, ":-moz-wrapped-frame")
(xmp, "xmp")
(zindex, "zindex")
(z_index, "z-index")

Searching for '_ATTR('...
nsGenericHTMLElement.h(892):#define NS_IMPL_STRING_ATTR(_class, _method, _atom)                  \
nsGenericHTMLElement.h(934):#define NS_IMPL_BOOL_ATTR(_class, _method, _atom)                     \
nsGenericHTMLElement.h(953):#define NS_IMPL_INT_ATTR(_class, _method, _atom)                    \
nsGenericHTMLElement.h(977):#define NS_IMPL_URI_ATTR(_class, _method, _atom)                    \

nsHTMLAnchorElement.cpp(210):NS_IMPL_STRING_ATTR(nsHTMLAnchorElement, Charset, charset)
nsHTMLAnchorElement.cpp(211):NS_IMPL_STRING_ATTR(nsHTMLAnchorElement, Coords, coords)
nsHTMLAnchorElement.cpp(212):NS_IMPL_URI_ATTR(nsHTMLAnchorElement, Href, href)
nsHTMLAnchorElement.cpp(213):NS_IMPL_STRING_ATTR(nsHTMLAnchorElement, Hreflang, hreflang)
nsHTMLAnchorElement.cpp(214):NS_IMPL_STRING_ATTR(nsHTMLAnchorElement, Name, name)
nsHTMLAnchorElement.cpp(215):NS_IMPL_STRING_ATTR(nsHTMLAnchorElement, Rel, rel)
nsHTMLAnchorElement.cpp(216):NS_IMPL_STRING_ATTR(nsHTMLAnchorElement, Rev, rev)
nsHTMLAnchorElement.cpp(217):NS_IMPL_STRING_ATTR(nsHTMLAnchorElement, Shape, shape)
nsHTMLAnchorElement.cpp(218):NS_IMPL_INT_ATTR(nsHTMLAnchorElement, TabIndex, tabindex)
nsHTMLAnchorElement.cpp(219):NS_IMPL_STRING_ATTR(nsHTMLAnchorElement, Type, type)
nsHTMLAnchorElement.cpp(220):NS_IMPL_STRING_ATTR(nsHTMLAnchorElement, AccessKey, accesskey)

nsHTMLAppletElement.cpp(184):NS_IMPL_STRING_ATTR(nsHTMLAppletElement, Align, align)
nsHTMLAppletElement.cpp(185):NS_IMPL_STRING_ATTR(nsHTMLAppletElement, Alt, alt)
nsHTMLAppletElement.cpp(186):NS_IMPL_STRING_ATTR(nsHTMLAppletElement, Archive, archive)
nsHTMLAppletElement.cpp(187):NS_IMPL_STRING_ATTR(nsHTMLAppletElement, Code, code)
nsHTMLAppletElement.cpp(188):NS_IMPL_URI_ATTR(nsHTMLAppletElement, CodeBase, codebase)
nsHTMLAppletElement.cpp(189):NS_IMPL_STRING_ATTR(nsHTMLAppletElement, Height, height)
nsHTMLAppletElement.cpp(190):NS_IMPL_INT_ATTR(nsHTMLAppletElement, Hspace, hspace)
nsHTMLAppletElement.cpp(191):NS_IMPL_STRING_ATTR(nsHTMLAppletElement, Name, name)
nsHTMLAppletElement.cpp(192):NS_IMPL_STRING_ATTR(nsHTMLAppletElement, Object, object)
nsHTMLAppletElement.cpp(193):NS_IMPL_INT_ATTR(nsHTMLAppletElement, Vspace, vspace)
nsHTMLAppletElement.cpp(194):NS_IMPL_STRING_ATTR(nsHTMLAppletElement, Width, width)

nsHTMLAreaElement.cpp(193):NS_IMPL_STRING_ATTR(nsHTMLAreaElement, AccessKey, accesskey)
nsHTMLAreaElement.cpp(194):NS_IMPL_STRING_ATTR(nsHTMLAreaElement, Alt, alt)
nsHTMLAreaElement.cpp(195):NS_IMPL_STRING_ATTR(nsHTMLAreaElement, Coords, coords)
nsHTMLAreaElement.cpp(196):NS_IMPL_URI_ATTR(nsHTMLAreaElement, Href, href)
nsHTMLAreaElement.cpp(197):NS_IMPL_BOOL_ATTR(nsHTMLAreaElement, NoHref, nohref)
nsHTMLAreaElement.cpp(198):NS_IMPL_STRING_ATTR(nsHTMLAreaElement, Shape, shape)
nsHTMLAreaElement.cpp(199):NS_IMPL_INT_ATTR(nsHTMLAreaElement, TabIndex, tabindex)

nsHTMLBRElement.cpp(155):NS_IMPL_STRING_ATTR(nsHTMLBRElement, Clear, clear)

nsHTMLBaseFontElement.cpp(147):NS_IMPL_STRING_ATTR(nsHTMLBaseFontElement, Color, color)
nsHTMLBaseFontElement.cpp(148):NS_IMPL_STRING_ATTR(nsHTMLBaseFontElement, Face, face)

	nsHTMLBodyElement.cpp(374):NS_IMPL_URI_ATTR(nsHTMLBodyElement, Background, background)
nsHTMLBodyElement.cpp(376):#define NS_IMPL_HTMLBODY_COLOR_ATTR(attr_, func_, default_)         \
nsHTMLBodyElement.cpp(407):NS_IMPL_HTMLBODY_COLOR_ATTR(vlink, VLink, VisitedLinkColor)
nsHTMLBodyElement.cpp(408):NS_IMPL_HTMLBODY_COLOR_ATTR(alink, ALink, ActiveLinkColor)
nsHTMLBodyElement.cpp(409):NS_IMPL_HTMLBODY_COLOR_ATTR(link, Link, LinkColor)
nsHTMLBodyElement.cpp(412):NS_IMPL_HTMLBODY_COLOR_ATTR(text, Text, Color)

	nsHTMLButtonElement.cpp(217):NS_IMPL_STRING_ATTR(nsHTMLButtonElement, AccessKey, accesskey)
nsHTMLButtonElement.cpp(218):NS_IMPL_BOOL_ATTR(nsHTMLButtonElement, Disabled, disabled)
nsHTMLButtonElement.cpp(219):NS_IMPL_STRING_ATTR(nsHTMLButtonElement, Name, name)
nsHTMLButtonElement.cpp(220):NS_IMPL_INT_ATTR(nsHTMLButtonElement, TabIndex, tabindex)
nsHTMLButtonElement.cpp(221):NS_IMPL_STRING_ATTR(nsHTMLButtonElement, Value, value)

	nsHTMLDListElement.cpp(147):NS_IMPL_BOOL_ATTR(nsHTMLDListElement, Compact, compact)

	nsHTMLDelElement.cpp(146):NS_IMPL_STRING_ATTR(nsHTMLDelElement, Cite, cite)
nsHTMLDelElement.cpp(147):NS_IMPL_STRING_ATTR(nsHTMLDelElement, DateTime, datetime)

nsHTMLDirectoryElement.cpp(161):NS_IMPL_BOOL_ATTR(nsHTMLDirectoryElement, Compact, compact)
nsHTMLDivElement.cpp(160):NS_IMPL_STRING_ATTR(nsHTMLDivElement, Align, align)

	nsHTMLFontElement.cpp(159):NS_IMPL_STRING_ATTR(nsHTMLFontElement, Color, color)
nsHTMLFontElement.cpp(160):NS_IMPL_STRING_ATTR(nsHTMLFontElement, Face, face)
nsHTMLFontElement.cpp(161):NS_IMPL_STRING_ATTR(nsHTMLFontElement, Size, size)

nsHTMLFormElement.cpp(558):NS_IMPL_STRING_ATTR(nsHTMLFormElement, AcceptCharset, acceptcharset)
nsHTMLFormElement.cpp(559):NS_IMPL_STRING_ATTR(nsHTMLFormElement, Action, action)
nsHTMLFormElement.cpp(560):NS_IMPL_STRING_ATTR(nsHTMLFormElement, Enctype, enctype)
nsHTMLFormElement.cpp(561):NS_IMPL_STRING_ATTR(nsHTMLFormElement, Method, method)
nsHTMLFormElement.cpp(562):NS_IMPL_STRING_ATTR(nsHTMLFormElement, Name, name)

	nsHTMLFrameElement.cpp(173):NS_IMPL_STRING_ATTR(nsHTMLFrameElement, FrameBorder, frameborder)
nsHTMLFrameElement.cpp(174):NS_IMPL_URI_ATTR(nsHTMLFrameElement, LongDesc, longdesc)
nsHTMLFrameElement.cpp(175):NS_IMPL_STRING_ATTR(nsHTMLFrameElement, MarginHeight, marginheight)
nsHTMLFrameElement.cpp(176):NS_IMPL_STRING_ATTR(nsHTMLFrameElement, MarginWidth, marginwidth)
nsHTMLFrameElement.cpp(177):NS_IMPL_STRING_ATTR(nsHTMLFrameElement, Name, name)
nsHTMLFrameElement.cpp(178):NS_IMPL_BOOL_ATTR(nsHTMLFrameElement, NoResize, noresize)
nsHTMLFrameElement.cpp(179):NS_IMPL_STRING_ATTR(nsHTMLFrameElement, Scrolling, scrolling)
nsHTMLFrameElement.cpp(180):NS_IMPL_URI_ATTR(nsHTMLFrameElement, Src, src)

nsHTMLFrameSetElement.cpp(213):NS_IMPL_STRING_ATTR(nsHTMLFrameSetElement, Cols, cols)
nsHTMLFrameSetElement.cpp(214):NS_IMPL_STRING_ATTR(nsHTMLFrameSetElement, Rows, rows)

nsHTMLHRElement.cpp(162):NS_IMPL_STRING_ATTR(nsHTMLHRElement, Align, align)
nsHTMLHRElement.cpp(163):NS_IMPL_BOOL_ATTR(nsHTMLHRElement, NoShade, noshade)
nsHTMLHRElement.cpp(164):NS_IMPL_STRING_ATTR(nsHTMLHRElement, Size, size)
nsHTMLHRElement.cpp(165):NS_IMPL_STRING_ATTR(nsHTMLHRElement, Width, width)
nsHTMLHRElement.cpp(166):NS_IMPL_STRING_ATTR(nsHTMLHRElement, Color, color)

nsHTMLHeadElement.cpp(146):NS_IMPL_URI_ATTR(nsHTMLHeadElement, Profile, profile)
nsHTMLHeadingElement.cpp(156):NS_IMPL_STRING_ATTR(nsHTMLHeadingElement, Align, align)
nsHTMLHtmlElement.cpp(149):NS_IMPL_STRING_ATTR(nsHTMLHtmlElement, Version, version)

nsHTMLIFrameElement.cpp(216):NS_IMPL_STRING_ATTR(nsHTMLIFrameElement, Align, align)
nsHTMLIFrameElement.cpp(217):NS_IMPL_STRING_ATTR(nsHTMLIFrameElement, FrameBorder, frameborder)
nsHTMLIFrameElement.cpp(218):NS_IMPL_STRING_ATTR(nsHTMLIFrameElement, Height, height)
nsHTMLIFrameElement.cpp(219):NS_IMPL_URI_ATTR(nsHTMLIFrameElement, LongDesc, longdesc)
nsHTMLIFrameElement.cpp(220):NS_IMPL_STRING_ATTR(nsHTMLIFrameElement, MarginHeight, marginheight)
nsHTMLIFrameElement.cpp(221):NS_IMPL_STRING_ATTR(nsHTMLIFrameElement, MarginWidth, marginwidth)
nsHTMLIFrameElement.cpp(222):NS_IMPL_STRING_ATTR(nsHTMLIFrameElement, Name, name)
nsHTMLIFrameElement.cpp(223):NS_IMPL_STRING_ATTR(nsHTMLIFrameElement, Scrolling, scrolling)
nsHTMLIFrameElement.cpp(224):NS_IMPL_URI_ATTR(nsHTMLIFrameElement, Src, src)
nsHTMLIFrameElement.cpp(225):NS_IMPL_STRING_ATTR(nsHTMLIFrameElement, Width, width)

nsHTMLImageElement.cpp(260):NS_IMPL_STRING_ATTR(nsHTMLImageElement, Name, name)
nsHTMLImageElement.cpp(261):NS_IMPL_STRING_ATTR(nsHTMLImageElement, Align, align)
nsHTMLImageElement.cpp(262):NS_IMPL_STRING_ATTR(nsHTMLImageElement, Alt, alt)
nsHTMLImageElement.cpp(263):NS_IMPL_STRING_ATTR(nsHTMLImageElement, Border, border)
nsHTMLImageElement.cpp(264):NS_IMPL_INT_ATTR(nsHTMLImageElement, Hspace, hspace)
nsHTMLImageElement.cpp(265):NS_IMPL_BOOL_ATTR(nsHTMLImageElement, IsMap, ismap)
nsHTMLImageElement.cpp(266):NS_IMPL_URI_ATTR(nsHTMLImageElement, LongDesc, longdesc)
nsHTMLImageElement.cpp(267):NS_IMPL_STRING_ATTR(nsHTMLImageElement, Lowsrc, lowsrc)
nsHTMLImageElement.cpp(268):NS_IMPL_URI_ATTR(nsHTMLImageElement, Src, src)
nsHTMLImageElement.cpp(269):NS_IMPL_STRING_ATTR(nsHTMLImageElement, UseMap, usemap)
nsHTMLImageElement.cpp(270):NS_IMPL_INT_ATTR(nsHTMLImageElement, Vspace, vspace)

nsHTMLInputElement.cpp(582):NS_IMPL_STRING_ATTR(nsHTMLInputElement, DefaultValue, value)
nsHTMLInputElement.cpp(583):NS_IMPL_BOOL_ATTR(nsHTMLInputElement, DefaultChecked, checked)
nsHTMLInputElement.cpp(584):NS_IMPL_STRING_ATTR(nsHTMLInputElement, Accept, accept)
nsHTMLInputElement.cpp(585):NS_IMPL_STRING_ATTR(nsHTMLInputElement, AccessKey, accesskey)
nsHTMLInputElement.cpp(586):NS_IMPL_STRING_ATTR(nsHTMLInputElement, Align, align)
nsHTMLInputElement.cpp(587):NS_IMPL_STRING_ATTR(nsHTMLInputElement, Alt, alt)
nsHTMLInputElement.cpp(588)://NS_IMPL_BOOL_ATTR(nsHTMLInputElement, Checked, checked)
nsHTMLInputElement.cpp(589):NS_IMPL_BOOL_ATTR(nsHTMLInputElement, Disabled, disabled)
nsHTMLInputElement.cpp(590):NS_IMPL_INT_ATTR(nsHTMLInputElement, MaxLength, maxlength)
nsHTMLInputElement.cpp(591):NS_IMPL_STRING_ATTR(nsHTMLInputElement, Name, name)
nsHTMLInputElement.cpp(592):NS_IMPL_BOOL_ATTR(nsHTMLInputElement, ReadOnly, readonly)
nsHTMLInputElement.cpp(593):NS_IMPL_STRING_ATTR(nsHTMLInputElement, Src, src)
nsHTMLInputElement.cpp(594):NS_IMPL_INT_ATTR(nsHTMLInputElement, TabIndex, tabindex)
nsHTMLInputElement.cpp(595):NS_IMPL_STRING_ATTR(nsHTMLInputElement, UseMap, usemap)
nsHTMLInputElement.cpp(596)://NS_IMPL_STRING_ATTR(nsHTMLInputElement, Value, value)
nsHTMLInsElement.cpp(146):NS_IMPL_STRING_ATTR(nsHTMLInsElement, Cite, cite)
nsHTMLInsElement.cpp(147):NS_IMPL_STRING_ATTR(nsHTMLInsElement, DateTime, datetime)
nsHTMLLIElement.cpp(156):NS_IMPL_STRING_ATTR(nsHTMLLIElement, Type, type)
nsHTMLLIElement.cpp(157):NS_IMPL_INT_ATTR(nsHTMLLIElement, Value, value)
nsHTMLLabelElement.cpp(202):NS_IMPL_STRING_ATTR(nsHTMLLabelElement, AccessKey, accesskey)
nsHTMLLabelElement.cpp(203):NS_IMPL_STRING_ATTR(nsHTMLLabelElement, HtmlFor, _for)
nsHTMLLegendElement.cpp(174):NS_IMPL_STRING_ATTR(nsHTMLLegendElement, AccessKey, accesskey)
nsHTMLLegendElement.cpp(175):NS_IMPL_STRING_ATTR(nsHTMLLegendElement, Align, align)
nsHTMLLinkElement.cpp(232):NS_IMPL_STRING_ATTR(nsHTMLLinkElement, Charset, charset)
nsHTMLLinkElement.cpp(233):NS_IMPL_URI_ATTR(nsHTMLLinkElement, Href, href)
nsHTMLLinkElement.cpp(234):NS_IMPL_STRING_ATTR(nsHTMLLinkElement, Hreflang, hreflang)
nsHTMLLinkElement.cpp(235):NS_IMPL_STRING_ATTR(nsHTMLLinkElement, Media, media)
nsHTMLLinkElement.cpp(236):NS_IMPL_STRING_ATTR(nsHTMLLinkElement, Rel, rel)
nsHTMLLinkElement.cpp(237):NS_IMPL_STRING_ATTR(nsHTMLLinkElement, Rev, rev)
nsHTMLLinkElement.cpp(238):NS_IMPL_STRING_ATTR(nsHTMLLinkElement, Target, target)
nsHTMLLinkElement.cpp(239):NS_IMPL_STRING_ATTR(nsHTMLLinkElement, Type, type)
nsHTMLMapElement.cpp(210):NS_IMPL_STRING_ATTR(nsHTMLMapElement, Name, name)
nsHTMLMenuElement.cpp(162):NS_IMPL_BOOL_ATTR(nsHTMLMenuElement, Compact, compact)
nsHTMLMetaElement.cpp(148):NS_IMPL_STRING_ATTR(nsHTMLMetaElement, Content, content)
nsHTMLMetaElement.cpp(149):NS_IMPL_STRING_ATTR(nsHTMLMetaElement, HttpEquiv, httpEquiv)
nsHTMLMetaElement.cpp(150):NS_IMPL_STRING_ATTR(nsHTMLMetaElement, Name, name)
nsHTMLMetaElement.cpp(151):NS_IMPL_STRING_ATTR(nsHTMLMetaElement, Scheme, scheme)
nsHTMLOListElement.cpp(154):NS_IMPL_BOOL_ATTR(nsHTMLOListElement, Compact, compact)
nsHTMLOListElement.cpp(155):NS_IMPL_INT_ATTR(nsHTMLOListElement, Start, start)
nsHTMLOListElement.cpp(156):NS_IMPL_STRING_ATTR(nsHTMLOListElement, Type, type)
nsHTMLObjectElement.cpp(221):NS_IMPL_STRING_ATTR(nsHTMLObjectElement, Code, code)
nsHTMLObjectElement.cpp(222):NS_IMPL_STRING_ATTR(nsHTMLObjectElement, Align, align)
nsHTMLObjectElement.cpp(223):NS_IMPL_STRING_ATTR(nsHTMLObjectElement, Archive, archive)
nsHTMLObjectElement.cpp(224):NS_IMPL_STRING_ATTR(nsHTMLObjectElement, Border, border)
nsHTMLObjectElement.cpp(225):NS_IMPL_URI_ATTR(nsHTMLObjectElement, CodeBase, codebase)
nsHTMLObjectElement.cpp(226):NS_IMPL_STRING_ATTR(nsHTMLObjectElement, CodeType, codetype)
nsHTMLObjectElement.cpp(227):NS_IMPL_URI_ATTR(nsHTMLObjectElement, Data, data)
nsHTMLObjectElement.cpp(228):NS_IMPL_BOOL_ATTR(nsHTMLObjectElement, Declare, declare)
nsHTMLObjectElement.cpp(229):NS_IMPL_STRING_ATTR(nsHTMLObjectElement, Height, height)
nsHTMLObjectElement.cpp(230):NS_IMPL_INT_ATTR(nsHTMLObjectElement, Hspace, hspace)
nsHTMLObjectElement.cpp(231):NS_IMPL_STRING_ATTR(nsHTMLObjectElement, Name, name)
nsHTMLObjectElement.cpp(232):NS_IMPL_STRING_ATTR(nsHTMLObjectElement, Standby, standby)
nsHTMLObjectElement.cpp(233):NS_IMPL_INT_ATTR(nsHTMLObjectElement, TabIndex, tabindex)
nsHTMLObjectElement.cpp(234):NS_IMPL_STRING_ATTR(nsHTMLObjectElement, Type, type)
nsHTMLObjectElement.cpp(235):NS_IMPL_STRING_ATTR(nsHTMLObjectElement, UseMap, usemap)
nsHTMLObjectElement.cpp(236):NS_IMPL_INT_ATTR(nsHTMLObjectElement, Vspace, vspace)
nsHTMLObjectElement.cpp(237):NS_IMPL_STRING_ATTR(nsHTMLObjectElement, Width, width)
nsHTMLOptGroupElement.cpp(177):NS_IMPL_BOOL_ATTR(nsHTMLOptGroupElement, Disabled, disabled)
nsHTMLOptGroupElement.cpp(178):NS_IMPL_STRING_ATTR(nsHTMLOptGroupElement, Label, label)
nsHTMLOptionElement.cpp(359):NS_IMPL_BOOL_ATTR(nsHTMLOptionElement, DefaultSelected, selected)
nsHTMLOptionElement.cpp(360):NS_IMPL_STRING_ATTR(nsHTMLOptionElement, Label, label)
nsHTMLOptionElement.cpp(361)://NS_IMPL_STRING_ATTR(nsHTMLOptionElement, Value, value)
nsHTMLOptionElement.cpp(362):NS_IMPL_BOOL_ATTR(nsHTMLOptionElement, Disabled, disabled)
nsHTMLParagraphElement.cpp(160):NS_IMPL_STRING_ATTR(nsHTMLParagraphElement, Align, align)
nsHTMLPreElement.cpp(158):NS_IMPL_INT_ATTR(nsHTMLPreElement, Width, width)
nsHTMLQuoteElement.cpp(145):NS_IMPL_URI_ATTR(nsHTMLQuoteElement, Cite, cite)
nsHTMLScriptElement.cpp(546):NS_IMPL_STRING_ATTR(nsHTMLScriptElement, Charset, charset)
nsHTMLScriptElement.cpp(547):NS_IMPL_BOOL_ATTR(nsHTMLScriptElement, Defer, defer)
nsHTMLScriptElement.cpp(548):NS_IMPL_URI_ATTR(nsHTMLScriptElement, Src, src)
nsHTMLScriptElement.cpp(549):NS_IMPL_STRING_ATTR(nsHTMLScriptElement, Type, type)
nsHTMLScriptElement.cpp(550):NS_IMPL_STRING_ATTR(nsHTMLScriptElement, HtmlFor, _for)
nsHTMLScriptElement.cpp(551):NS_IMPL_STRING_ATTR(nsHTMLScriptElement, Event, _event)
nsHTMLSelectElement.cpp(1151)://NS_IMPL_INT_ATTR(nsHTMLSelectElement, SelectedIndex, selectedindex)
nsHTMLSelectElement.cpp(1637):NS_IMPL_BOOL_ATTR(nsHTMLSelectElement, Disabled, disabled)
nsHTMLSelectElement.cpp(1638):NS_IMPL_BOOL_ATTR(nsHTMLSelectElement, Multiple, multiple)
nsHTMLSelectElement.cpp(1639):NS_IMPL_STRING_ATTR(nsHTMLSelectElement, Name, name)
nsHTMLSelectElement.cpp(1640):NS_IMPL_INT_ATTR(nsHTMLSelectElement, Size, size)
nsHTMLSelectElement.cpp(1641):NS_IMPL_INT_ATTR(nsHTMLSelectElement, TabIndex, tabindex)

	nsHTMLSharedElement.cpp(195):NS_IMPL_STRING_ATTR(nsHTMLSharedLeafElement, Align, align)
nsHTMLSharedElement.cpp(196):NS_IMPL_STRING_ATTR(nsHTMLSharedLeafElement, Height, height)
nsHTMLSharedElement.cpp(197):NS_IMPL_STRING_ATTR(nsHTMLSharedLeafElement, Width, width)
nsHTMLSharedElement.cpp(198):NS_IMPL_STRING_ATTR(nsHTMLSharedLeafElement, Name, name)
nsHTMLSharedElement.cpp(199):NS_IMPL_STRING_ATTR(nsHTMLSharedLeafElement, Type, type)
nsHTMLSharedElement.cpp(200):NS_IMPL_STRING_ATTR(nsHTMLSharedLeafElement, Src, src)
nsHTMLSharedElement.cpp(203):NS_IMPL_STRING_ATTR(nsHTMLSharedLeafElement, Value, value)
nsHTMLSharedElement.cpp(204):NS_IMPL_STRING_ATTR(nsHTMLSharedLeafElement, ValueType, valuetype)
nsHTMLSharedElement.cpp(207):NS_IMPL_STRING_ATTR(nsHTMLSharedLeafElement, Prompt, prompt)
nsHTMLSharedElement.cpp(219):NS_IMPL_URI_ATTR(nsHTMLSharedLeafElement, Href, href)

nsHTMLSharedElement.cpp(220):NS_IMPL_STRING_ATTR(nsHTMLSharedLeafElement, Target, target)
nsHTMLSharedLeafElement.cpp(198):NS_IMPL_STRING_ATTR(nsHTMLSharedLeafElement, Align, align)
nsHTMLSharedLeafElement.cpp(199):NS_IMPL_STRING_ATTR(nsHTMLSharedLeafElement, Height, height)
nsHTMLSharedLeafElement.cpp(200):NS_IMPL_STRING_ATTR(nsHTMLSharedLeafElement, Width, width)
nsHTMLSharedLeafElement.cpp(201):NS_IMPL_STRING_ATTR(nsHTMLSharedLeafElement, Name, name)
nsHTMLSharedLeafElement.cpp(202):NS_IMPL_STRING_ATTR(nsHTMLSharedLeafElement, Type, type)
nsHTMLSharedLeafElement.cpp(203):NS_IMPL_STRING_ATTR(nsHTMLSharedLeafElement, Src, src)
nsHTMLSharedLeafElement.cpp(206):NS_IMPL_STRING_ATTR(nsHTMLSharedLeafElement, Value, value)
nsHTMLSharedLeafElement.cpp(207):NS_IMPL_STRING_ATTR(nsHTMLSharedLeafElement, ValueType, valuetype)
nsHTMLSharedLeafElement.cpp(210):NS_IMPL_STRING_ATTR(nsHTMLSharedLeafElement, Prompt, prompt)
nsHTMLSharedLeafElement.cpp(222):NS_IMPL_URI_ATTR(nsHTMLSharedLeafElement, Href, href)
nsHTMLSharedLeafElement.cpp(223):NS_IMPL_STRING_ATTR(nsHTMLSharedLeafElement, Target, target)

nsHTMLSharedObjectElement.cpp(200):NS_IMPL_STRING_ATTR(nsHTMLObjectElement, Code, code)
nsHTMLSharedObjectElement.cpp(201):NS_IMPL_STRING_ATTR(nsHTMLObjectElement, Align, align)
nsHTMLSharedObjectElement.cpp(202):NS_IMPL_STRING_ATTR(nsHTMLObjectElement, Archive, archive)
nsHTMLSharedObjectElement.cpp(203):NS_IMPL_STRING_ATTR(nsHTMLObjectElement, Border, border)
nsHTMLSharedObjectElement.cpp(204):NS_IMPL_URI_ATTR(nsHTMLObjectElement, CodeBase, codebase)
nsHTMLSharedObjectElement.cpp(205):NS_IMPL_STRING_ATTR(nsHTMLObjectElement, CodeType, codetype)
nsHTMLSharedObjectElement.cpp(206):NS_IMPL_URI_ATTR(nsHTMLObjectElement, Data, data)
nsHTMLSharedObjectElement.cpp(207):NS_IMPL_BOOL_ATTR(nsHTMLObjectElement, Declare, declare)
nsHTMLSharedObjectElement.cpp(208):NS_IMPL_STRING_ATTR(nsHTMLObjectElement, Height, height)
nsHTMLSharedObjectElement.cpp(209):NS_IMPL_INT_ATTR(nsHTMLObjectElement, Hspace, hspace)
nsHTMLSharedObjectElement.cpp(210):NS_IMPL_STRING_ATTR(nsHTMLObjectElement, Name, name)
nsHTMLSharedObjectElement.cpp(211):NS_IMPL_STRING_ATTR(nsHTMLObjectElement, Standby, standby)
nsHTMLSharedObjectElement.cpp(212):NS_IMPL_INT_ATTR(nsHTMLObjectElement, TabIndex, tabindex)
nsHTMLSharedObjectElement.cpp(213):NS_IMPL_STRING_ATTR(nsHTMLObjectElement, Type, type)
nsHTMLSharedObjectElement.cpp(214):NS_IMPL_STRING_ATTR(nsHTMLObjectElement, UseMap, usemap)
nsHTMLSharedObjectElement.cpp(215):NS_IMPL_INT_ATTR(nsHTMLObjectElement, Vspace, vspace)
nsHTMLSharedObjectElement.cpp(216):NS_IMPL_STRING_ATTR(nsHTMLObjectElement, Width, width)

nsHTMLStyleElement.cpp(223):NS_IMPL_STRING_ATTR(nsHTMLStyleElement, Media, media)
nsHTMLStyleElement.cpp(224):NS_IMPL_STRING_ATTR(nsHTMLStyleElement, Type, type)
nsHTMLTableCaptionElement.cpp(157):NS_IMPL_STRING_ATTR(nsHTMLTableCaptionElement, Align, align)
nsHTMLTableCellElement.cpp(288):NS_IMPL_STRING_ATTR(nsHTMLTableCellElement, Abbr, abbr)
nsHTMLTableCellElement.cpp(289):NS_IMPL_STRING_ATTR(nsHTMLTableCellElement, Axis, axis)
nsHTMLTableCellElement.cpp(290):NS_IMPL_STRING_ATTR(nsHTMLTableCellElement, BgColor, bgcolor)
nsHTMLTableCellElement.cpp(292):NS_IMPL_STRING_ATTR(nsHTMLTableCellElement, ChOff, charoff)
nsHTMLTableCellElement.cpp(294):NS_IMPL_STRING_ATTR(nsHTMLTableCellElement, Headers, headers)
nsHTMLTableCellElement.cpp(295):NS_IMPL_STRING_ATTR(nsHTMLTableCellElement, Height, height)
nsHTMLTableCellElement.cpp(296):NS_IMPL_BOOL_ATTR(nsHTMLTableCellElement, NoWrap, nowrap)
nsHTMLTableCellElement.cpp(298):NS_IMPL_STRING_ATTR(nsHTMLTableCellElement, Scope, scope)
nsHTMLTableCellElement.cpp(300):NS_IMPL_STRING_ATTR(nsHTMLTableCellElement, Width, width)
nsHTMLTableColElement.cpp(169):NS_IMPL_STRING_ATTR(nsHTMLTableColElement, ChOff, charoff)
nsHTMLTableColElement.cpp(172):NS_IMPL_STRING_ATTR(nsHTMLTableColElement, Width, width)
nsHTMLTableElement.cpp(405):NS_IMPL_STRING_ATTR(nsHTMLTableElement, Align, align)
nsHTMLTableElement.cpp(406):NS_IMPL_STRING_ATTR(nsHTMLTableElement, BgColor, bgcolor)
nsHTMLTableElement.cpp(407):NS_IMPL_STRING_ATTR(nsHTMLTableElement, Border, border)
nsHTMLTableElement.cpp(408):NS_IMPL_STRING_ATTR(nsHTMLTableElement, CellPadding, cellpadding)
nsHTMLTableElement.cpp(409):NS_IMPL_STRING_ATTR(nsHTMLTableElement, CellSpacing, cellspacing)
nsHTMLTableElement.cpp(410):NS_IMPL_STRING_ATTR(nsHTMLTableElement, Frame, frame)
nsHTMLTableElement.cpp(411):NS_IMPL_STRING_ATTR(nsHTMLTableElement, Rules, rules)
nsHTMLTableElement.cpp(412):NS_IMPL_STRING_ATTR(nsHTMLTableElement, Summary, summary)
nsHTMLTableElement.cpp(413):NS_IMPL_STRING_ATTR(nsHTMLTableElement, Width, width)
nsHTMLTableRowElement.cpp(503):NS_IMPL_STRING_ATTR(nsHTMLTableRowElement, BgColor, bgcolor)
nsHTMLTableRowElement.cpp(505):NS_IMPL_STRING_ATTR(nsHTMLTableRowElement, ChOff, charoff)
nsHTMLTableSectionElement.cpp(174):NS_IMPL_STRING_ATTR(nsHTMLTableSectionElement, ChOff, charoff)
nsHTMLTextAreaElement.cpp(396):NS_IMPL_STRING_ATTR(nsHTMLTextAreaElement, AccessKey, accesskey)
nsHTMLTextAreaElement.cpp(397):NS_IMPL_INT_ATTR(nsHTMLTextAreaElement, Cols, cols)
nsHTMLTextAreaElement.cpp(398):NS_IMPL_BOOL_ATTR(nsHTMLTextAreaElement, Disabled, disabled)
nsHTMLTextAreaElement.cpp(399):NS_IMPL_STRING_ATTR(nsHTMLTextAreaElement, Name, name)
nsHTMLTextAreaElement.cpp(400):NS_IMPL_BOOL_ATTR(nsHTMLTextAreaElement, ReadOnly, readonly)
nsHTMLTextAreaElement.cpp(401):NS_IMPL_INT_ATTR(nsHTMLTextAreaElement, Rows, rows)
nsHTMLTextAreaElement.cpp(402):NS_IMPL_INT_ATTR(nsHTMLTextAreaElement, TabIndex, tabindex)
nsHTMLUListElement.cpp(159):NS_IMPL_BOOL_ATTR(nsHTMLUListElement, Compact, compact)
nsHTMLUListElement.cpp(160):NS_IMPL_STRING_ATTR(nsHTMLUListElement, Type, type)
*/
/*
struct MyMozHTMLTag
{
public:
	nsStringArray* attrs_important;
	nsStringArray* attrs_not_important;
};

nsVoidArray** tags_info = new nsVoidArray*[100];


nsVoidArray* AddTag(nsAutoString tag_name)
{
	(*tags_info)->AppendElement((void*) &tag_name);
	return tags_info[0];
}

void CreateHTMLInfo()
{
	MyMozHTMLTag* tag = new MyMozHTMLTag();
	tag->attrs_expected_not_to_match->AppendString(MozStr("href"));
	tag->attrs_expected_to_match->AppendString(MozStr("id"));

	nsVoidArray* elm = AddTag(MozStr("a"));
	elm->AppendElement((void*) tag);
}

void Get()
{
	MyMozHTMLTagInfo&(MyMozHTMLTagInfo*) tags_info[0][1];
}
*/
/*
nsresult CRuleProcessor::UpdateBaseURL()
{
  nsIDOMHTMLDocument* trg_doc;
  mAlertBrowser->GetDocument(trg_doc);

	nsCOMPtr<nsIDOMDocument> tdoc = do_QueryInterface(trg_doc);
	NS_STATIC_CAST(nsIDOMDocument*, trg_doc);

  // Look for an HTML <base> tag
  nsCOMPtr<nsIDOMNodeList> nodeList;
  nsresult rv = tdoc->GetElementsByTagName(NS_LITERAL_STRING("base"), getter_AddRefs(nodeList));
  NS_ENSURE_SUCCESS(rv, rv);

  nsCOMPtr<nsIDOMNode> baseNode;
  if (nodeList)
  {
    PRUint32 count;
    nodeList->GetLength(&count);
    if (count >= 1)
    {
      rv = nodeList->Item(0, getter_AddRefs(baseNode));
      NS_ENSURE_SUCCESS(rv, rv);
    }
  }
  // If no base tag, then set baseURL to the document's URL
  // This is very important, else relative URLs for links and images are wrong
  if (!baseNode)
  {
		_ILOG(m_url);
		nsCAutoString spec;
		mBrowser->mWebCrawler->mLastURL->GetSpec(spec);
//		doc->SetBaseURI(mBrowser->mWebCrawler->mLastURL);
//		doc->SetDocumentURI(mBrowser->mWebCrawler->mLastURL);
		_ILOG(spec.get());

		PRInt32 last_slash_pos = spec.RFind("/");
		spec.Left(spec, last_slash_pos+1);
		_ILOG(spec.get());
		
		nsIDOMNode* new_base;
		nsIDOMNode *retval_from_map;
		nsresult rv1 = tdoc->CreateElement(MozStr("BASE"), (nsIDOMElement**) &new_base);
		_rules_doc->DumpNode((nsIDOMElement*) new_base);
		nsCOMPtr<nsIDOMNodeList> nodeList;
		nsresult rv = tdoc->GetElementsByTagName(NS_LITERAL_STRING("head"), getter_AddRefs(nodeList));
		NS_ENSURE_SUCCESS(rv, rv);

		nsCOMPtr<nsIDOMNode> headNode;
		if (nodeList)
		{
			PRUint32 count;
			nodeList->GetLength(&count);
			if (count >= 1)
			{
				rv = nodeList->Item(0, getter_AddRefs(headNode));
				NS_ENSURE_SUCCESS(rv, rv);
			}
		}

		rv = headNode->AppendChild(new_base, &retval_from_map);

		nsIDOMAttr* href;
		rv = tdoc->CreateAttribute(MozStr("href"), &href);
		nsAutoString dest;
		CopyUTF8toUTF16(spec,dest);
		rv = href->SetValue(dest);
		nsIDOMNamedNodeMap* map;
		rv = new_base->GetAttributes(&map); 
		rv = map->SetNamedItem(href, &retval_from_map);
		
		//_rules_doc->DumpNode((nsIDOMElement*) domDoc);

  }
	else
		; // need to change the base uri
  return NS_OK;
}


void rvMainWindow::OnDesignMode_OnMouseClick_AddBasicElements_ChangeNodeSrc(nsIDOMHTMLElement* node)
{
	if (node == nsnull)
		return;

	nsString attr(NS_LITERAL_STRING("src"));
	nsString value(NS_LITERAL_STRING(""));
	node->GetAttribute(attr, value);
	
	char* cval= new char[256];
	cval = value.ToCString(cval, 256, 0);

	// get the file name
	PRInt32 pos = value.RFind("/");

	nsString file(NS_LITERAL_STRING(""));
	if (pos > 0)
		value.Right(file, value.Length()-pos-1);
	else
		file.Assign(value);

	char* r= new char[256];
	r = file.ToCString(r, 256, 0);


	nsString path(NS_LITERAL_STRING(""));
	path.AssignWithConversion(mDataPath);

	PRInt32 slashpos = path.RFind("/");
	if (slashpos == path.Length()-1)
		path.Mid(path, 0, value.Length()-2);

	nsString new_path(NS_LITERAL_STRING("file:///"));
	new_path.Append(path);
	new_path.AppendWithConversion("/");
	new_path.Append(file);

	new_path.ReplaceChar('\\', '/');
	char* path1= new char[256];
	path1 = new_path.ToCString(path1, 256, 0);

	node->SetAttribute(attr, new_path);
}

nsIDOMNode* rvMainWindow::OnDesignMode_OnMoveElement_GetPasteNode(nsIDOMNode* node) 
{
	if (node == nsnull)
		return nsnull;

	nsString name(NS_LITERAL_STRING(""));
	node->GetNodeName(name); 

	if (name.EqualsIgnoreCase("") || name.EqualsIgnoreCase("html") || name.EqualsIgnoreCase("body") || name.EqualsIgnoreCase("head")) 
		return nsnull;


	if (name.EqualsIgnoreCase("img"))
	{
		OnDesignMode_OnMouseClick_AddBasicElements_ChangeNodeSrc((nsIDOMHTMLElement*) node);
	}

	PRBool yes;
	node->HasChildNodes(&yes);
	if (yes)
	{
		nsIDOMNodeList* node_list;
		node->GetChildNodes(&node_list);
		PRUint32 cnt;
		node_list->GetLength(&cnt);
		for (PRInt32 idx=0; idx< cnt;idx++) 
		{
			nsIDOMNode* child;
			node_list->Item(idx, &child);
			nsString name(NS_LITERAL_STRING(""));
			child->GetNodeName(name); 
			if (name.EqualsIgnoreCase("img"))
			{
				OnDesignMode_OnMouseClick_AddBasicElements_ChangeNodeSrc((nsIDOMHTMLElement*) child);
			}
		}
	}

	return node;

	// The code below has been made obsolete to simply content selection.
	// In case if a need arises to traverse to the parent node this code can be enabled
	nsIDOMNode* parent;
	node->GetParentNode(&parent);
	if (parent == nsnull)
		return node;

	nsString namep(NS_LITERAL_STRING(""));
	parent->GetNodeName(namep); 
	
	// check the node name and decide to see the parents node
	while (!namep.EqualsIgnoreCase("") && !namep.EqualsIgnoreCase("html") && !namep.EqualsIgnoreCase("body") && !namep.EqualsIgnoreCase("head")) 
	{
		char* name1 = new char[12];
		name1 = name.ToCString(name1, 12, 0);
		
		char* name2 = new char[12];
		name2 = namep.ToCString(name2, 12, 0);

		// clone the parent 
		nsIDOMNode* clone_parent;
		parent->CloneNode(PR_FALSE, &clone_parent);

		// clone the child deep
		nsIDOMNode* clone_child;
		node->CloneNode(PR_TRUE, &clone_child);

		// add child to parent
		nsIDOMNode* old_node;
		clone_parent->AppendChild(clone_child, &old_node);
		
		// set parent to parent of parent
		nsIDOMNode* tmp_parent;
		parent->GetParentNode(&tmp_parent);

		// set parent to node
		node = clone_parent;
		parent = tmp_parent;

		// get the name of parent to parent
		if (parent == nsnull)
			return node;

		parent->GetNodeName(namep); 
	}

	return node;
}

void rvMainWindow::OnDesignMode_OnFirstClick_AddBasicElements() 
{
	if (nsnull != mDocShell) 
	{
		nsIDOMHTMLDocument* doc;
		GetDocument(doc);
		if (doc) 
		{
			nsIDOMElement* root;
			doc->GetDocumentElement(&root);
			if (nsnull != root) 
			{
				OnDesignMode_OnFirstClick_AddBasicElements_RecursingDom(root);
			}
		}
	}
}

void rvMainWindow::OnDesignMode_OnFirstClick_AddBasicElements_RecursingDom(nsIDOMElement* r) 
{
  if (r != nsnull)  
  {
		nsString tag;
		r->GetTagName(tag);

		if (tag.EqualsIgnoreCase("style")) 
		{
			nsIDOMHTMLDocument * aDocument;
			mParent->mActivePWWBrowser->GetDocument(aDocument);
			nsIDOMElement* docelem;
			aDocument->GetDocumentElement(&docelem);

			nsIDOMNode* clone, *old;
			r->CloneNode(PR_TRUE, &clone);
			docelem->AppendChild(clone, &old);

		}
		else
		{
			PRBool yes;
			r->HasChildNodes(&yes);
			if (yes)
			{
				nsIDOMNodeList* node_list;
				r->GetChildNodes(&node_list);
				PRUint32 cnt;
				node_list->GetLength(&cnt);
				for (PRInt32 idx=0; idx< cnt;idx++) 
				{
					nsIDOMNode* child;
					node_list->Item(idx, &child);
					OnDesignMode_OnFirstClick_AddBasicElements_RecursingDom((nsIDOMElement*) child);
				}
			}
		}
  }
}

*/
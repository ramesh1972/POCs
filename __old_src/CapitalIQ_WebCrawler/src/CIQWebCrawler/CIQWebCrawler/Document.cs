using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using mshtml;

namespace CIQWebCrawler
{
    /// <summary>
    /// The base class and entry point for crawling a specific URL.
    /// </summary>
    public class Document : IDocument
    {
        // The url for this doc
        string _mUrlToCrawl = String.Empty;

        // document elements
        public IElement _mDocRoot = null;
        public IHTMLDocument2 _mHTMLDoc = null;
        
        // the crawl code to process on this document
        CustomCrawlerCode _mCrawlerCode = null;
        CrawlerCode _mMatchedInstruction = null;

        // content savers which all the info to save content extracted out of this document
        List<DocumentSaver> _mContentSavers = new List<DocumentSaver>();
        
        // the resultant extracted resources/files
        public List<IFile> ResultFiles = null;
        
        /// <summary>
        /// Document represents a whole resrouce like an html page. Create an instance of this doc
        /// to crawl, parse, extract and save content for a given url.
        /// </summary>
        /// <param name="pCrawlerCode">The root CustomCode that will be used to extract the content and 
        /// also set the metadata that should be associated with the extracted content</param>
        public Document(CustomCrawlerCode pCrawlerCode) 
        {
            // store the url
            _mCrawlerCode = pCrawlerCode;
            Url = _mCrawlerCode.mUrlToCrawl;

            try
            {
                // Load the webpage using the helper object
                WebPageLoader pageLoader = new WebPageLoader(Url);
                _mHTMLDoc = pageLoader.GetHTMLDocument();
            }
            catch (Exception exp) // rethrow
            {
                throw exp;
            }
                 
            _Common();

            // A Document contains a root element. An element contains children which are themselves elements.
            // So a Tree structure is created here. Represents the DOM
            _mDocRoot = new Element(this);
            ((Element)_mDocRoot).SetUpElementTree(((IHTMLDocument3)_mHTMLDoc).documentElement);

            /*** This is the main internal driver function ***/
            _ParseExtractAndSaveContent();
        }

        /// <summary>
        /// Not to be called diretctly. This is called by the Click() on an element in another document
        /// </summary>
        /// <param name="url"></param>
        public Document(string url)
        {
            // store the url
            Url = url;

            try
            {
                // Load the webpage using the helper object
                WebPageLoader pageLoader = new WebPageLoader(url);
                _mHTMLDoc = pageLoader.GetHTMLDocument();
            }
            catch (Exception exp) // rethrow
            {
                throw exp;
            }

            _Common();
        }
        
        /// <summary>
        /// Disposes of the COM DOM object
        /// </summary>
        ~Document()
        {
            try
            {
                if (_mHTMLDoc != null)
                {
                    System.Runtime.InteropServices.Marshal.FinalReleaseComObject(_mHTMLDoc);
                    _mHTMLDoc = null;
                }
            }
            catch
            {
            }
            finally
            {
               
            }
        }

        /// <summary>
        /// Common things that need to be done on a fetched document
        /// </summary>
        private void _Common()
        {
            Uri original  = new Uri(Url);

            // convert all urls in hrefs, src attributes to Absolute paths.
            for (int idx = 0; idx < _mHTMLDoc.all.length; idx++)
            {
                IHTMLElement elem = _mHTMLDoc.all.item(idx);

                IHTMLDOMAttribute attrNode = ((IHTMLElement4) elem).getAttributeNode("href");
                if (attrNode != null)
                {
                    string attrVal = attrNode.nodeValue; ;
                    if (attrVal != null && attrVal != "" && attrVal.IndexOf("javascript") == -1)
                    {
                        if (attrVal.IndexOf(original.Host) == -1)
                            if (attrVal[0] == '/')
                                attrNode.nodeValue = original.Scheme + "://" + original.Host + attrVal.Replace("about:blank", "");
                            else
                                attrNode.nodeValue = original.Scheme + "://" + original.Host + "/" + attrVal.Replace("about:blank", "");
                    }
                }

                attrNode = ((IHTMLElement4)elem).getAttributeNode("src");
                if (attrNode != null)
                {
                    string attrVal = attrNode.nodeValue; ;
                    if (attrVal != null && attrVal != "" && attrVal.IndexOf("javascript") == -1)
                    {
                        if (attrVal.IndexOf(original.Host) == -1)
                            if (attrVal[0] == '/')
                                attrNode.nodeValue = original.Scheme + "://" + original.Host + attrVal.Replace("about:blank", "");
                            else
                                attrNode.nodeValue = original.Scheme + "://" + original.Host + "/" + attrVal.Replace("about:blank", "");
                    }
                }
            }
        }

        /// <summary>
        /// THe main internal driver function for the document.
        /// Crawls, Parses, Extracts and Saves Content and associated MetaData
        /// </summary>
        private void _ParseExtractAndSaveContent()
        {
            ResultFiles = new List<IFile>();

            // traverse to the element(s) that need to be extracted
            foreach (CrawlerCode startCode in _mCrawlerCode)
            {
                CustomCodeExecutor executor = new CustomCodeExecutor();
                executor.ProcessCrawlerCode(_mDocRoot, startCode);
            }

            // save
            foreach (DocumentSaver saver in _mContentSavers)
                ResultFiles.Add(saver.Save());
        }

        /// <summary>
        /// Finds the first element matching a combination of tag name and the filter function.
        /// </summary>
        /// <param name="tagName">The tag type to search for.</param>
        /// <param name="pred">A predicate function to filter the elements.</param>
        /// <returns>An IElement. Returns null if there are no matches.</returns>
        public IElement FindElement(string tagName, Func<IElement, bool> pred)
        {
            return _mDocRoot.FindElement(tagName, pred);
        }

        /// <summary>
        /// Finds all elements matching a combination of tag name and the filter function.
        /// </summary>
        /// <param name="tagName">The tag type to search for.</param>
        /// <param name="pred">A predicate function to filter the elements.</param>
        /// <returns>An IEnumerable of IElements representing all elements that pass the filter function.</returns>
        public IEnumerable<IElement> FindElements(string tagName, Func<IElement, bool> pred)
        {
            return _mDocRoot.FindElements(tagName, pred);
        }

        /// <summary>
        /// Finds the first element matching a combination of tag name and inner text content.
        /// </summary>
        /// <param name="tagName">The tag type to search for.</param>
        /// <param name="text">The text to search for inside of the element's content.</param>
        /// <returns>An IElement representing the first element with the given ID. Returns null if there are no matches.</returns>
        public IElement FindElementByText(string tagName, string text)
        {
            return _mDocRoot.FindElementByText(tagName, text);
        }

        /// <summary>
        /// Finds the first element matching a combination of tag name, attribute type and attribute content.
        /// </summary>
        /// <param name="tagName">The tag type to search for.</param>
        /// <param name="attrType">The attribute type on the tag.</param>
        /// <param name="attrText">The text content of the attribute.</param>
        /// <returns>An IElement representing the first element with the given ID. Returns null if there are no matches.</returns>
        public IElement FindElementByAttribute(string tagName, string attrType, string attrText)
        {
            return _mDocRoot.FindElementByAttribute(tagName, attrType, attrText);
        }

        /// <summary>
        /// Returns the first element with the given ID.
        /// </summary>
        /// <param name="id">The ID of the element.</param>
        /// <returns>An IElement representing the first element with the given ID. Returns null if there are no matches.</returns>
        public IElement FindElementById(string id)
        {
            return _mDocRoot.FindElementById(id);
        }

        /// <summary>
        ///  Returns the HTML of this document.
        /// </summary>
        public string Html 
        { 
            get 
            {
                if (_mHTMLDoc != null)
                    return ((IHTMLDocument3)_mHTMLDoc).documentElement.outerHTML;

                return null;
            } 
        }

        /// <summary>
        /// Returns the URL of this document.
        /// </summary>
        public string Url 
        {
            get
            {
                return _mUrlToCrawl;
            }
            set
            {
                _mUrlToCrawl = value;
            }
        }

        // document saver helper functions
        public CrawlerCode MatchedInstruction
        {
            get
            {
                return _mMatchedInstruction;
            }
            set
            {
                _mMatchedInstruction = value;
            }
        }

        public void AddDocumentSaver(DocumentSaver pSaver)
        {
            _mContentSavers.Add(pSaver);
        }

        /// <summary>
        /// Saves the current document to a file.
        /// </summary>
        /// <returns>An a List of IFile objects representing the results of the download. There could be different extracts for each document</returns>
        public IFile SaveDocument()
        {
            IFile file = new File();
            file.MetaData = GetCurrentMetaData();

            file.CreateFile(Url, Program.ResultantDocumentsStore, Html);
            return file;
        }

        /// <summary>
        /// Returns a collection of metadata describing the current document. This will be also be attached to the IFile object returned by SaveDocument. 
        /// </summary>
        /// <returns>An ICollection of IMetaData</returns>
        public ICollection<IMetaData> GetCurrentMetaData()
        {
            foreach (MetaData metaData in MatchedInstruction.mMetaData)
                MetaData.ProcessMetaData(metaData, _mHTMLDoc, MatchedInstruction);

            return MatchedInstruction.mMetaData;
        }
    }
}

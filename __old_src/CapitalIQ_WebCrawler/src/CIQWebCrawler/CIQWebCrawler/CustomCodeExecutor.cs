using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using mshtml;

namespace CIQWebCrawler
{
    /// <summary>
    /// The Custom Code Processor. Processes code present in the crawler code file
    /// </summary>
    class CustomCodeExecutor
    {
        CrawlerCode _CurrentCode = null;
        IElement _mCurrentElement = null;

        /// <summary>
        /// main internal fucntion called to process each Custom Code for the 
        /// current document on the current element.
        /// </summary>
        /// <param name="pElement">Element on which the code has to be processed</param>
        /// <param name="pCrawlerCode">Crawl code to be processed</param>
        public void ProcessCrawlerCode(IElement pElement, CrawlerCode pCrawlerCode)
        {
            _CurrentCode = pCrawlerCode;
            _mCurrentElement = pElement;

            // move to the next level in the DOM tree
            if (pCrawlerCode.mType == CodeNodeType.Element)
                _ProcessElement(pCrawlerCode);
            // now we are to process an instruction, which for e.g. 
            // 1) could be selecting HTML of the currentElement
            // 2) traversing to a new document (similuated Click)
            else if (pCrawlerCode.mType == CodeNodeType.Instruction)
                _ProcessInstruction(pCrawlerCode);
            else
                throw new Exception("Invalid <CustomCode> specified in the crawler code file");
        }

        /// <summary>
        /// Processes an <Element> in the custom code.
        /// </summary>
        /// <param name="pCrawlerCode"></param>
        private void _ProcessElement(CrawlerCode pCrawlerCode)
        {
            // narrowing the path while traversing down the tree
            if (pCrawlerCode.mTagName.ToUpper() == _mCurrentElement.TagName.ToUpper())
            {
                foreach (CrawlerCode childCode in pCrawlerCode.mChildCodes)
                    if (_mCurrentElement.Children != null)
                        ProcessCrawlerCode(_mCurrentElement.Children.First(), childCode);
                    else
                        throw new Exception("Element node in Custom code file should have another element or instruction node as child");
            }
            // get the element at pos and then crawl
            else if (pCrawlerCode.mPosition != 0)
            {
                IElement elem = _mCurrentElement.Parent.Children.ElementAt(pCrawlerCode.mPosition);
                foreach (CrawlerCode childCode in pCrawlerCode.mChildCodes)

                    if (_mCurrentElement.Children != null)
                        ProcessCrawlerCode(elem, childCode);
            }
            // there is no 1-to-1 match in the structure of the tree. we need to find the sub element that
            // matches the criteria given in the code
            else
            {
                IElement elem = _mCurrentElement.FindElement(pCrawlerCode.mTagName, IsACodeMatch);
                if (elem != null)
                {
                    foreach (CrawlerCode childCode in pCrawlerCode.mChildCodes)
                        if (_mCurrentElement.Children != null)
                            ProcessCrawlerCode(elem, childCode);
                }
                else
                    throw new Exception(pCrawlerCode.mTagName + " not found in the document");
            }
        }

        /// <summary>
        /// Processes an <Instruction> code in the custom crawl code file
        /// </summary>
        /// <param name="pCrawlerInstruction"></param>
        private void _ProcessInstruction(CrawlerCode pCrawlerInstruction)
        {
            // is this a selection of some html content?
            if (pCrawlerInstruction.mInstructionType == InstructionType.Select)
            {
                // get the parent element type 
                string parentElement = pCrawlerInstruction.mParent.mTagName;
                if (parentElement.ToUpper() == "TABLE")
                    _ExtractTableElement(pCrawlerInstruction);
                else if (parentElement.ToUpper() == "DIV")
                    _ExtractDIVElement(pCrawlerInstruction);
            }
            // if this is a download of a resource
            else if (pCrawlerInstruction.mInstructionType == InstructionType.Traverse)
            {
                string parentElement = pCrawlerInstruction.mParent.mTagName;
                if (parentElement.ToUpper() == "TABLE")
                    _ExtractAndTraverseLinksInTable(pCrawlerInstruction);
                else if (parentElement.ToUpper() == "A")
                    _mCurrentElement.Click();
            }
        }

        /// <summary>
        /// Helper function to extract a HTML Table
        /// </summary>
        /// <param name="pInstruction">Instruction object containing info to extract the table, 
        /// for e.g. columns to be extracted</param>
        private void _ExtractTableElement(CrawlerCode pInstruction)
        {
            HTMLTable table1 = (HTMLTable)((Element)_mCurrentElement).GetHTMLElement();
            HTMLTable table = (HTMLTable) table1.cloneNode(true);

            // process if there is a <THEAD> element
            if (table.tHead != null)
            {
                for (int idx = 0; idx < table.tHead.rows.length; idx++)
                {
                    int len = table.tHead.rows.length;
                    int num_removed = 0;
                    if (pInstruction.mTableCols.Contains<int>(idx) == false || pInstruction.mTableCols.Last() < idx)
                        table.tHead.deleteRow(idx - num_removed++);
                }
            }

            // extract the columns for all the rows
            if (table.rows != null)
            {
                for (int idx = 0; idx < table.rows.length; idx++)
                {
                    HTMLTableRow row = (HTMLTableRow)table.rows.item(idx);
                    int len = row.cells.length;
                    int num_removed = 0;
                    for (int idx1 = 0; idx1 < len; idx1++)
                        if (pInstruction.mTableCols.Contains<int>(idx1) == false || pInstruction.mTableCols.Last() < idx1)
                            row.deleteCell(idx1 - num_removed++);
                }
            } 

            // html that is extracted
            string html = ((IHTMLElement)table).outerHTML;

            // Save the contents, create the DocumentSaver and add it to the Document 
            _mCurrentElement.ContentToSave = html;
            DocumentSaver saver = new DocumentSaver(pInstruction, _mCurrentElement);
            _mCurrentElement.Document.AddDocumentSaver(saver);

            // setup the matched <CustomCode> and Element object. To be used later while saving the content
            ((Element)_mCurrentElement).MatchedInstruction = pInstruction;
            ((Element)_mCurrentElement).MatchedInstruction.mMatchedElem = _mCurrentElement;
            
            ((Element)_mCurrentElement).Document.MatchedInstruction = pInstruction;
            ((Element)_mCurrentElement).Document.MatchedInstruction.mMatchedElem = _mCurrentElement;
        }

        /// <summary>
        /// Helper function to extract a DIV element
        /// </summary>
        /// <param name="pInstruction"></param>
        private void _ExtractDIVElement(CrawlerCode pInstruction)
        {
            // html that is extracted
            string html = ((Element)_mCurrentElement).GetHTMLElement().outerHTML;

            // Save the contents, create the DocumentSaver and add it to the Document 
            _mCurrentElement.ContentToSave = html;
            DocumentSaver saver = new DocumentSaver(pInstruction, _mCurrentElement);
            _mCurrentElement.Document.AddDocumentSaver(saver);

            // setup the matched <CustomCode> and Element object. To be used later while saving the content
            ((Element)_mCurrentElement).MatchedInstruction = pInstruction;
            ((Element)_mCurrentElement).MatchedInstruction.mMatchedElem = _mCurrentElement;

            ((Element)_mCurrentElement).Document.MatchedInstruction = pInstruction;
            ((Element)_mCurrentElement).Document.MatchedInstruction.mMatchedElem = _mCurrentElement;
        }
        
        /// <summary>
        /// Helper function for traversing links found in a table
        /// </summary>
        /// <param name="pInstruction"></param>
        private void _ExtractAndTraverseLinksInTable(CrawlerCode pInstruction)
        {
            IElement elem = _mCurrentElement;
            if (_mCurrentElement.Children.First().TagName.ToUpper() == "TBODY")
                elem = elem.Children.First();

            HTMLTable table = (HTMLTable) ((Element)_mCurrentElement).GetHTMLElement();
            if (table.rows != null)
            {
                for (int idx = 0; idx < table.rows.length; idx++)
                {
                    HTMLTableRow row = (HTMLTableRow)table.rows.item(idx);
                    int len = row.cells.length;

                    IElement elem1 = elem.Children.ElementAt(idx);
                    for (int idx1 = 0; idx1 < len; idx1++)
                        if (pInstruction.mTableCols.Contains<int>(idx1))
                        {
                            HTMLTableCell cell = (HTMLTableCell)row.cells.item(idx1);
                            IHTMLElement td = (IHTMLElement)cell;
                            IElement elem2 = elem1.Children.ElementAt(idx1);

                            IElement anchor = elem2.FindElement("A", null);
                            if (anchor != null)
                            {
                                ((Element) anchor).MatchedInstruction = pInstruction;
                                ((Element)_mCurrentElement).MatchedInstruction.mMatchedElem = _mCurrentElement;
                                ((Element)anchor).Document.MatchedInstruction = pInstruction;
                                ((Element)anchor).Document.MatchedInstruction.mMatchedElem = _mCurrentElement;

                                // ** Traversing Links using the CLick method of the Element, for e.g. Anchor
                                IDocument doc = anchor.Click();

                                // setup the Row,Col for the link, so that it can be used while saving MetaData
                                ((Element)anchor).Row = idx;
                                ((Element)anchor).Col = idx1;
                                ((Element)anchor).Document.MatchedInstruction.mMatchedSubElem = anchor;

                                // Save the contents, create the DocumentSaver and add it to the Document 
                                DocumentSaver saver = new DocumentSaver(pInstruction, doc);
                                _mCurrentElement.Document.AddDocumentSaver(saver);
                            }
                        }
                }
            }
        }

        /// <summary>
        /// Predicate to match custom attributes on a <CrawlerCode> node
        /// </summary>
        /// <param name="pElem">Element object on which the attributes are to be checked</param>
        /// <returns>true if there is perfect match of all custom attributes</returns>
        public bool IsACodeMatch(IElement pElem)
        {
            if (_CurrentCode.mCustomAttributes == null)
                return true;

            // check if the custom attributes set on the Code Elem match that of the IElement
            foreach (KeyValuePair<string, string> attrPair in _CurrentCode.mCustomAttributes)
            {
                if (pElem.GetAttribute(attrPair.Key) != attrPair.Value)
                    return false;
            }

            return true;
        }
    }
}

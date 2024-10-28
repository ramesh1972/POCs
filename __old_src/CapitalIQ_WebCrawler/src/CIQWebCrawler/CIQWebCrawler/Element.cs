using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using mshtml;

namespace CIQWebCrawler
{
    /// <summary>
    /// Repesents an element in the hhtml document, a wrapper around the HTMLElement DOM object
    /// Contains a collection of elements which are immediate children of this element in the DOM tree
    /// </summary>
    class Element : IElement
    {
        // basic props
        IDocument _mDoc = null;
        IHTMLElement _mHTMLElem = null;

        // DOM tree
        IElement _mParent = null;
        List<IElement> _mChildren = null;

        // content that has been extracted for saving
        string _mContentToSave = String.Empty;
        public CrawlerCode MatchedInstruction = null;

        // for elements part of HTML table
        public int Row = -1;
        public int Col = -1;

        /// <summary>
        /// Constructor
        /// </summary>
        /// <param name="pDoc">The IDocument object that holds this element</param>
        public Element(IDocument pDoc)
        {
            _mDoc = pDoc;
        }
        /// <summary>
        /// Disposes of the COM DOM object
        /// </summary>
        ~Element()
        {
            try
            {
                if (_mHTMLElem != null)
                {
                    System.Runtime.InteropServices.Marshal.FinalReleaseComObject(_mHTMLElem);
                    _mHTMLElem = null;
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
        /// Sets up the dom tree by calling itself recursively
        /// </summary>
        /// <param name="pHTMLElem"></param>
        public void SetUpElementTree(IHTMLElement pHTMLElem)
        {
            _mHTMLElem = pHTMLElem;
            if (_mHTMLElem.children == null)
                return;

            _mChildren = new List<IElement>();
            foreach (IHTMLElement child in _mHTMLElem.children)
            {
                Element elem = new Element(_mDoc);
                _mChildren.Add(elem);

                elem.SetUpElementTree(child);
                elem._mParent = this;
            }
        }

        /// <summary>
        /// Returns the Id of this element.
        /// </summary>
        public string Id
        {
            get 
            {
                if (_mHTMLElem == null)
                    return null;

                return _mHTMLElem.id;
            }
        }

        /// <summary>
        /// Returns the inner HTML of this element (exclusive of the outer tag).
        /// </summary>
        public string InnerHtml 
        { 
            get 
            {
                if (_mHTMLElem == null)
                    return null;

                return _mHTMLElem.innerHTML;
            } 
        }

        /// <summary>
        /// Returns the outer HTML of this element (exclusive of the outer tag).
        /// </summary>
        public string OuterHtml
        {
            get
            {
                if (_mHTMLElem == null)
                    return null;

                return _mHTMLElem.outerHTML;
            }
        }

        /// <summary>
        /// Returns the inner text of this element.
        /// </summary>
        public string InnerText 
        { 
            get 
            {
                if (_mHTMLElem == null)
                    return null;

                return _mHTMLElem.innerText;
            } 
        }

        /// <summary>
        /// Content that is extracted to be saved
        /// </summary>
        public string ContentToSave
        {
            get
            {
                return _mContentToSave;
            }
            set
            {
                _mContentToSave = value;
            }
        }
        /// <summary>
        /// Invokes a click on this element and waits for the new page to be ready before returning.
        /// </summary>
        /// <returns>An IDocument representing the new page.</returns>
        public IDocument Click()
        {
            string url = String.Empty;
            if (TagName.ToUpper() == "A")
                url = GetAttribute("href");

            if (String.IsNullOrEmpty(url))
                return null;

            Document doc = new Document(url);
            doc.MatchedInstruction = Document.MatchedInstruction;

            return (IDocument)doc;
        }

        /// <summary>
        /// Returns the value of the specified attribute.
        /// </summary>
        /// <param name="attr">The attribute to get.</param>
        /// <returns>The attribute's value if it exists, otherwise null.</returns>
        public string GetAttribute(string attr)
        {
            if (_mHTMLElem == null)
                return null;

            IHTMLDOMAttribute attrNode = ((IHTMLElement4)_mHTMLElem).getAttributeNode(attr);
            if (attrNode == null)
                return null;

            return attrNode.nodeValue;
        }

        /// <summary>
        /// Returns an IDocument representing the parent document of this element.
        /// </summary>
        public IDocument Document 
        { 
            get 
            {
                return _mDoc;
            } 
        }

        /// <summary>
        /// Returns an IElement representing the parent of this element.
        /// </summary>
        public IElement Parent 
        { 
            get 
            {
                return _mParent;
            } 
        }

        /// <summary>
        /// Returns an IEnumerable of IElement representing the children of this element.
        /// </summary>
        public IEnumerable<IElement> Children 
        { 
            get 
            {
                return _mChildren;
            } 
        }

        /// <summary>
        /// The tag name ('a', 'div', 'span', etc.) of this element.
        /// </summary>
        public string TagName 
        { 
            get 
            {
                if (_mHTMLElem == null)
                    return null;

                return _mHTMLElem.tagName;
            } 
        }

        public IHTMLElement GetHTMLElement()
        {
            return _mHTMLElem;
        }

        /// <summary>
        /// Invokes a click on this element and saves the result. Calls GetCurrentMetaData to construct the metadata collection.
        /// </summary>
        /// <returns>An IFile object representing the result of the download.</returns>
        public IFile SaveTarget()
        {
            IFile file = new File();
            file.MetaData = GetCurrentMetaData();

            file.CreateFile(Document.Url, Program.ResultantDocumentsStore, ContentToSave);
            return file;
        }

        /// <summary>
        /// Returns a c
        /// ollection of metadata describing the current element. This will be also be attached to the IFile object returned by SaveTarget. 
        /// </summary>
        /// <returns>An ICollection of IMetaData</returns>
        public ICollection<IMetaData> GetCurrentMetaData()
        {
            foreach (MetaData metaData in MatchedInstruction.mMetaData)
                MetaData.ProcessMetaData(metaData, ((Document) Document)._mHTMLDoc, MatchedInstruction);

            return MatchedInstruction.mMetaData;
        }

        /// <summary>
        /// Finds the first element matching a combination of tag name and the filter function.
        /// </summary>
        /// <param name="tagName">The tag type to search for.</param>
        /// <param name="pred">A predicate function to filter the elements.</param>
        /// <returns>An IElement. Returns null if there are no matches.</returns>
        public IElement FindElement(string tagName, Func<IElement, bool> pred)
        {
            if (tagName.ToUpper() == TagName.ToUpper() && pred == null)
                return this;

            if (tagName.ToUpper() == TagName.ToUpper() && pred != null && pred(this))
                return this;

            // loop through the children and search deep
            if (Children == null)
                return null;

            foreach (Element child in Children)
            {
                IElement ret = child.FindElement(tagName, pred);
                if (ret != null)
                    return ret;
            }
            return null;
        }

        /// <summary>
        /// Finds all elements matching a combination of tag name and the filter function.
        /// </summary>
        /// <param name="tagName">The tag type to search for.</param>
        /// <param name="pred">A predicate function to filter the elements.</param>
        /// <returns>An IEnumerable of IElements representing all elements that pass the filter function.</returns>
        public IEnumerable<IElement> FindElements(string tagName, Func<IElement, bool> pred)
        {
            List<IElement> matchedElems = new List<IElement>();
            if (tagName.ToUpper() == TagName.ToUpper() && pred == null)
                matchedElems.Add(this);

            if (tagName.ToUpper() == TagName.ToUpper() && pred != null && pred(this))
                matchedElems.Add(this);

            // loop through the children and search deep
            if (Children == null)
                return null;

            foreach (Element child in Children)
            {
                List<IElement> matchedChildElems = (List<IElement>) child.FindElements(tagName, pred);
                matchedElems.Union<IElement>(matchedChildElems);
            }

            return matchedElems;
        }

        /// <summary>
        /// Finds the first element matching a combination of tag name and inner text content.
        /// </summary>
        /// <param name="tagName">The tag type to search for.</param>
        /// <param name="text">The text to search for inside of the element's content.</param>
        /// <returns>An IElement representing the first element with the given ID. Returns null if there are no matches.</returns>
        public IElement FindElementByText(string tagName, string text)
        {
            if (tagName.ToUpper() == TagName.ToUpper() && InnerText.IndexOf(text) >= 0)
                return this;

            // loop through the children and search deep
            if (Children == null)
                return null;

            foreach (Element child in Children)
            {
                IElement ret = child.FindElementByText(tagName, text);
                if (ret != null)
                    return ret;
            }

            return null;
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
            if (tagName.ToUpper() == TagName.ToUpper())
            {
                string attrValue = GetAttribute(attrType);
                if (attrValue != null && attrValue == attrText)
                    return this;
            }

            // loop through the children and search deep
            if (Children == null)
                return null;

            foreach (Element child in Children)
            {
                IElement ret = child.FindElementByAttribute(tagName, attrType, attrText);
                if (ret != null)
                    return ret;
            }

            return null;
        }

        /// <summary>
        /// Returns the first element with the given ID.
        /// </summary>
        /// <param name="id">The ID of the element.</param>
        /// <returns>An IElement representing the first element with the given ID. Returns null if there are no matches.</returns>
        public IElement FindElementById(string id)
        {
            if (Id == id)
                return this;

            // loop through the children and search deep
            if (Children == null)
                return null;

            foreach (Element child in Children)
            {
                IElement ret = child.FindElementById(id);
                if (ret != null)
                    return ret;
            }

            return null;
        }
    }
}

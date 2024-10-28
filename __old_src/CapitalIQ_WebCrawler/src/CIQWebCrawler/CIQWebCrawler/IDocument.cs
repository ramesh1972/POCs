using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CIQWebCrawler
{
    /// <summary>
    /// Defines a full HTML DOM document.
    /// </summary>
    public interface IDocument
    {
        /// <summary>
        /// Finds the first element matching a combination of tag name and the filter function.
        /// </summary>
        /// <param name="tagName">The tag type to search for.</param>
        /// <param name="pred">A predicate function to filter the elements.</param>
        /// <returns>An IElement. Returns null if there are no matches.</returns>
        IElement FindElement(string tagName, Func<IElement, bool> pred);

        /// <summary>
        /// Finds all elements matching a combination of tag name and the filter function.
        /// </summary>
        /// <param name="tagName">The tag type to search for.</param>
        /// <param name="pred">A predicate function to filter the elements.</param>
        /// <returns>An IEnumerable of IElements representing all elements that pass the filter function.</returns>
        IEnumerable<IElement> FindElements(string tagName, Func<IElement, bool> pred);

        /// <summary>
        /// Finds the first element matching a combination of tag name and inner text content.
        /// </summary>
        /// <param name="tagName">The tag type to search for.</param>
        /// <param name="text">The text to search for inside of the element's content.</param>
        /// <returns>An IElement representing the first element with the given ID. Returns null if there are no matches.</returns>
        IElement FindElementByText(string tagName, string text);

        /// <summary>
        /// Finds the first element matching a combination of tag name, attribute type and attribute content.
        /// </summary>
        /// <param name="tagName">The tag type to search for.</param>
        /// <param name="attrType">The attribute type on the tag.</param>
        /// <param name="attrText">The text content of the attribute.</param>
        /// <returns>An IElement representing the first element with the given ID. Returns null if there are no matches.</returns>
        IElement FindElementByAttribute(string tagName, string attrType, string attrText);

        /// <summary>
        /// Returns the first element with the given ID.
        /// </summary>
        /// <param name="id">The ID of the element.</param>
        /// <returns>An IElement representing the first element with the given ID. Returns null if there are no matches.</returns>
        IElement FindElementById(string id);

        /// <summary>
        ///  Returns the HTML of this document.
        /// </summary>
        string Html { get; }

        /// <summary>
        /// Returns the URL of this document.
        /// </summary>
        string Url { get; set; }

        /* Save helper functions */
        /// <summary>
        /// sets up the list of DoucmentSaver objects, each represting an extracted peice of content and their save info
        /// </summary>
        /// <param name="pDocSaver">DocumentSaver object</param>
        void AddDocumentSaver(DocumentSaver pDocSaver);

        /// <summary>
        /// The instruction (CustomCode) that has matched the document
        /// </summary>
        CrawlerCode MatchedInstruction { get; set; }

        /// <summary>
        /// Saves the current document to a file.
        /// </summary>
        /// <returns>An a List of IFile objects representing the results of the download. There could be different extracts for each document</returns>
        IFile SaveDocument();

        /// <summary>
        /// Returns a collection of metadata describing the current document. This will be also be attached to the IFile object returned by SaveDocument. 
        /// </summary>
        /// <returns>An ICollection of IMetaData</returns>
        ICollection<IMetaData> GetCurrentMetaData();
    }
}

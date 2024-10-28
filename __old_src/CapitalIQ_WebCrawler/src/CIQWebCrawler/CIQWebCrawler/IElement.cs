using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CIQWebCrawler
{
    /// <summary>
    /// Defines an element (described in HTML by a tag) of an HTML DOM.
    /// </summary>
    public interface IElement
    {
        /// <summary>
        /// Returns the inner HTML of this element (exclusive of the outer tag).
        /// </summary>
        string InnerHtml { get; }

        /// <summary>
        /// Returns the outer HTML of this element (exclusive of the outer tag).
        /// </summary>
        string OuterHtml { get; }

        /// <summary>
        /// Returns the inner text of this element.
        /// </summary>
        string InnerText { get; }

        /// <summary>
        /// Invokes a click on this element and waits for the new page to be ready before returning.
        /// </summary>
        /// <returns>An IDocument representing the new page.</returns>
        IDocument Click();

        /// <summary>
        /// Returns the value of the specified attribute.
        /// </summary>
        /// <param name="attr">The attribute to get.</param>
        /// <returns>The attribute's value if it exists, otherwise null.</returns>
        string GetAttribute(string attr);

        /// <summary>
        /// Returns an IDocument representing the parent document of this element.
        /// </summary>
        IDocument Document { get; }

        /// <summary>
        /// Returns an IElement representing the parent of this element.
        /// </summary>
        IElement Parent { get; }

        /// <summary>
        /// Returns an IEnumerable of IElement representing the children of this element.
        /// </summary>
        IEnumerable<IElement> Children { get; }

        /// <summary>
        /// The tag name ('a', 'div', 'span', etc.) of this element.
        /// </summary>
        string TagName { get; }

        /// <summary>
        /// Invokes a click on this element and saves the result. Calls GetCurrentMetaData to construct the metadata collection.
        /// </summary>
        /// <returns>An IFile object representing the result of the download.</returns>
        IFile SaveTarget();

        /// <summary>
        /// Returns a collection of metadata describing the current element. This will be also be attached to the IFile object returned by SaveTarget. 
        /// </summary>
        /// <returns>An ICollection of IMetaData</returns>
        ICollection<IMetaData> GetCurrentMetaData();

        // helpers for Saving
        /// <summary>
        /// For content extracted from part of the doucment, this holds the extracted content. for e.g. html in a DIV.
        /// </summary>
        string ContentToSave { get;set; }
        
        // Helper functions for IDocument as well as subelements
        IElement FindElement(string tagName, Func<IElement, bool> pred);
        IEnumerable<IElement> FindElements(string tagName, Func<IElement, bool> pred);
        IElement FindElementByText(string tagName, string text);
        IElement FindElementByAttribute(string tagName, string attrType, string attrText);
        IElement FindElementById(string id);
    }
}

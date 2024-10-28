using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using mshtml;
using System.Xml.Serialization;

namespace CIQWebCrawler
{
    /// <summary>
    /// MetaData class represents a piece of information that identifies the extracted resource.
    /// An extracted resource can have multiple Meta Data.
    /// Meta Data is configurable and is given in the CustomCrawlerCode file along with crawling insturctions.
    /// For e.g.
    ///         <Element Tag="DIV" id="content" class="clearfix">
    ///               <Instruction Type="Select">
    ///                  <MetaData Type="String" Value="Bloomberg Major Markets"></MetaData>
    ///                  <MetaData Type="String" Value="$document:title"></MetaData>
    ///               </Instruction>
    /// In the above example 2 MetaData are associated with extracted DIV element.
    /// 1) a constant string
    /// 2) html document title
    /// </summary>
    [Serializable()]
    public class MetaData : IMetaData
    {
        MetaDataType _Type = MetaDataType.Int;
        object _Value = null;

        // for Tables
        [XmlIgnore()]
        public String Col = String.Empty;

        /// <summary>
        /// An identifier for the type of datapoint.
        /// </summary>
        public int TypeId 
        {
            get
            {
                return (int) _Type;
            }
            set
            {
                _Type = (MetaDataType) value;
            }
        }

        /// <summary>
        /// The datapoint value. This object will be stored as a string value in the database.
        /// </summary>
        public object Value
        {
            get
            {
                return _Value;
            }
            set
            {
                _Value = value;
            }
        }

        /// <summary>
        /// Helper function that processes MetaData. i.e. extracts MetaData information from the resource and
        /// and saves to MetaData file
        /// </summary>
        /// <param name="metaData"></param>
        /// <param name="_mHTMLDoc"></param>
        /// <param name="pMatchedInstruction"></param>
        public static void ProcessMetaData(MetaData metaData, IHTMLDocument2 _mHTMLDoc, CrawlerCode pMatchedInstruction)
        {
            Element mMatchedElem = (Element) pMatchedInstruction.mMatchedElem;
            Element mMatchedSubElem = (Element) pMatchedInstruction.mMatchedSubElem;

            // hard coded or attrib value
            if (metaData.Value != null && String.IsNullOrEmpty(metaData.Value.ToString()) == false && String.IsNullOrEmpty(metaData.Col))
            {
                string val = metaData.Value.ToString();
                if (val[0] == '$')
                {
                    val = val.Substring(1);
                    if (val.ToLower().IndexOf("document") != -1)
                    {
                        val = val.Substring(9);
                        if (val == "title")
                            metaData.Value = _mHTMLDoc.title;
                        else
                            metaData.Value = mMatchedElem.GetAttribute(val);
                    }
                }
                else
                {
                    ; // Nothing to do
                }
            }
            // the element must be a table
            else if (metaData.Col != String.Empty)
            {
                Element matchedElem = (Element)mMatchedElem;
                HTMLTable table = (HTMLTable)matchedElem.GetHTMLElement();

                if (table.rows != null && mMatchedSubElem.Row != -1)
                {
                    HTMLTableRow row = (HTMLTableRow)table.rows.item(mMatchedSubElem.Row);
                    HTMLTableCell cell = (HTMLTableCell)row.cells.item(Convert.ToInt32(metaData.Col));

                    IHTMLElement cellNode = null;
                    try
                    {
                        cellNode = (IHTMLElement)cell.firstChild;
                    }
                    catch
                    {
                        cellNode = (IHTMLElement) cell;
                    }
                    if (metaData.Value != null && String.IsNullOrEmpty(metaData.Value.ToString()) == false)
                    {
                        string attr = metaData.Value.ToString().Substring(1);
                        if (attr == "innerText")
                            metaData.Value = cellNode.innerText;
                        else
                        {
                            IHTMLDOMAttribute attrNode = ((IHTMLElement4)cellNode).getAttributeNode(attr);
                            if (attrNode != null)
                                metaData.Value = attrNode.nodeValue;
                        }
                    }
                    else
                        metaData.Value = cellNode.innerText;
                }
            }
        }
    }
}

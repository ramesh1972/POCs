using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;

namespace CIQWebCrawler
{
    /// <summary>
    /// The Custom Crawler Code File can contain 2 types of elements.
    /// Element - Represents a certain element in the resource, for e.g. Table, Div, etc..
    /// Instruction - Represents an instruction or function to be performed on the extracted element.
    /// The third type of element that is supported by default is the MetaData. So the MetaData to be 
    /// saved for the content can be specified in the file and hence highly configurable.
    /// </summary>
    public enum CodeNodeType
    {
        Element,
        Instruction
    }

    /// <summary>
    /// Currently these instructions are implemented,
    /// Select - Selects the element (for e.g. Table) as the extracted content.
    /// Traverse - Crawls further. This is for links to other pages.
    /// </summary>
    public enum InstructionType
    {
        Unknown,
        Select,
        Traverse
    }

    /// <summary>
    /// A Container class - collection of CustomCrawlerCode
    /// </summary>
    class CustomCrawlerCodes : System.Collections.IEnumerable
    {
        private String _mCrawlerCodeFile = String.Empty;

        private List<CustomCrawlerCode> _CrawlerCodes = new System.Collections.Generic.List<CustomCrawlerCode>();

        /// <summary>
        /// Constructor that creates the list of CustomCrawlerCode objects
        /// </summary>
        /// <param name="pCrawlerCodeFile">File containing crawler code</param>
        public CustomCrawlerCodes(string pCrawlerCodeFile = Program.DefaultCustomCrawlerCodeFile)
        {
            _mCrawlerCodeFile = pCrawlerCodeFile;

            _CreateCrawlerCodes();
        }

        private void _CreateCrawlerCodes() 
        {
            XmlDocument crawlerCodeDoc = new XmlDocument();
            crawlerCodeDoc.Load(_mCrawlerCodeFile);

            XmlNodeList crawlerCodeNodes = crawlerCodeDoc.GetElementsByTagName("CustomCrawlerCode");
            if (crawlerCodeNodes == null || crawlerCodeNodes.Count == 0)
                throw new System.Exception(_mCrawlerCodeFile + " has no <CustomCrawlerCode> nodes");

            foreach (XmlNode crawlerCode in crawlerCodeNodes)
                _CrawlerCodes.Add(new CustomCrawlerCode(crawlerCode));
        }

        public System.Collections.IEnumerator GetEnumerator()
        {
            foreach (CustomCrawlerCode code in _CrawlerCodes)
                yield return code;
        }
    }

    /// <summary>
    /// A Crawler code is a kind of a special language with which content can be extracted or further crawling
    /// can be achieved. This class has the url to crawl and the bunch of codes to be exected on the content of
    /// web page returned by the url.
    /// </summary>
    public class CustomCrawlerCode : System.Collections.IEnumerable
    {
        public string mUrlToCrawl = String.Empty;
        List<CrawlerCode> mStartCodes = new List<CrawlerCode>();
 
        public CustomCrawlerCode(XmlNode pCrawlerNode)
        {
            if (pCrawlerNode == null)
                throw new Exception("Null <CustomCrawlerNode> passed in");

            try
            {
                mUrlToCrawl = pCrawlerNode.Attributes.GetNamedItem("Url").Value;
            }
            catch (XmlException xep)
            {
                throw xep;
            }
            catch
            {
                throw new Exception("Url not specified for the <CustomCrawlerNode>");
            }

            // create the tree of codes, similar to that of a DOM tree
            foreach (XmlNode crawlerCode in pCrawlerNode.ChildNodes)
                mStartCodes.Add(new CrawlerCode(crawlerCode));
        }

        public System.Collections.IEnumerator GetEnumerator()
        {
            foreach (CrawlerCode startCode in mStartCodes)
                yield return startCode;
        }
    }

    /// <summary>
    /// A class that represents a peice of crawling code. For e.g. 
    ///     1) selecting an element like DIV
    ///     2) selecting a subelement like Table under the Div
    ///     3) extracting the text of the table, and possibly only specific columns.
    ///     4) MetaData to associate with the extracted content
    ///     etc..
    /// A Custom code is Tree structure. A code contains a children which are codes.
    /// For e.g.
    /// <Element Tag="HTML">
    ///    <Element Tag="BODY" Pos="1">
    ///      <Element Tag="TABLE" class="tableFile2" summary="Results">
    ///        <Instruction Type="Select" Cols="0,1,2,3">
    ///          <MetaData Type="String" Value="Company Filing"></MetaData>
    ///  
    /// </summary>
    public class CrawlerCode : System.Collections.IEnumerable
    {
        // Tree of CrawlerCodes
        public CrawlerCode mParent = null;
        public List<CrawlerCode> mChildCodes = new List<CrawlerCode>();

        // Basic Props
        public CodeNodeType mType = CodeNodeType.Element;
        public String mTagName = String.Empty;
        public InstructionType mInstructionType = InstructionType.Unknown;

        // Optional: Attributes of the element that needs to be selected or extracted
        // basically all attributes in the CrawlerCode node that are not standard and are HTML specific
        // for e.g. for a html table element, id='stocks' class='defaultcss'.
        public Dictionary<string, string> mCustomAttributes = new Dictionary<string, string>();

        // Position of an element type (for e.g. DIV) in the DOM Tree that needs to be selected or extracted.
        public int mPosition = 0;

        // Table specific
        public List<int> mTableCols = new List<int>();

        // meta data information to be stored for ech extract (or instruction executed)
        public List<IMetaData> mMetaData = new List<IMetaData>();

        public IElement mMatchedElem = null;
        public IElement mMatchedSubElem = null;
        
        /// <summary>
        /// The class that builds an individual piece of code, an element or instruction
        /// </summary>
        /// <param name="pCodeNode"></param>
        /// <param name="pParent"></param>
        public CrawlerCode(XmlNode pCodeNode, CrawlerCode pParent = null)
        {
            if (pCodeNode == null)
                throw new Exception("null <CrawlerNode> passed in");

            // select or instruction specific
            if (pCodeNode.Name.ToUpper() == "INSTRUCTION")
            {
                mType = CodeNodeType.Instruction;
                _BuildInstruction(pCodeNode);
            }
            else
                _BuildElement(pCodeNode);

            // a position attribute that specifies the pos of the element (for e.g. Span) in the html doc
            XmlNode posNode = pCodeNode.Attributes.GetNamedItem("Pos");
            if (posNode != null)
                mPosition = System.Convert.ToInt32(posNode.Value);

            // custom attributes, attrbis that are found on the html element on the actual html document
            foreach (XmlAttribute attr in pCodeNode.Attributes)
            {
                if (attr.Name == "Tag" || 
                    attr.Name == "Type" ||
                    attr.Name == "Pos" ||
                    attr.Name == "Cols" ||
                    attr.Name == "SaveToFileName")
                    continue;

                mCustomAttributes.Add(attr.Name, attr.Value);
            }

            // meta data
            _SetMetaDataInfo(pCodeNode);

            // tree of codes
            mParent = pParent;
            foreach (XmlNode childCode in pCodeNode.ChildNodes)
                if (childCode.Name == "MetaData")
                    continue;
                else
                    mChildCodes.Add(new CrawlerCode(childCode, this));
        }

        private void _BuildElement(XmlNode pCodeNode)
        {
            try
            {
                mTagName = pCodeNode.Attributes.GetNamedItem("Tag").Value;
            }
            catch (XmlException xep)
            {
                throw xep;
            }
            catch
            {
                throw new Exception("Tag attribute not specified for <CrawlerNode>");
            }
        }
        
        private void _BuildInstruction(XmlNode pCodeNode)
        {
            string instruction = String.Empty;
            try
            {
                instruction = pCodeNode.Attributes.GetNamedItem("Type").Value.ToUpper();
            }
            catch (XmlException xep)
            {
                throw xep;
            }
            catch
            {
                throw new Exception("Type attribute not specified for the <CrawlerNode>");
            }

            if (instruction == "SELECT")
                mInstructionType = InstructionType.Select;
            else if (instruction == "TRAVERSE")
                mInstructionType = InstructionType.Traverse;
            else
                throw new Exception("Unsupported Instruction Type");

            // mainly for table element
            if (pCodeNode.Attributes.GetNamedItem("Cols") != null)
            {
                string cols = pCodeNode.Attributes.GetNamedItem("Cols").Value;
                string[] colsArr = cols.Split(',');
                int[] columns = new int[colsArr.Length];
                foreach (string col in colsArr)
                    mTableCols.Add(Convert.ToInt32(col));
            }
        }

        private void _SetMetaDataInfo(XmlNode pCodeNode)
        {
            XmlNodeList metaDataNodes = pCodeNode.SelectNodes("MetaData");
            if (metaDataNodes == null || metaDataNodes.Count == 0)
                return;

            foreach (XmlNode metaDataNode in metaDataNodes)
            {
                MetaData metaData = new MetaData();

                XmlNode metaDataTypeNode = metaDataNode.Attributes.GetNamedItem("Type");
                if (metaDataTypeNode != null)
                    if (metaDataTypeNode.Value.ToUpper() == "INT")
                        metaData.TypeId = (int) MetaDataType.Int;
                    else if (metaDataTypeNode.Value.ToUpper() == "STRING")
                        metaData.TypeId = (int) MetaDataType.String;
                    else if (metaDataTypeNode.Value.ToUpper() == "DATE")
                        metaData.TypeId = (int) MetaDataType.Date;
                    else
                        throw new Exception("Invalid Type specified for the <MetaData> node");
                else
                    throw new Exception("Type not specified for the <MetaData> node");

                XmlNode metaDataValueNode = metaDataNode.Attributes.GetNamedItem("Value");
                if (metaDataValueNode != null)
                    metaData.Value = metaDataValueNode.Value;

                // for table ement, to extract info from the row, col
                XmlNode colNode = metaDataNode.Attributes.GetNamedItem("Col");
                if (colNode != null)
                    metaData.Col = colNode.Value;

                mMetaData.Add(metaData);
            }
        }

        public System.Collections.IEnumerator GetEnumerator()
        {
            foreach (CrawlerCode childCode in mChildCodes)
                yield return childCode;
        }
    }
}

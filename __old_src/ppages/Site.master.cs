using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.Serialization;

public partial class Site : System.Web.UI.MasterPage
{
    private readonly string[] tab_positions = { "top", "left", "bottom", "right"};
    private int ctabpos = 0;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        // get a list of all the tabs
        ppagesModel.PPagesEntities ctx = new ppagesModel.PPagesEntities();
        List<ppagesModel.tab> tabs = (from t in ctx.tabs
                   join pt in ctx.tabs on t.parenttabid equals pt.tabid
                   orderby t.tabid
                   select t).ToList();
            
        // parent of all
        Sections sections = new Sections();

        // create sections objects
        System.IO.StringWriter tw = new System.IO.StringWriter();

        var highestLevelTabs = from t in tabs
                               where t.parenttabid == -1
                               select t;

        foreach (ppagesModel.tab cTab in highestLevelTabs)
        {
            Section tret = BuildTabHier(cTab, tabs);
            sections.ChildSections.Add(tret);
        }

        SetTabParams(sections.ChildSections);

        // serialize to xml
        XmlSerializerNamespaces ns = new XmlSerializerNamespaces();
        ns.Add("xsi", "http://www.w3.org/2001/XMLSchema-instance");
        ns.Add("noNamespaceSchemaLocation", "Sections.xsd");

        System.Xml.Serialization.XmlSerializer se = new XmlSerializer(typeof(Sections));
        se.Serialize(tw, sections, ns);

        tw.Flush();
        string xml = tw.ToString();
        tw.Close();

        // get the xml and stick it up in the hidden field
        XmlDocument doc = new XmlDocument();
        doc.LoadXml(xml);

        // strip out the xml declarations
        string xml1 = doc.DocumentElement.OuterXml;
        tabsXml.Value = xml1;

    }

    private Section BuildTabHier(ppagesModel.tab currentTab, List<ppagesModel.tab> tabs)
    {
        Section newT = new Section();

        newT.id = "tab_" + currentTab.tabid;
        newT.tab_text = currentTab.tabtext;
        newT.backcolor = currentTab.backcolor;

        List<ppagesModel.tab> currentLevelTabs = (from t in tabs
                               where t.parenttabid == currentTab.tabid
                                                     select t).ToList();

        newT.childTabs = new List<Section>();
        foreach (ppagesModel.tab cTab in currentLevelTabs)
        {
            newT.childTabs.Add(BuildTabHier(cTab, tabs));
        }

        return newT;
    }

    void AddDockers(Section node)
    {
        if (node == null)
            return;

        if (node.childTabs == null || node.childTabs.Any())
        {
            node.dock_position = "tab";
            return;
        }

        Section docker = new Section();
        docker.dock_position = "dock";
        docker.id = node.id + "_docker";
        docker.tab_text = node.tab_text;

        string child_tab_pos = tab_positions[ctabpos++ % 4];
        foreach (Section s in nodes)
            s.tab_position = child_tab_pos;

        foreach (Section s in nodes)
            SetTabParams(s.childTabs);
    }

    void SetTabParams(List<Section> nodes)
    {
        if (nodes == null || nodes.Count() == 0)
            return;

        string child_tab_pos = tab_positions[ctabpos++ % 4];
        foreach (Section s in nodes)
            s.tab_position = child_tab_pos;

        foreach (Section s in nodes)
            SetTabParams(s.childTabs);
    }
    
    [Serializable]
    public class Sections
    {
        [XmlElement(ElementName="section")]
        public List<Section> ChildSections = new List<Section>();
    }

    [Serializable]
    public class Section
    {
        [XmlAttribute]
        public string type = "section";

        [XmlAttribute]
        public string dock_position = "top";

        [XmlAttribute]
        public string bar = "none";

        [XmlAttribute]
        public string position = "tab";

        [XmlAttribute]
        public string id;

        [XmlAttribute]
        public string tab_position = "bottom";

        [XmlAttribute]
        public string tab_text;

        [XmlAttribute]
        public string backcolor;

        [XmlElement (ElementName="section")]
        public List<Section> childTabs = null;
    }
}

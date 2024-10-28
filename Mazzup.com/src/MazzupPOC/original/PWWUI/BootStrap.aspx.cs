using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;

public partial class aspx_BootStrap : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        // get the xml page that needs to be booted
        var page = Request.Params["BootPage"].ToString();
        _page_name.Value = page;

        // get the full uri
        page = Server.MapPath(page);
 
        // load the xml into the hidden var
        XmlDocument pageDoc = new XmlDocument();
        pageDoc.Load(page);

        // setup the xml for the client to parse and create sections!
        _page_xml.Value = pageDoc.OuterXml;
    }
}
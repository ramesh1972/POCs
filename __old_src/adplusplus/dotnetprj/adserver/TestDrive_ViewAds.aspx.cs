using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ViewAds : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string con = System.Configuration.ConfigurationManager.ConnectionStrings[1].ConnectionString;
        MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter("select adlink, adkeyword, adlinkdesc from ads", con);
        System.Data.DataSet adsds = new System.Data.DataSet();
        adp.Fill(adsds, "ads");

        GridView1.DataSource = adsds;
        GridView1.DataBind();
    }
}
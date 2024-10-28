<%@ WebHandler Language="C#" Class="PubSubAds" %>

using System;
using System.Web;
using System.IO;
using System.Text;

public class PubSubAds : IHttpHandler 
{
    public class PageAdJSONObject
    {
        public string pubUrl = "";
        public string docText = "";
        public string adkeywords = "";
        public string addesc = "";
    }
    
    public void ProcessRequest (HttpContext context) 
    {
        context.Response.ContentType = "application/json";
        context.Response.ContentEncoding = Encoding.UTF8;

        string input = context.Request.Params["input"].ToString();
        if (String.IsNullOrEmpty(input))
            return;

        string sOutJSON = GetAdsJSON(input);
        context.Response.Write(sOutJSON);
    }
 
    public string GetAdsJSON(string jsonIn)
    {
        // objectise the input pob JSON
        System.Web.Script.Serialization.JavaScriptSerializer oSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        jsonIn = jsonIn.Replace("'", "");
        PageAdJSONObject r = oSerializer.Deserialize<PageAdJSONObject>(jsonIn);

        // query the db for ads and also insert current page's ads in db
        // open MySQL Connection
        string constr = System.Web.Configuration.WebConfigurationManager.ConnectionStrings[1].ConnectionString;
        MySql.Data.MySqlClient.MySqlConnection con = new MySql.Data.MySqlClient.MySqlConnection(constr);
        con.Open();

        // get ads Dataset for the current context and convert to JSON
        string sql = "call getads('" + r.docText + "', 10)";
        MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(sql, con);
        System.Data.DataSet ads = new System.Data.DataSet();
        adp.Fill(ads, "ads");
        
        string sJSON = AdppUtils.GetJSONString(ads.Tables["ads"]);

        // insert current pages ad
        MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
        cmd.Connection = con;
        cmd.CommandText = "call insertad('" + r.adkeywords + "','" + r.pubUrl+ "','" + r.addesc + "')";
        cmd.ExecuteNonQuery();

        // close connection
        con.Close();

        return sJSON;
    }

    public bool IsReusable
    {
        get
        {
            return false;
        }
    }
}
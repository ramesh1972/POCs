<%@ WebHandler Language="C#" Class="PubSubAds" %>

using System;
using System.Web;
using System.IO;
using System.Text;
using System.Data;
using MySql.Data;

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

        // objectise the input pob JSON
        System.Web.Script.Serialization.JavaScriptSerializer oSerializer = new System.Web.Script.Serialization.JavaScriptSerializer();
        input = input.Replace("'", "");
        PageAdJSONObject r = oSerializer.Deserialize<PageAdJSONObject>(input);

        // query the db for ads and also insert current page's ads in db
        // open MySQL Connection%
        string constr = System.Web.Configuration.WebConfigurationManager.ConnectionStrings[1].ConnectionString;
        MySql.Data.MySqlClient.MySqlConnection con = new MySql.Data.MySqlClient.MySqlConnection(constr);
        con.Open();

        // insert the current ad
        DataTable dt = InsertAds(con, r);
        
        // get related ads for the page
        //string sOutJSON = GetAdsJSON(con, r, input);
        string sOutJSON = AdppUtils.GetJSONString(dt);
        context.Response.Write(sOutJSON);
    }
 
    public DataTable InsertAds(MySql.Data.MySqlClient.MySqlConnection con , PageAdJSONObject r)
    {
        // insert current pages ad
        MySql.Data.MySqlClient.MySqlCommand cmd = con.CreateCommand();
        
        cmd.Connection = con;
        cmd.CommandText = "call InsertAndGetAds('" + r.adkeywords + "','" + r.pubUrl + "','" + r.addesc + "','" + r.docText + "', 5)";
    
        MySql.Data.MySqlClient.MySqlDataReader reader = cmd.ExecuteReader();
        DataTable dt = new DataTable("ads");
        dt.Columns.Add("adid");
        dt.Columns.Add("adkeyword");
        dt.Columns.Add("adlink");
        dt.Columns.Add("adlinkdesc");
        dt.Columns.Add("matchscore");
        dt.Columns.Add("adaccessdate");
        
        while (reader.Read())
        {
            object[] results = new object[6];
            reader.GetValues(results);
            dt.Rows.Add(results);
        }

        con.Close();
        return dt;
    }

    public string GetAdsJSON(MySql.Data.MySqlClient.MySqlConnection con, PageAdJSONObject r, string jsonIn)
    {
        // get ads Dataset for the current context and convert to JSON
        string sql = "call getads('" + r.docText + "', 10)";
        MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter(sql, con);
        System.Data.DataSet ads = new System.Data.DataSet();
        adp.Fill(ads, "ads");
        
        string sJSON = AdppUtils.GetJSONString(ads.Tables["ads"]);

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
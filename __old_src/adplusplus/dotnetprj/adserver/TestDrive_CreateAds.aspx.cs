using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class TestDrive_CreateAds : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            try
            {
                string constr = System.Configuration.ConfigurationManager.ConnectionStrings[1].ConnectionString;

                MySql.Data.MySqlClient.MySqlConnection con = new MySql.Data.MySqlClient.MySqlConnection(constr);
                con.Open();
                MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
                cmd.Connection = con;
                cmd.CommandText = "call insertad('" + adKeywords.Value + "','" + adLink.Value + "','" + adDesc.Value + "')";
                cmd.ExecuteNonQuery();
                con.Close();

                lblResult.Text = "(Ad Created Successfully)";
            }
            catch
            {
                lblResult.Text = "(Failed to create Ad)";
            }
        }
    }
}
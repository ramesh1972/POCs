using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace adplusplus.TestFiles
{
    public partial class ManageAds : System.Web.UI.Page
    {
        private string ConnectionString = "Database=adppdb;Data Source=localhost;User Id=root;Password=root";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                MySql.Data.MySqlClient.MySqlConnection con = new MySql.Data.MySqlClient.MySqlConnection(ConnectionString);
                con.Open();
                MySql.Data.MySqlClient.MySqlCommand cmd = new MySql.Data.MySqlClient.MySqlCommand();
                cmd.Connection = con;
                cmd.CommandText = "call insertad('" + adKeywords.Value + "','" + adLink.Value + "','" + adDesc.Value + "')";
                cmd.ExecuteNonQuery();
                con.Close();
            }

            MySql.Data.MySqlClient.MySqlDataAdapter adp = new MySql.Data.MySqlClient.MySqlDataAdapter("select * from ads", ConnectionString);
            System.Data.DataSet adsds = new System.Data.DataSet();
            adp.Fill(adsds, "ads");

            GridView1.DataSource = adsds;
            GridView1.DataBind();
        }
    }
}
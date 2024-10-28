using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

namespace LAPS.FrontOffice
{
    public partial class UserControls_BankInfo : System.Web.UI.UserControl
    {
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserGUID"] == null)
                return;

            Guid usrGuid = (Guid)Session["UserGUID"];
            if (usrGuid == Guid.Empty)
                return;

            // load the user values from the database
            LAPS.LAMS.User usr = new LAPS.LAMS.User();
            LAPS.DataLayer.DataSets.Users.BankInfoRow br = usr.GetBankInfo(usrGuid);
            if (br == null)
                return;

            tbBranchSortCode.Text = br.BranchSortCode.Trim();
            tbSocAccNumber.Text = br.SocAccountNo.Trim();
        }
    }
}
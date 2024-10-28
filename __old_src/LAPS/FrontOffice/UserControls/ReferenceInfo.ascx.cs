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
    public partial class UserControls_ReferenceInfo : System.Web.UI.UserControl
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
            LAPS.DataLayer.DataSets.Users.ReferencesDataTable rdt = usr.GetReferenceInfo(usrGuid);
            if (rdt == null)
                return;

            if (rdt.Rows.Count > 0)
            {
                LAPS.DataLayer.DataSets.Users.ReferencesRow r1 = (LAPS.DataLayer.DataSets.Users.ReferencesRow) rdt.Rows[0];
                optRel.SelectedValue = r1.ReferenceRelation.Trim();

                Guid ref1guid = r1.ReferenceUserGUID;
                LAPS.DataLayer.DataSets.Users.UsersRow ur = usr.GetUserInfo(ref1guid);
                if (ur != null)
                    tbRefName.Text = ur.FirstName.Trim() + " " + ur.MiddleName.Trim() + " " + ur.LastName.Trim();
                
                if (rdt.Rows.Count > 1)
                {
                    LAPS.DataLayer.DataSets.Users.ReferencesRow r2 = (LAPS.DataLayer.DataSets.Users.ReferencesRow) rdt.Rows[1];
                    optRel2.SelectedValue = r2.ReferenceRelation.Trim();

                    Guid ref2guid = r2.ReferenceUserGUID;
                    LAPS.DataLayer.DataSets.Users.UsersRow ur2 = usr.GetUserInfo(ref2guid);
                    if (ur != null)
                        tbRefName2.Text = ur2.FirstName.Trim() + " " + ur2.MiddleName.Trim() + " " + ur2.LastName.Trim();
                }
            }
        }
    }

}
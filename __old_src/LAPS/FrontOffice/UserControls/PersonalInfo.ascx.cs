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
    public partial class PersonalInfo : System.Web.UI.UserControl
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
            LAPS.DataLayer.DataSets.Users.UsersRow ur = usr.GetUserInfo(usrGuid);
            if (ur == null)
                return;

            optTitle.SelectedValue = ur.Title.Trim();
            tbFirstName.Text = ur.FirstName.Trim();
            tbMidName.Text = ur.MiddleName.Trim();
            tbLastName.Text = ur.LastName.Trim();

            try
            {
                clnDOB.SelectedDate = ur.UserDOB;
            }
            catch { }

            tbPhoneNo.Text = ur.TelephoneNo.Trim();
            tbMobileNo.Text = ur.MobileNo.Trim();
            tbFaxNo.Text = ur.FaxNo.Trim();

            optTimeToCallFrom.SelectedValue = ur.TimeToCallFrom.Trim();
            optTimeToCallTo.SelectedValue = ur.TimeToCallTo.Trim();

            // load the address info values from the database
            LAPS.DataLayer.DataSets.Users.AddressesRow ar = usr.GetAddressInfo(usrGuid);
            if (ar == null)
                return;

            tbBldName.Text = ar.BuildingName.Trim();
            tbBldNo.Text = ar.BuildingNo.Trim();
            tbFlatNo.Text = ar.FlatNo.Trim();
            tbStreet.Text = ar.Street.Trim();
            tbTown.Text = ar.PostalTown.Trim();
            tbPostalCode.Text = ar.PostalCode.Trim();
            tbCounty.Text = ar.County.Trim();

            if (ar.OwnOrRent.Trim() == "Own")
            {
                optrOwn.Checked = true;
                optrRent.Checked = false;
            }
            else
            {
                optrOwn.Checked = false;
                optrRent.Checked = true;
            }

            try { tbResDurationMonths.Text = ar.DurationMonths.ToString(); }
            catch { }

            try { tbResDurationYears.Text = ar.DurationYears.ToString(); }
            catch { }

            LAPS.DataLayer.DataSets.Users.IdentityInfoDataTable idt = usr.GetIdentityInfo(usrGuid);
            foreach (LAPS.DataLayer.DataSets.Users.IdentityInfoRow ir in idt.Rows)
            {
                if (ir.IdentityNumberName.Trim() == "Driving License Number")
                    tbDrvLic.Text = ir.IdentityNo;
                else if (ir.IdentityNumberName.Trim() == "NIN")
                    tbNIN.Text = ir.IdentityNo;
            }
        }
    }
}
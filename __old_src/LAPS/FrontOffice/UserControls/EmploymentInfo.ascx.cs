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
    public partial class UserControls_EmploymentInfo : System.Web.UI.UserControl
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
            LAPS.DataLayer.DataSets.Users.EmploymentInfoRow er = usr.GetEmploymentInfo(usrGuid);
            if (er == null)
                return;

            // -- fill
            optSrcOfIncome.SelectedValue = er.SourceOfIncome.Trim();
            tbPayPerCheque.Text = er.PayPerCheque.ToString();

            if (er.PayDirectDeposit.Trim() == "Yes")
            {
                optPayDDYes.Checked = true;
                optPayDDNo.Checked = false;
            }
            else
            {
                optPayDDYes.Checked = false;
                optPayDDNo.Checked = true;
            }

            tbFreqWage.SelectedValue = er.FrequenceOfWage.Trim();
            optEmpType.SelectedValue = er.EmploymentType.Trim();

            try { clnNextPayDate.SelectedDate = er.NextPayDate; }
            catch { }

            try { clnFollowingPayDate.SelectedDate = er.NextPayDate; }
            catch { }

            tbCoName.Text = er.CompanyName.Trim();
            tbDepartment.Text = er.Department.Trim();
            tbPostHeld.Text = er.PostHeld.Trim();
            tbMgrName.Text = er.SupervisorName.Trim();

            tbEmpDurationYears.Text = er.DurationYears.ToString();
            tbEmpDurationMonths.Text = er.DurationMonths.ToString();

            tbCoPhoneNo.Text = er.CompanyMainNo.Trim();
        }
    }
}

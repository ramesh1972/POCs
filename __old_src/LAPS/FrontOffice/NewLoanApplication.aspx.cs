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

using Telerik.WebControls;

namespace LAPS.FrontOffice
{
    public partial class NewLoanApplication : System.Web.UI.Page
    {
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);

            btnNext.Click += new EventHandler(btnNext_Click);
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            string target = Request.Params["_EVENTTARGET_"];
            if (tabsNewLoan.SelectedTab.Text == "Personal Info")
            {
                EnableTab("Personal Info");
                LoadUserControl("PersonalInfo", @"~\UserControls\PersonalInfo.ascx");
            }
            else if (tabsNewLoan.SelectedTab.Text == "Employment Info")
            {
                EnableTab("Employment Info");
                LoadUserControl("EmploymentInfo", @"~\UserControls\EmploymentInfo.ascx");
            }
            else if (tabsNewLoan.SelectedTab.Text == "Bank Info")
            {
                EnableTab("Bank Info");
                LoadUserControl("BankInfo", @"~\UserControls\BankInfo.ascx");
            }
            else if (tabsNewLoan.SelectedTab.Text == "Reference Info")
            {
                EnableTab("Reference Info");
                LoadUserControl("ReferenceInfo", @"~\UserControls\ReferenceInfo.ascx");
            }
            else if (tabsNewLoan.SelectedTab.Text == "Loan Application")
            {
                EnableTab("Loan Application");
                LoadUserControl("LoanApplication", @"~\UserControls\LoanInfo.ascx");
            }
            else
            {
                // disable all the tabs, enable just the Create Account one
                EnableTab("Personal Info");

                // Show the new account create user control
                LoadUserControl("PersonalInfo", "~\\UserControls\\PersonalInfo.ascx");
            }
        }

        void btnNext_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
                return;

            // load next tab
            if (tabsNewLoan.SelectedTab.Text == "Personal Info")
            {

                SavePersonalInfo();

                EnableTab("Employment Info");
                LoadUserControl("EmploymentInfo", @"~\UserControls\EmploymentInfo.ascx");
            }
            else if (tabsNewLoan.SelectedTab.Text == "Employment Info")
            {
                SaveEmploymentInfo();

                EnableTab("Bank Info");
                LoadUserControl("BankInfo", @"~\UserControls\BankInfo.ascx");
            }
            else if (tabsNewLoan.SelectedTab.Text == "Bank Info")
            {
                SaveBankInfo();

                EnableTab("Reference Info");
                LoadUserControl("ReferenceInfo", @"~\UserControls\ReferenceInfo.ascx");
            }
            else if (tabsNewLoan.SelectedTab.Text == "Reference Info")
            {
                SaveReferenceInfo();

                EnableTab("Loan Application");
                LoadUserControl("LoanApplication", @"~\UserControls\LoanInfo.ascx");
            }
            else
            {
                // disable all the tabs, enable just the Create Account one
                EnableTab("Personal Info");

                // Show the new account create user control
                LoadUserControl("PersonalInfo", "~\\UserControls\\PersonalInfo.ascx");
            }
        }

        private bool SavePersonalInfo()
        {
            if (Session["UserGUID"] == null)
                return false;

            Guid usrGUID = (Guid) Session["UserGUID"];
            if (usrGUID == Guid.Empty)
                return false;

            UserControl uc = (UserControl)pnlNewLoan.FindControl("PersonalInfo");

            try
            {
                string ttl = ((ListBox)uc.FindControl("optTitle")).SelectedItem.Text;
                string fn = ((TextBox)uc.FindControl("tbFirstName")).Text;
                string mn = ((TextBox)uc.FindControl("tbMidName")).Text;
                string ln = ((TextBox)uc.FindControl("tbLastName")).Text;

                DateTime dob = ((RadDatePicker)uc.FindControl("clnDOB")).SelectedDate;

                string hno = ((TextBox)uc.FindControl("tbPhoneNo")).Text;
                string mno = ((TextBox)uc.FindControl("tbMobileNo")).Text;
                string fno = ((TextBox)uc.FindControl("tbFaxNo")).Text;

                string ttocallfrom = ((ListBox)uc.FindControl("optTimeToCallFrom")).SelectedItem.Text;
                string ttocallto = ((ListBox)uc.FindControl("optTimeToCallTo")).SelectedItem.Text;

                string bname = ((TextBox)uc.FindControl("tbBldName")).Text;
                string bno = ((TextBox)uc.FindControl("tbBldNo")).Text;
                string flatno = ((TextBox)uc.FindControl("tbFlatNo")).Text;
                string street = ((TextBox)uc.FindControl("tbStreet")).Text;
                string town = ((TextBox)uc.FindControl("tbTown")).Text;
                string pcode = ((TextBox)uc.FindControl("tbPostalCode")).Text;
                string county = ((TextBox)uc.FindControl("tbCounty")).Text;

                string own_rent = "Rent";
                RadioButton optrent = ((RadioButton)uc.FindControl("optrRent"));
                if (!optrent.Checked)
                    own_rent = "Own";
                int dy = -1;
                int dm = -1;
                try
                {
                    dy = System.Convert.ToInt32(((TextBox)uc.FindControl("tbResDurationYears")).Text);
                    dm = System.Convert.ToInt32(((TextBox)uc.FindControl("tbResDurationMonths")).Text);
                }
                catch
                {
                }

                string drvl = ((TextBox)uc.FindControl("tbDrvLic")).Text;
                string nin = ((TextBox)uc.FindControl("tbNIN")).Text;

                LAPS.LAMS.User usr = new LAPS.LAMS.User();
                usr.SaveUser(fn, mn, ln, dob, hno, mno, ttl, fno, ttocallfrom, ttocallto, usrGUID);

                usr.InsertAddress(usrGUID, bname, bno, flatno, street, town, pcode, county, own_rent, dy, dm);
                
                usr.InsertIdentityNo(usr.UserInfoGUID, "Driving License Number", drvl);
                usr.InsertIdentityNo(usr.UserInfoGUID, "NIN", nin);
                
                return true;
            }
            catch
            {
                return false;
            }
        }

        private bool SaveEmploymentInfo()
        {
            if (Session["UserGUID"] == null)
                return false;

            Guid usrGUID = (Guid)Session["UserGUID"];
            if (usrGUID == Guid.Empty)
                return false;

            UserControl uc = (UserControl)pnlNewLoan.FindControl("EmploymentInfo");

            try
            {
                string isrc = ((ListBox)uc.FindControl("optSrcOfIncome")).SelectedItem.Text;
                string pay = ((TextBox)uc.FindControl("tbPayPerCheque")).Text;
                float pay1 = -1;
                try
                {
                    pay1 = System.Convert.ToSingle(pay);
                }
                catch
                {
                }

                string pay_direct = "Yes";
                RadioButton optrd = ((RadioButton)uc.FindControl("optPayDDYes"));
                if (!optrd.Checked)
                    pay_direct = "No";

                string wagefreq = ((ListBox)uc.FindControl("tbFreqWage")).SelectedItem.Text;
                string emptype = ((ListBox)uc.FindControl("optEmpType")).SelectedItem.Text;

                DateTime nextpaydate = ((RadDatePicker)uc.FindControl("clnNextPayDate")).SelectedDate;
                DateTime follpaydate = ((RadDatePicker)uc.FindControl("clnFollowingPayDate")).SelectedDate;

                string cn = ((TextBox)uc.FindControl("tbCoName")).Text;
                string cdpt = ((TextBox)uc.FindControl("tbDepartment")).Text;
                string cpost = ((TextBox)uc.FindControl("tbPostHeld")).Text;

                string sup = ((TextBox)uc.FindControl("tbMgrName")).Text;

                int dury = -1;
                int durm = -1;
                try
                {
                    dury = System.Convert.ToInt32(((TextBox)uc.FindControl("tbEmpDurationYears")).Text);
                    durm = System.Convert.ToInt32(((TextBox)uc.FindControl("tbEmpDurationMonths")).Text);
                }
                catch
                {
                }

                string pno = ((TextBox)uc.FindControl("tbCoPhoneNo")).Text;

                LAPS.LAMS.User usr = new LAPS.LAMS.User();
                usr.InsertEmploymentInfo(usrGUID, isrc, pay1, pay_direct, wagefreq, emptype, nextpaydate, follpaydate, cn, cdpt, cpost, sup, pno, dury, durm);
                return true;
            }
            catch
            {
                return false;
            }
        }

        private bool SaveBankInfo()
        {
            if (Session["UserGUID"] == null)
                return false;

            Guid usrGUID = (Guid)Session["UserGUID"];
            if (usrGUID == Guid.Empty)
                return false;

            UserControl uc = (UserControl)pnlNewLoan.FindControl("BankInfo");

            try
            {
                string soc_no = ((TextBox)uc.FindControl("tbSocAccNumber")).Text;
                string sort_code = ((TextBox)uc.FindControl("tbBranchSortCode")).Text;

                LAPS.LAMS.User usr = new LAPS.LAMS.User();
                usr.InsertBankInfo(usrGUID, soc_no, sort_code);
                return true;
            }
            catch
            {
                return false;
            }
        }

        private bool SaveReferenceInfo()
        {
            if (Session["UserGUID"] == null)
                return false;

            Guid usrGUID = (Guid)Session["UserGUID"];
            if (usrGUID == Guid.Empty)
                return false;

            UserControl uc = (UserControl)pnlNewLoan.FindControl("ReferenceInfo");

            try
            {
                string ref1rel = ((ListBox)uc.FindControl("optRel")).SelectedItem.Text;
                string ref1name = ((TextBox)uc.FindControl("tbRefName")).Text;

                string ref2rel = ((ListBox)uc.FindControl("optRel2")).SelectedItem.Text;
                string ref2name = ((TextBox)uc.FindControl("tbRefName2")).Text;

                LAPS.LAMS.User usr = new LAPS.LAMS.User();
                usr.InsertReferenceInfo(usrGUID, ref1rel, ref1name);
                usr.InsertReferenceInfo(usrGUID, ref2rel, ref2name);

                return true;
            }
            catch
            {
                return false;
            }
        }

        private bool SaveLoanApplication()
        {
            if (Session["UserGUID"] == null)
                return false;

            Guid usrGUID = (Guid)Session["UserGUID"];
            if (usrGUID == Guid.Empty)
                return false;

            UserControl uc = (UserControl)pnlNewLoan.FindControl("LoanInfo");

            try
            {
                float loan_amount = 0;
                try
                {
                    loan_amount = System.Convert.ToSingle(((TextBox)uc.FindControl("tbLoanAmount")).Text);
                }
                catch {}

                return true;
            }
            catch 
            {
                return false;
            }
        }

        private void LoadUserControl(string id, string user_control_file)
        {
            LAPS.FrontOffice.Utils.LoadUserControl(Page, pnlNewLoan, id, user_control_file);
        }

        private void EnableTab(string tab_text)
        {
            LAPS.FrontOffice.Utils.EnableTab(tabsNewLoan, tab_text);
        }
   }
}
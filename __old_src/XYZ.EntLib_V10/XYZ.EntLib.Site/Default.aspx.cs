using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections;

using XYZ.EntLib.AppBlocks;

public partial class _Default : System.Web.UI.Page 
{
    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        logGrid.RowDataBound += new GridViewRowEventHandler(logGrid_RowDataBound);
        logGrid.SelectedIndexChanged += new EventHandler(logGrid_SelectedIndexChanged);
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (IsPostBack)
        {
            // recreate the info panel
            GridViewRow row = logGrid.SelectedRow;
            if (row == null)
                return;

            string s1 = row.Cells[1].Text;

            Guid log_id = new Guid(s1);
            LogInfo info = new LogInfo(log_id);

            ArrayList list = info.GetRelatedLogEntriesList();

            InfoListPanel.Controls.Clear();
            foreach (string s in list)
            {
                LinkButton lb = new LinkButton();
                lb.ID = s + "_btn";
                lb.Text = s;
                InfoListPanel.Controls.Add(lb);
                lb.Click += new EventHandler(lb_Click);

                InfoListPanel.Controls.Add(ParseControl("</br>"));
            }
        }
    }

    void logGrid_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowIndex == -1)
            return;

        System.Data.DataRowView drv;
        drv = (System.Data.DataRowView)e.Row.DataItem;
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            if (drv != null)
            {
                string err_msg = (string) drv[5];
                if (err_msg == "")
                    err_msg = "Click Select for Details";

                // set this value in the column
                e.Row.Cells[5].Text = err_msg;
            }
        }
    }

    protected void logGrid_SelectedIndexChanged(object sender, EventArgs e)
    {
        // get the log message
        try
        {
            GridViewRow row = logGrid.SelectedRow;

            string s1 =  row.Cells[1].Text;

            Guid log_id = new Guid(s1);
            LogInfo info = new LogInfo(log_id);

            ArrayList list = info.GetRelatedLogEntriesList();
            InfoListPanel.Controls.Clear();
            foreach (string s in list)
            {
                LinkButton lb = new LinkButton();
                lb.ID = s + "_btn";
                lb.Text = s;
                InfoListPanel.Controls.Add(lb);
                lb.Click += new EventHandler(lb_Click);

                InfoListPanel.Controls.Add(ParseControl("</br>"));
            }
        }
        catch (Exception exp)
        {
        }
    }

    void lb_Click(object sender, EventArgs e)
    {
        // get the selected guid
        GridViewRow row = logGrid.SelectedRow;
        string s1 = row.Cells[1].Text;
        Guid log_id = new Guid(s1);

        // get the detailed info type
        string infotype = ((LinkButton)sender).Text;

        LogInfo info = new LogInfo(log_id);
        string html = info.GetHtml(infotype);

        // get the detailed info
        Label l = new Label();
        l.Text = html;

        
        InfoPanel.Controls.Add(l);
    }

    protected override void RaisePostBackEvent(IPostBackEventHandler sourceControl, string eventArgument)
    {
        
        base.RaisePostBackEvent(sourceControl, eventArgument);
    }
}


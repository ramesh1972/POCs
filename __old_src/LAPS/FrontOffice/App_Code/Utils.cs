using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

using Telerik.WebControls;

namespace LAPS.FrontOffice
{
    public class Utils
    {
        static public void LoadUserControl(Page page, Control parent, string id, string user_control_file)
        {
            Control uc = page.LoadControl(user_control_file);
            if (uc == null)
                return;

            uc.ID = id;
            parent.Controls.Clear();
            parent.Controls.Add(uc);
        }

        static public void EnableTab(RadTabStrip tabstrip, string tab_text)
        {
            Tab t = null;
            foreach (Tab t1 in tabstrip.Tabs)
            {
 //               t1.Selected = false;
   //             t1.Enabled = false;

                if (t1.Text == tab_text)
                    t = t1;
            }

            t.Enabled = true;
            t.Selected = true;
        }
     }
}
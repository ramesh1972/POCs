using System;
using System.IO;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

using Telerik.WebControls;

namespace RVK.TechDocs
{
	/// <summary>
	/// Summary description for _Default.
	/// </summary>
	public partial class DefaultCS: Page
	{
		
		
		private void BindTreeToDirectory(string dirPath, RadTreeNode parentNode)
		{
			string[] dirs = Directory.GetDirectories(dirPath);
			foreach (string s in dirs)
			{
				
				string[] parts = s.Split('\\');
				string name = parts[parts.Length-1];
				if (name != "Examples")
				{
					RadTreeNode node = new RadTreeNode(name);
					node.ImageUrl = "Folder.gif";
					node.Value = name;
					node.Category = "Folder";
					parentNode.Nodes.Add(node);

                    BindTreeToDirectory(dirPath + "\\" + name, node);
				}	
			}

			string[] files = Directory.GetFiles(dirPath);
			foreach (string fileNAme in files)
			{
				string[] parts = fileNAme.Split('\\');
				string name = parts[parts.Length-1];
				RadTreeNode node = new RadTreeNode(name);				

				FileInfo fi = new FileInfo(fileNAme); 
				node.ImageUrl = "File.gif";
				node.Value = String.Format("{0}@{1}@{2}", fi.Name, fi.Length, fi.LastWriteTime.ToString());
				node.Category = "File";
				parentNode.Nodes.Add(node);
			}			
		}
		
		protected void Page_Load(object sender, EventArgs e)
		{		
			if (!Page.IsPostBack)
			{
                string rootFolder = @"c:\ramesh\tdocs\";
		
				RadTreeNode rootNode = new RadTreeNode(rootFolder);
				rootNode.ImageUrl = "Folder.gif";
				rootNode.Category = "Folder";
				rootNode.Expanded = true;
				RadTree1.Nodes.Add(rootNode);

				BindTreeToDirectory(rootFolder, rootNode);			
			}
		}

		#region Web Form Designer generated code
		override protected void OnInit(EventArgs e)
		{
			//
			// CODEGEN: This call is required by the ASP.NET Web Form Designer.
			//
			InitializeComponent();
			base.OnInit(e);
		}
		
		///		Required method for Designer support - do not modify
		///		the contents of this method with the code editor.
		/// </summary>
		private void InitializeComponent()
		{			
			this.Load += new System.EventHandler(this.Page_Load);

		}
		#endregion


	}
}

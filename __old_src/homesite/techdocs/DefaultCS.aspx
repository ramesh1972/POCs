<%@ Register TagPrefix="radT" Namespace="Telerik.WebControls" Assembly="RadTreeView.NET2" %>
<%@ Page AutoEventWireup="false" CodeFile="DefaultCS.aspx.cs" Inherits="RVK.TechDocs.DefaultCS" Language="c#" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html>
  <head runat="server">
  </head>
	<body class="BODY">
		<form runat="server" id="mainForm" method="post" style="WIDTH:100%">
			<!-- content start -->
			<script type="text/javascript">
			function UpdateStatus(node)
			{
				if (node.Category == "Folder")
				{
					document.getElementById("name").innerHTML = "Folder";
					document.getElementById("size").innerHTML = "N/A";
					document.getElementById("date").innerHTML = "N/A";
				}
				else
				{
					var arr = node.Value.split("@");
					document.getElementById("name").innerHTML = arr[0];
					document.getElementById("size").innerHTML = arr[1];
					document.getElementById("date").innerHTML = arr[2];	
				}
			}
			</script>

			<table width="98%" cellspacing="6" cellpadding="0" class="module" style="PADDING-RIGHT:3px;PADDING-LEFT:3px;PADDING-BOTTOM:3px;PADDING-TOP:3px">
				<tr class="text">
					<td colspan="2" valign="top" style="FONT-WEIGHT:bold; FONT-SIZE:11px; BORDER-BOTTOM:#e2e2e2 1px solid; height: 20px;">
						Client Side Load On Demand from Directory structure
					</td>
				</tr>
				<tr>
					<td valign="top" style="width: 300px">
						<radT:RadTreeView				
							ID="RadTree1"				
							runat="server"				
							AfterClientHighlight="UpdateStatus"				
							Skin="Classic"
							ImagesBaseDir="~/Img/WindowsXP"
							Width="400px"
							Height="400px">
						</radT:RadTreeView>
					</td>
					<td valign="top" align="left" style="width: 300px;">
						<table width="100%">
							<tr>
								<td><b>Name:</b></td>
								<td><span id="name"></span></td>
							</tr>
							<tr>
								<td><b>Size:</b></td>
								<td><span id="size"></span></td>
							</tr>
							<tr>
								<td><b>Last Modified:</b></td>
								<td><span id="date"></span></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>

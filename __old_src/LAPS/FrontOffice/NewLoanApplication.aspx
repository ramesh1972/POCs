<%@ Page Language="C#" AutoEventWireup="true"  MasterPageFile="~/FrontOffice.master" CodeFile="NewLoanApplication.aspx.cs" Inherits="LAPS.FrontOffice.NewLoanApplication" %>
<%@ Register TagPrefix="radTS" Namespace="Telerik.WebControls" Assembly="RadTabStrip.Net2" %>

    <asp:Content ContentPlaceHolderID="FrontOffice_Content" runat="server">
    <span class="page_content_title">Apply for a New Loan<br />
    </span>
    <br />

    <table cellspacing=0 cellpadding=0 border=0>
    <tr align=left valign=top>
    <td>
        <radTS:RadTabStrip 
	        ID="tabsNewLoan" 
	        runat="server" 
	        Skin="Outlook" 
	         SelectedIndex=0
	          AutoPostBack=True>
	        <Tabs>
		        <radts:Tab Text="Personal Info" Enabled=true></radts:Tab>
		        <radts:Tab  Text="Employment Info" Enabled=false></radts:Tab>
		        <radts:Tab  Text="Bank Info" Enabled=false></radts:Tab>
		        <radts:Tab  Text="Reference Info" Enabled=false></radts:Tab>
		        <radts:Tab  Text="Loan Application" Enabled=false></radts:Tab>
	        </Tabs>
        </radTS:RadTabStrip>
    </td>
    </tr>
    <tr align=left valign=top>
    <td>
    <asp:Panel ID=pnlNewLoan runat=server></asp:Panel>
    </td>
    </tr>
    <tr valign=middle><td align=right height=40px style="padding-right:4px"><asp:Button ID=btnNext Text="Next >>" runat="server" /></td></tr>
    </table>
</asp:Content>
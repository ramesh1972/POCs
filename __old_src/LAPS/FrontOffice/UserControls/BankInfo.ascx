<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BankInfo.ascx.cs" Inherits="LAPS.FrontOffice.UserControls_BankInfo" %>

<%@ Register Assembly="Microsoft.Practices.EnterpriseLibrary.Validation.Integration.AspNet"
    Namespace="Microsoft.Practices.EnterpriseLibrary.Validation.Integration.AspNet"
    TagPrefix="cc1" %>

<table cellpadding=0 cellspacing=0 border=0 width=100% style="padding-top:4px;">
<tr align=left valign=middle>
    <td><span class="control_label">Bank/Building Society Account Number</span></td>
    <td>
    <asp:TextBox runat="server" ID=tbSocAccNumber Columns=20></asp:TextBox>
    <cc1:propertyproxyvalidator id="Propertyproxyvalidator8" runat="server" ControlToValidate="tbSocAccNumber" PropertyName="SocAccountNo" RulesetName="Rule Set" SourceTypeName="LAPS.DataLayer.DataSets.Users+BankInfoRow" Font-Size=Small SpecificationSource=Configuration></cc1:propertyproxyvalidator>
    </td>
</tr>
<tr align=left valign=middle>
    <td><span class="control_label">Branch Sort Code</span></td>
    <td>
    <asp:TextBox runat="server" ID=tbBranchSortCode Columns=10></asp:TextBox>
    <cc1:propertyproxyvalidator id="Propertyproxyvalidator1" runat="server" ControlToValidate="tbBranchSortCode" PropertyName="BranchSortCode" RulesetName="Rule Set" SourceTypeName="LAPS.DataLayer.DataSets.Users+BankInfoRow" Font-Size=Small SpecificationSource=Configuration></cc1:propertyproxyvalidator>
    </td>
</tr>
</table>
<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ReferenceInfo.ascx.cs" Inherits="LAPS.FrontOffice.UserControls_ReferenceInfo" %>

<%@ Register Assembly="Microsoft.Practices.EnterpriseLibrary.Validation.Integration.AspNet"
    Namespace="Microsoft.Practices.EnterpriseLibrary.Validation.Integration.AspNet"
    TagPrefix="cc1" %>

<span class="control_label">Reference 1</span>
<table cellpadding=0 cellspacing=0 border=0 width=100% style="padding-top:4px;">
<tr align=left valign=middle>
    <td><span class="control_label">Relationship</span></td>
    <td>
    <asp:ListBox Rows=1 runat=server  ID=optRel>
        <asp:ListItem Text="Parent" Value="Parent"></asp:ListItem>
        <asp:ListItem Text="Sibling" Value="Sibling"></asp:ListItem>
        <asp:ListItem Text="Spouse" Value="Spouse"></asp:ListItem>
        <asp:ListItem Text="Friend" Value="Friend"></asp:ListItem>
        <asp:ListItem Text="Supervisor" Value="Supervisor"></asp:ListItem>
        <asp:ListItem Text="Coworker" Value="Coworker"></asp:ListItem>
        <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
    </asp:ListBox>
    </td>
</tr>
<tr align=left valign=middle>
    <td><span class="control_label">Reference Name</span></td><td>
    <asp:TextBox runat="server" ID=tbRefName Columns=20></asp:TextBox>
    <cc1:propertyproxyvalidator id="Propertyproxyvalidator8" runat="server" ControlToValidate="tbRefName" PropertyName="FirstName" RulesetName="Rule Set" SourceTypeName="LAPS.DataLayer.DataSets.Users+UsersRow" Font-Size=Small SpecificationSource=Configuration></cc1:propertyproxyvalidator>
    </td>
</tr>
</table>

<hr />
<span class="control_label">Reference 2</span>
<table cellpadding=0 cellspacing=0 border=0 width=100% style="padding-top:4px;">
<tr align=left valign=middle>
    <td><span class="control_label">Relationship</span></td>
    <td>
    <asp:ListBox Rows=1 runat=server  ID=optRel2>
        <asp:ListItem Text="Parent" Value="Parent"></asp:ListItem>
        <asp:ListItem Text="Sibling" Value="Sibling"></asp:ListItem>
        <asp:ListItem Text="Spouse" Value="Spouse"></asp:ListItem>
        <asp:ListItem Text="Friend" Value="Friend"></asp:ListItem>
        <asp:ListItem Text="Supervisor" Value="Supervisor"></asp:ListItem>
        <asp:ListItem Text="Coworker" Value="Coworker"></asp:ListItem>
        <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
    </asp:ListBox>
    </td>
</tr>
<tr align=left valign=middle>
    <td><span class="control_label">Reference Name</span></td><td>
    <asp:TextBox runat="server" ID=tbRefName2 Columns=20></asp:TextBox>
    <cc1:propertyproxyvalidator id="Propertyproxyvalidator1" runat="server" ControlToValidate="tbRefName2" PropertyName="FirstName" RulesetName="Rule Set" SourceTypeName="LAPS.DataLayer.DataSets.Users+UsersRow" Font-Size=Small SpecificationSource=Configuration></cc1:propertyproxyvalidator>
    </td>
</tr>
</table>
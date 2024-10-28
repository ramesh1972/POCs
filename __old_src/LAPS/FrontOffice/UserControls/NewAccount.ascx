<%@ Control Language="C#" AutoEventWireup="true" CodeFile="NewAccount.ascx.cs" Inherits="LAPS.FrontOffice.NewAccount" %>

<%@ Register Assembly="Microsoft.Practices.EnterpriseLibrary.Validation.Integration.AspNet"
    Namespace="Microsoft.Practices.EnterpriseLibrary.Validation.Integration.AspNet"
    TagPrefix="cc1" %>
<SCRIPT FOR = "<%= tbEmailAddress2.ClientID %>" EVENT = onkeydown language=javascript>
    if (event.ctrlKey == true && event.keyCode == 86)
    {
        event.cancelBubble = true;
        event.returnValue = false;
     }
     else
        return true;
</SCRIPT>

<SCRIPT FOR = "<%= tbPassword2.ClientID %>" EVENT = onkeydown language=javascript>
    if (event.ctrlKey == true && event.keyCode == 86)
    {
        event.cancelBubble = true;
        event.returnValue = false;
     }
     else
        return true;
</SCRIPT>

<script language="javascript">
function CompareFields()
{
    var btn = document.all("<%= btnNewAccount.ClientID %>").value;
    var e1 = document.all("<%= tbEmailAddress.ClientID %>").value;
    var e2 = document.all("<%= tbEmailAddress2.ClientID %>").value;
    
    var p1 = document.all("<%= tbPassword.ClientID %>").value;
    var p2 = document.all("<%= tbPassword2.ClientID %>").value;

    var err = "";
    if (e1 != e2)
        err = "The Email Addresses should match.";
        
    if (p1 != p2)
        err += " The Passwords should match.";
        
    document.all("<%= lblError.ClientID %>").innerText = err;

    if (err != "")
    {
        event.cancelBubble = true;
		event.returnValue = false;
	}
    else
        return true;
}
</script>

<table cellpadding=0 cellspacing=0 border=0 style="padding-left:4px">
<tr align=center valign=middle>
<td colspan=4 height=40px ><span class=form_title>Create a New Pay Day Advance Account</span></td>
</tr>
<tr align=left valign=middle>
<td><span class="control_label">Enter Email Address</span></td>
<td>
    <asp:TextBox runat="server" ID=tbEmailAddress Columns=40></asp:TextBox>
    <cc1:propertyproxyvalidator id="Propertyproxyvalidator8" runat="server" ControlToValidate="tbEmailAddress" PropertyName="EmailAddress" RulesetName="Rule Set" SourceTypeName="LAPS.DataLayer.DataSets.Users+UsersRow" Font-Size=Small SpecificationSource=Configuration></cc1:propertyproxyvalidator>    
</td>
</tr>
<tr align=left valign=middle>
<td><span class="control_label">Re-Enter Email Address</span></td>
<td>
    <asp:TextBox runat="server" ID=tbEmailAddress2 Columns=40  AutoCompleteType=None onkeypress=></asp:TextBox>
    <cc1:propertyproxyvalidator id="Propertyproxyvalidator1" runat="server" ControlToValidate="tbEmailAddress2" PropertyName="EmailAddress" RulesetName="Rule Set" SourceTypeName="LAPS.DataLayer.DataSets.Users+UsersRow" Font-Size=Small SpecificationSource=Configuration></cc1:propertyproxyvalidator>
</td>
</tr>
<tr align=left valign=middle>
<td><span class="control_label">Enter Password</span></td>
<td>
    
    <asp:TextBox TextMode=Password ID="tbPassword" runat="server" Columns=10/>
    <cc1:propertyproxyvalidator id="Propertyproxyvalidator2" runat="server" ControlToValidate="tbPassword" PropertyName="Password" RulesetName="Rule Set" SourceTypeName="LAPS.DataLayer.DataSets.Users+UserAccountsRow" Font-Size=Small SpecificationSource=Configuration></cc1:propertyproxyvalidator>
    </td>
</tr>
<tr align=left valign=middle>
<td><span class="control_label">Confirm Password</span></td>
<td>
    <asp:TextBox TextMode=Password ID="tbPassword2" runat="server" Columns=10/>
    <cc1:propertyproxyvalidator id="Propertyproxyvalidator3" runat="server" ControlToValidate="tbPassword2" PropertyName="Password" RulesetName="Rule Set" SourceTypeName="LAPS.DataLayer.DataSets.Users+UserAccountsRow" Font-Size=Small SpecificationSource=Configuration></cc1:propertyproxyvalidator>
</td>
</tr>
<tr align=left valign=middle>
<td align=center colspan=2 height=40px valign=middle>
    <asp:Label ID="lblError" runat="server" CssClass="error_string"></asp:Label><br />
    <asp:Button ID=btnNewAccount runat="server" Text="Create Account" OnClientClick="CompareFields();"/>
</td>
</tr>
</table>

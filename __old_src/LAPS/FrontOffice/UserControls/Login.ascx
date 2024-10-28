<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Login.ascx.cs" Inherits="LAPS.FrontOffice.UserControls_Login" %>

<table cellpadding=0 cellspacing=0 border=0 style="padding-left:4px">
<tr align=center valign=middle>
<td colspan=4 height=40px ><span class=form_title>Returning Customers Login</span></td>
</tr>
<tr align=left valign=middle>
<td><span class="control_label">Enter Email Address</span></td>
<td>
    <asp:TextBox runat="server" ID=tbEmailAddress Columns=40></asp:TextBox>
</td>
</tr>
<tr align=left valign=middle>
<td><span class="control_label">Enter Password</span></td><td><asp:TextBox ID="tbPassword" TextMode=Password Columns=20 runat="server" /></td>
</tr>
<tr align=left valign=middle>
<td align=center colspan=2 height=40px valign=middle><asp:Label ID="lblError" runat="server" CssClass="error_string"></asp:Label><br />
<asp:Button ID=btnLogin runat="server" Text="Login" /></td>
</tr>
</table>

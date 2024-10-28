<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/TestDrive.master" CodeFile="TestDrive_CreateAds.aspx.cs" Inherits="TestDrive_CreateAds" %>

<asp:Content runat=server ContentPlaceHolderID=TestDriveContent>
        <span class=standard_font style="margin:4px"><B>Create an Ad</B></span><asp:Label ID=lblResult runat=server class=standard_font></asp:Label><br />
        <table width=100% class=standard_font style="margin:4px">
            <tr><td width=150px>Enter Ad Link</td><td><input id="adLink" type="text" runat="server" style="width:300px"/></td></tr>
            <tr><td>Enter Ad Keywords (Comma Separated)</td><td><input id=adKeywords type=text runat=server style='width:300px'/></td></tr>
            <tr><td>Enter Ad Description</td><td><input id=adDesc type=text runat=server style='width:300px'/></td></tr>
            <tr><td colspan=2>    <input id="Submit1" type=submit value=Create runat=server /></td></tr>
        </table>
        

</asp:Content>
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageAds.aspx.cs" Inherits="adplusplus.TestFiles.ManageAds" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <span style='font-weight:bold'>Create an Ad</span><br />
        <table width=100%>
            <tr><td>Enter Ad Link</td><td><input id="adLink" type="text" runat="server" /></td></tr>
            <tr><td>Enter Ad Keywords</td><td><input id=adKeywords type=text runat=server /></td></tr>
            <tr><td>Enter Ad Description</td><td><input id=adDesc type=text runat=server /></td></tr>
            <tr><td colspan=2>    <input id="Submit1" type=submit value=Create runat=server /></td></tr>
        </table>
        <br />

        <span style='font-weight:bold'>Ads in the DB</span><br />
        <asp:GridView id="GridView1" runat="server"></asp:GridView>
    </form>
</body>
</html>
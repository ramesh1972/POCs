<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/TestDrive.master" CodeFile="TestDrive_ViewAds.aspx.cs" Inherits="ViewAds" %>

<asp:Content ContentPlaceHolderID=TestDriveContent runat=server>
    <table width=100% height=100%>
    <tr>
    <td align=center>
    <span class=standard_font><B>Ads in the adPlusPlus.com Database</B></span><br />
    <asp:GridView id="GridView1" runat="server" BackColor=White>
        <asp:Columns>
            <asp:BoundField HeaderStyle-BackColor=Gray HeaderText="Ad Link" DataField="adlink" ItemStyle-Wrap=true/>
            <asp:BoundField HeaderStyle-BackColor=Gray HeaderText="Ad Key Word" DataField="adkeyword" ItemStyle-Wrap=true/>
            <asp:BoundField HeaderStyle-BackColor=Gray HeaderText="Ad Description" DataField="adlinkdesc" ItemStyle-Width=100% ItemStyle-Wrap=true/>
        </asp:Columns>
    </asp:GridView>
    </td></tr></table>
</asp:Content>
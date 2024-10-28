<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/FrontOffice.master" CodeFile="Home.aspx.cs" Inherits="LAPS.FrontOffice.Home" %>

<asp:Content ContentPlaceHolderID=FrontOffice_Content runat="server">
    <table width=100% height=100%>
        <tr>  
            <td width=50% align=center>
                <asp:Panel ID=pnlNewAccount runat="server" HorizontalAlign=Center></asp:Panel>
            </td>
            <td>
                <asp:Panel ID=pnlLogin runat="server" HorizontalAlign=Center></asp:Panel>
            </td>
        </tr>
    </table>
</asp:Content>
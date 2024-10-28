<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">

</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <asp:TreeView ID="TreeView1" runat="server" DataSourceID="XmlDataSourceTree">
    </asp:TreeView>
    <asp:XmlDataSource ID="XmlDataSourceTree" runat="server" 
        DataFile="~/MenuTree.xml" XPath="Folder"></asp:XmlDataSource>
</asp:Content>

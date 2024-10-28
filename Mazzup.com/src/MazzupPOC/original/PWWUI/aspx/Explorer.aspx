<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Explorer.aspx.cs" MasterPageFile="~/Site.master" Inherits="aspx_Explorer" %>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <asp:TreeView ID="TreeView1" runat="server" DataSourceID="XmlDataSourceTree"></asp:TreeView>
    <asp:XmlDataSource ID="XmlDataSourceTree" runat="server" DataFile="MenuTree.xml" XPath="Folder"></asp:XmlDataSource>
    </asp:Content>
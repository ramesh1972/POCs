<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Log/Errors/Exceptions Reported</title>
</head>
<body style="margin:0">
    <form id="form1" runat="server">
        <table border=1 cellpadding=0 cellspacing=0 width=100% height=100%>
        <tr align =left valign=left>
        <td height=50%  colspan=2>
        <H2>Log Messages Center</h2>
        <asp:GridView ID="logGrid" runat="server" AutoGenerateColumns="False" BackColor="White"
            BorderColor="black" BorderStyle="Solid" BorderWidth="1px" DataSourceID="LogMessages"
            GridLines="Both" AllowSorting=True AllowPaging="True" Height=50% Width=2500 autogenerateselectbutton="true">
            <Columns>
                <asp:BoundField DataField="id" HeaderText="Id" SortExpression=""/>
                <asp:BoundField DataField="appDomainName" HeaderText="AppDomain Name" SortExpression="appDomainName" />
                <asp:BoundField DataField="timeStamp" HeaderText="Issue Reported" SortExpression="timeStamp" HeaderStyle-Width="200px"/>
                <asp:BoundField DataField="loggedSeverity" HeaderText="Issue Severity" SortExpression="loggedSeverity" />
                <asp:CommandField HeaderText="Log Message" HeaderStyle-Width="500px"/>
                <asp:BoundField DataField="categoriesId" HeaderText="Category" SortExpression="categoriesId"  />
                <asp:BoundField DataField="machineName" HeaderText="Machine Name" SortExpression="machineName" />
                <asp:BoundField DataField="processName" HeaderText="Process Name" SortExpression="processName" />
                <asp:BoundField DataField="processId" HeaderText="Process Id" SortExpression="processId" />
                <asp:BoundField DataField="win32ThreadId" HeaderText="Thread Id" SortExpression="win32ThreadId" />
                <asp:BoundField DataField="priority" HeaderText="Issue Priority" SortExpression="priority" />
            </Columns>
            <RowStyle BackColor="#FFFFFF" ForeColor="#000000" />
            <AlternatingRowStyle BackColor="#F7F7F7" />
            <selectedrowstyle backcolor="LightCyan"
                forecolor="DarkBlue"
                font-bold="true"/>             
            <PagerStyle BackColor="#000000" ForeColor="#FFFFFF" HorizontalAlign="Left" />
            <HeaderStyle BackColor="#000000" Font-Bold="True" ForeColor="#F7F7F7"  HorizontalAlign="Left"/>
        </asp:GridView>
        </tr>
        </td>
        <tr align =left valign=left>
        <td height=50%>
        
        <H2>Detailed Log</h2>
        <table border=1 cellpadding=0 cellspacing=0 width=100% height=100%>
        <tr valign=top align=left>
        <td width=200px><asp:Panel runat=server ID=InfoListPanel></asp:Panel></td>
        <td><asp:Panel runat=server ID=InfoPanel></asp:Panel></td></tr>
        </table>
        </table>
        <asp:SqlDataSource ID="LogMessages" runat="server" ConnectionString="<%$ ConnectionStrings:ErrorDBConnectionString %>"
            SelectCommand="SELECT * FROM LogEntry ORDER BY LogEntry.timeStamp DESC">
        </asp:SqlDataSource>
    </div>
    </form>
</body>
</html>

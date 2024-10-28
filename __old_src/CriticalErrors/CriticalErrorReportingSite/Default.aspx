<%@ Page Language="C#" AutoEventWireup="true"  CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Critical Errors Reported</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <span style="font-family: @Arial Unicode MS; font-size: 14pt; color: #4a3c8c;"><strong>
        Critical Errors Reported</strong></span><br />
        <br />
        <asp:GridView ID="_gvMainExceptionView" runat="server" AutoGenerateColumns="False" BackColor="White"
            BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="CriticalErrors"
            GridLines="Horizontal" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" AllowPaging="True" Width="100%">
            <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
            <Columns>
                <asp:BoundField DataField="timeStamp" HeaderText="Issue Reported" SortExpression="timeStamp" />
                <asp:hyperlinkfield SortExpression="issueTag" DataTextField="issueTag"            
                    HeaderText="Issue Tag" DataNavigateUrlFields="exceptionId" DataNavigateUrlFormatString="~\IssueDetails.aspx?exceptionId={0}"/>
                <asp:BoundField DataField="description" HeaderText="Error Description" SortExpression="description" />
                <asp:BoundField DataField="priority" HeaderText="Issue Priority" SortExpression="priority" />
                <asp:BoundField DataField="loggedSeverity" HeaderText="Issue Severity" SortExpression="loggedSeverity" />
                <asp:BoundField DataField="siteCode" HeaderText="Site Code" SortExpression="siteCode" />
            </Columns>
            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
            <AlternatingRowStyle BackColor="#F7F7F7" />
        </asp:GridView>
        <asp:SqlDataSource ID="CriticalErrors" runat="server" ConnectionString="<%$ ConnectionStrings:CriticalErrorConnectionString %>"
            SelectCommand="SELECT LogEntry.siteCode, LogEntry.issueTag, LogEntry.priority, LogEntry.loggedSeverity, LogEntry.timeStamp, Exception.description, LogEntry.exceptionId FROM LogEntry INNER JOIN Exception ON LogEntry.exceptionId = Exception.id ORDER BY LogEntry.timeStamp DESC">
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>

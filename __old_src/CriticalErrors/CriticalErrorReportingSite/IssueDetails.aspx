<%@ Page Language="C#" AutoEventWireup="true" CodeFile="IssueDetails.aspx.cs" Inherits="IssueDetails" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Critical Errors Exception Information</title>
</head>
<body style="font-family:@Arial Unicode MS">
    <form id="form1" runat="server">
    <div >
        <span >
        <strong><span style="font-size: 14pt; color: #4a3c8c;">
        Critical Error Details</span></strong><br />
            <asp:HyperLink ID="_lnkException" runat="server" ForeColor="#0000C0" NavigateUrl="#_lblException">Exception Details</asp:HyperLink><br />
            <asp:HyperLink ID="_lnkExceptionData" runat="server" ForeColor="#0000C0" NavigateUrl="#_lblExceptionData">Exception Data</asp:HyperLink>
            <br />
            <asp:HyperLink ID="_lnkExceptionProperties" runat="server" ForeColor="#0000C0" NavigateUrl="#_lblExceptionProperties">Exception Properties</asp:HyperLink><br />
            <asp:HyperLink ID="_lnkExceptionFields" runat="server" ForeColor="#0000C0" NavigateUrl="#_lblExceptionFields">Exception Fields</asp:HyperLink><br />
            <asp:HyperLink ID="_lnkInner" runat="server" ForeColor="#0000C0" NavigateUrl="#_lblInner">Inner Exception Information</asp:HyperLink><br />
            <asp:HyperLink ID="_lnkTgtSite" runat="server" ForeColor="#0000C0" NavigateUrl="#_lblTgtSite">Target Site Information</asp:HyperLink><br />
            <asp:HyperLink ID="_lnkGenArgs" runat="server" ForeColor="#0000C0" NavigateUrl="#_lblGenArgs">Target Site Generic Arguments</asp:HyperLink><br />
            <asp:HyperLink ID="_lnkAdditionalInfo" runat="server" ForeColor="#0000C0" NavigateUrl="#_lblAdditionalInfo">Additional Exception Information</asp:HyperLink><br />
            <asp:HyperLink ID="_lnkDiagnosticInfo" runat="server" ForeColor="#0000C0" NavigateUrl="#_lblDiagInfo">Diagnostic Information</asp:HyperLink><br />
            <asp:HyperLink ID="_lnkHostEnv" runat="server" ForeColor="#0000C0" NavigateUrl="#_lblHostEnv">Host Characteristics</asp:HyperLink><br />
            <asp:HyperLink ID="_lnkProcessInfo" runat="server" ForeColor="#0000C0" NavigateUrl="#_lblProcessInfo">Process Information</asp:HyperLink><br />
            <asp:HyperLink ID="_lnkProcessEnvVar" runat="server" ForeColor="#0000C0" NavigateUrl="#_lblProcEnvVar">Process Environment Variables</asp:HyperLink><br />
            <asp:HyperLink ID="_lnkStartInfo" runat="server" ForeColor="#0000C0" NavigateUrl="#_lblStartInfo">Process Start Information</asp:HyperLink><br />
            <asp:HyperLink ID="_lnkStartInfoEnvVar" runat="server" ForeColor="#0000C0" NavigateUrl="#_lblStartInfoEnvVar">Process Start Information Environment Variables</asp:HyperLink><br />
            <asp:HyperLink ID="_lnkVerbs" runat="server" ForeColor="#0000C0" NavigateUrl="#_lblVerbs">Process Start Information Verbs</asp:HyperLink><br />
            <br />
        <br />
        </span><span >
        <strong><span style="color: #4a3c8c;">
            <asp:Label ID="_lblException" runat="server" Text="Exception Details"></asp:Label><br />
            <span ></span>
            <asp:DetailsView ID="_dvException" runat="server" AutoGenerateRows="False" BackColor="White"
                BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal"
                Height="50px" Width="100%">
                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                <Fields>
                    <asp:BoundField DataField="description" HeaderText="Description:" SortExpression="description" />
                    <asp:BoundField DataField="dateTime" HeaderText="Thrown On:" SortExpression="dateTime" />
                    <asp:BoundField DataField="exceptionType" HeaderText="Type:" SortExpression="exceptionType" />
                    <asp:BoundField DataField="exceptionMessage" HeaderText="Message:" SortExpression="exceptionMessage" />
                    <asp:BoundField DataField="source" HeaderText="Source:" SortExpression="source" />
                    <asp:BoundField DataField="helpLink" HeaderText="Help Link:" SortExpression="helpLink" />
                    <asp:BoundField DataField="stackTrace" HeaderText="Stack Trace:" SortExpression="stackTrace" />
                </Fields>
                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                <AlternatingRowStyle BackColor="#F7F7F7" />
            </asp:DetailsView>
            &nbsp;&nbsp;<br />
            <asp:Label ID="_lblExceptionData" runat="server" Text="Exception Data"></asp:Label><br />
            <asp:GridView ID="_gvExceptionData" runat="server" AutoGenerateColumns="False"
                BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px"
                CellPadding="3" Font-Names="@Arial Unicode MS" GridLines="Horizontal" Width="100%">
                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                <Columns>
                    <asp:BoundField DataField="dataKey" HeaderText="Key" SortExpression="dataKey" />
                    <asp:BoundField DataField="dataValue" HeaderText="Value" SortExpression="dataValue" />
                </Columns>
                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                <AlternatingRowStyle BackColor="#F7F7F7" />
            </asp:GridView>
            <br />
                <asp:Label ID="_lblExceptionProperties" runat="server" Text="Exception Properties"></asp:Label><asp:GridView ID="_gvExceptionProperties" runat="server" AutoGenerateColumns="False"
                    BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px"
                    CellPadding="3" GridLines="Horizontal" Width="100%">
                    <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                    <Columns>
                        <asp:BoundField DataField="propertyName" HeaderText="Name" SortExpression="propertyName" />
                        <asp:BoundField DataField="propertyValue" HeaderText="Value" SortExpression="propertyValue" />
                    </Columns>
                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <AlternatingRowStyle BackColor="#F7F7F7" />
                </asp:GridView>
            <br />
                <asp:Label ID="_lblExceptionFields" runat="server" Text="Exception Fields"></asp:Label><asp:GridView ID="_gvExceptionFields" runat="server" AutoGenerateColumns="False"
                    BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px"
                    CellPadding="3" GridLines="Horizontal" Width="100%">
                    <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                    <Columns>
                        <asp:BoundField DataField="fieldName" HeaderText="Name" SortExpression="fieldName" />
                        <asp:BoundField DataField="fieldValue" HeaderText="Value" SortExpression="fieldValue" />
                    </Columns>
                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <AlternatingRowStyle BackColor="#F7F7F7" />
                </asp:GridView>
            <br />
            <asp:Label ID="_lblInner" runat="server" Text="Inner Exception Information"></asp:Label><br />
        </span></strong></span>
        <asp:GridView ID="_gvInnerExceptions" runat="server" BackColor="White" BorderColor="#E7E7FF"
            BorderStyle="None" BorderWidth="1px" CellPadding="3" GridLines="Horizontal" Width="100%" AutoGenerateColumns="False" Font-Names="@Arial Unicode MS" >
            <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
            <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
            <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
            <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
            <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
            <AlternatingRowStyle BackColor="#F7F7F7" />
            <Columns>
                <asp:BoundField DataField="dateTime" HeaderText="Thrown on:" SortExpression="dateTime" />
                <asp:BoundField DataField="description" HeaderText="Description:" SortExpression="description" />
                <asp:BoundField DataField="exceptionMessage" HeaderText="Message:" SortExpression="exceptionMessage" />
                <asp:BoundField DataField="exceptionType" HeaderText="Type:" SortExpression="exceptionType" />
                <asp:BoundField DataField="source" HeaderText="Source:" SortExpression="source" />
                <asp:BoundField DataField="helpLink" HeaderText="HelpLink:" SortExpression="helpLink" />
                <asp:BoundField DataField="stackTrace" HeaderText="StackTrace:" SortExpression="stackTrace" />
            </Columns>
        </asp:GridView>
        &nbsp;<span >&nbsp;<br />
        </span>
        <strong><span style="color: #4a3c8c;"> <span >
                <asp:Label ID="_lblTgtSite" runat="server" Text="Target Site Information"></asp:Label><br />
            </span>
            <asp:DetailsView ID="_dtlTargetSite" runat="server" AutoGenerateRows="False" BackColor="White"
                BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3"
                GridLines="Horizontal" Height="50px" Width="100%" Font-Names="@Arial Unicode MS">
                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                <Fields>
                    <asp:BoundField DataField="name" HeaderText="Name:" SortExpression="stackTrace" />
                    <asp:BoundField DataField="declaringModule" HeaderText="Declaring Module:" SortExpression="declaringModule" />
                    <asp:BoundField DataField="declaringType" HeaderText="Declaring Type:" SortExpression="declaringType" />
                    <asp:BoundField DataField="memberType" HeaderText="Member Type:" SortExpression="memberType" />
                    <asp:BoundField DataField="callingConvention" HeaderText="Calling Convention:" SortExpression="callingConvention" />
                    <asp:BoundField DataField="token" HeaderText="Token:" SortExpression="token" />
                </Fields>
                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                <AlternatingRowStyle BackColor="#F7F7F7" />
            </asp:DetailsView>
            <span >
            <br />
                <asp:Label ID="_lblGenArg" runat="server" Text="Target Site Generic Arguments"></asp:Label><br />
            </span>
            <asp:DataList ID="_dlGenericArguments" runat="server" BackColor="White" BorderColor="#E7E7FF"
                BorderStyle="None" BorderWidth="1px" CellPadding="3" 
                GridLines="Horizontal" Width="100%" Font-Names="@Arial Unicode MS">
                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                <SelectedItemStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                <ItemTemplate>
                    type:
                    <asp:Label ID="typeLabel" runat="server" Text='<%# Eval("type") %>'></asp:Label><br />
                    <br />
                </ItemTemplate>
                <AlternatingItemStyle BackColor="#F7F7F7" />
                <ItemStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
            </asp:DataList><span >&nbsp;<br />
                <asp:Label ID="_lblAdditionalInfo" runat="server" Text="Additional Exception Information"></asp:Label></span><asp:GridView ID="_gvAdditionalInfo" runat="server"
                    AutoGenerateColumns="False" BackColor="White" BorderColor="#E7E7FF" BorderStyle="None"
                    BorderWidth="1px" CellPadding="3" Font-Names="@Arial Unicode MS" GridLines="Horizontal"
                    Width="100%">
                    <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                    <Columns>
                        <asp:BoundField DataField="name" HeaderText="Name" SortExpression="name" />
                        <asp:BoundField DataField="value" HeaderText="Value" SortExpression="value" />
                    </Columns>
                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                    <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <AlternatingRowStyle BackColor="#F7F7F7" />
                </asp:GridView>
            <span >
            <br />
                <asp:Label ID="_lblDiagInfo" runat="server" Text="Diagnostic Information"></asp:Label><br />
            </span>
            <asp:DetailsView ID="_dvDiagnosticInfo" runat="server" AutoGenerateRows="False" BackColor="White"
                BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3"
                GridLines="Horizontal" Height="50px" Width="100%" Font-Names="@Arial Unicode MS">
                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                <Fields>
                    <asp:BoundField DataField="clrVersion" HeaderText="CLR Version:" SortExpression="clrVersion" />
                    <asp:BoundField DataField="executingAssemblyName" HeaderText="Executing Assembly Name:"
                        SortExpression="executingAssemblyName" />
                    <asp:BoundField DataField="versionFileName" HeaderText="Version Info - File Name:" SortExpression="versionFileName" />
                    <asp:BoundField DataField="versionFileDescription" HeaderText="Version Info - File Description:"
                        SortExpression="versionFileDescription" />
                    <asp:BoundField DataField="versionFileVersion" HeaderText="Version Info - File Version:" SortExpression="versionFileVersion" />
                    <asp:BoundField DataField="versionProductName" HeaderText="Version Info -  Product Name:" SortExpression="versionProductName" />
                    <asp:BoundField DataField="versionProductVersion" HeaderText="Version Info - Product Version:"
                        SortExpression="versionProductVersion" />
                    <asp:BoundField DataField="versionCompanyName" HeaderText="Version Info - Company Name:" SortExpression="versionCompanyName" />
                    <asp:BoundField DataField="versionComments" HeaderText="Version Info - Comments:" SortExpression="versionComments" />
                    <asp:BoundField DataField="versionInternalName" HeaderText="Version Info - InternalName:"
                        SortExpression="versionInternalName" />
                    <asp:BoundField DataField="versionLanguage" HeaderText="Version Info - Language:" SortExpression="versionLanguage" />
                    <asp:BoundField DataField="versionLegalCopyright" HeaderText="Version Info - Legal Copyright:"
                        SortExpression="versionLegalCopyright" />
                    <asp:BoundField DataField="versionLegalTrademarks" HeaderText="Version Info - Legal Trademarks:"
                        SortExpression="versionLegalTrademarks" />
                    <asp:CheckBoxField DataField="versionIsDebug" HeaderText="Version Info - IsDebug:" SortExpression="versionIsDebug" ReadOnly="True" />
                    <asp:CheckBoxField DataField="versionIsPatched" HeaderText="Version Info - IsPatched:" SortExpression="versionIsPatched" ReadOnly="True" />
                </Fields>
                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                <AlternatingRowStyle BackColor="#F7F7F7" />
            </asp:DetailsView>
            &nbsp;<span ><br />
                <asp:Label ID="_lblHostEnv" runat="server" Text="Host Characteristics"></asp:Label>
                <asp:DetailsView ID="_dvHostEnv" runat="server" AutoGenerateRows="False"
                    BackColor="White" BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px"
                    CellPadding="3" GridLines="Horizontal" Height="50px" Width="100%" AllowPaging="True">
                    <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                    <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                    <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                    <Fields>
                        <asp:BoundField DataField="osVersion" HeaderText="Operating System Version:" SortExpression="osVersion" />
                        <asp:BoundField DataField="processorCount" HeaderText="Processor Count:" SortExpression="processorCount" />
                        <asp:BoundField DataField="currentDirectory" HeaderText="Current Directory:" SortExpression="currentDirectory" />
                    </Fields>
                    <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                    <AlternatingRowStyle BackColor="#F7F7F7" />
                </asp:DetailsView>
            <br />
                <asp:Label ID="_lblProcessInfo" runat="server" Text="Process Information"></asp:Label><br />
            </span>
            <asp:DetailsView ID="_dvProcessInfo" runat="server" AutoGenerateRows="False" BackColor="White"
                BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3"
                GridLines="Horizontal" Height="50px" Width="100%" Font-Names="@Arial Unicode MS">
                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                <Fields>
                    <asp:BoundField DataField="startTime" HeaderText="Start Time:" SortExpression="startTime" />
                    <asp:BoundField DataField="processId" HeaderText="Process Id:" SortExpression="processId" />
                    <asp:BoundField DataField="terminalServicesSessionId" HeaderText="Terminal Services Session Id:"
                        SortExpression="terminalServicesSessionId" />
                    <asp:BoundField DataField="nonPagedSystemMemorySize" HeaderText="NonPaged System Memory Size:"
                        SortExpression="nonPagedSystemMemorySize" />
                    <asp:BoundField DataField="pagedMemorySize" HeaderText="Paged Memory Size:" SortExpression="pagedMemorySize" />
                    <asp:BoundField DataField="pagedSystemMemory" HeaderText="Paged System Memory:" SortExpression="pagedSystemMemory" />
                    <asp:BoundField DataField="peakPagedMemorySize" HeaderText="Peak Paged Memory Size:"
                        SortExpression="peakPagedMemorySize" />
                    <asp:BoundField DataField="peakVirtualMemorySize" HeaderText="Peak Virtual Memory Size:"
                        SortExpression="peakVirtualMemorySize" />
                    <asp:BoundField DataField="peakWorkingSet" HeaderText="Peak Working Set:" SortExpression="peakWorkingSet" />
                    <asp:BoundField DataField="privateMemorySize" HeaderText="Private Memory Size:" SortExpression="privateMemorySize" />
                    <asp:BoundField DataField="virtualMemorySize" HeaderText="Virtual Memory Size:" SortExpression="virtualMemorySize" />
                    <asp:BoundField DataField="workingSet" HeaderText="Working Set:" SortExpression="workingSet" />
                    <asp:TemplateField HeaderText="Total Processor Time:">
                      <ItemTemplate>
                        <%# GenerateTimeSpanString(Container.DataItem,0)%>
                      </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="User Processor Time:">
                      <ItemTemplate>
                        <%# GenerateTimeSpanString(Container.DataItem,1)%>
                      </ItemTemplate>
                    </asp:TemplateField>
                </Fields>
                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                <AlternatingRowStyle BackColor="#F7F7F7" />
            </asp:DetailsView>
            <span >
            <br />
                <asp:Label ID="_lblProcEnvVar" runat="server" Text="Process Environment Variables"></asp:Label><br />
            </span>
            <asp:GridView ID="_gvProcessEnvVar" runat="server" AutoGenerateColumns="False" BackColor="White"
                BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3" 
                GridLines="Horizontal" Font-Names="@Arial Unicode MS" Width="100%">
                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                <Columns>
                    <asp:BoundField DataField="variableName" HeaderText="Name" SortExpression="variableName" />
                    <asp:BoundField DataField="variableValue" HeaderText="Value" SortExpression="variableValue" />
                </Columns>
                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                <AlternatingRowStyle BackColor="#F7F7F7" />
            </asp:GridView>
            <span >
            <br />
                <asp:Label ID="_lblStartInfo" runat="server" Text="Process Start Information"></asp:Label><br />
            </span>
            <asp:DetailsView ID="_dvStartInfo" runat="server" AutoGenerateRows="False" BackColor="White"
                BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3"
                GridLines="Horizontal" Height="50px" Width="100%" Font-Names="@Arial Unicode MS">
                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                <EditRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                <Fields>
                    <asp:BoundField DataField="fileName" HeaderText="File Name:" SortExpression="fileName" />
                    <asp:BoundField DataField="arguments" HeaderText="Arguments:" SortExpression="arguments" />
                    <asp:BoundField DataField="domain" HeaderText="Domain:" SortExpression="domain" />
                    <asp:BoundField DataField="verb" HeaderText="Verb:" SortExpression="verb" />
                    <asp:CheckBoxField DataField="useShellExecute" HeaderText="Use Shell Execute:" SortExpression="useShellExecute" />
                    <asp:BoundField DataField="workingDirectory" HeaderText="Working Directory:" SortExpression="workingDirectory" />
                </Fields>
                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                <AlternatingRowStyle BackColor="#F7F7F7" />
            </asp:DetailsView>
            <span >
            <br />
                <asp:Label ID="_lblStartInfoEnvVar" runat="server" Text="Process Start Information Environment Variables"></asp:Label><br />
            </span>
            <asp:GridView ID="_gvStartInfoEnvVar" runat="server" AutoGenerateColumns="False" BackColor="White"
                BorderColor="#E7E7FF" BorderStyle="None" BorderWidth="1px" CellPadding="3"
                GridLines="Horizontal" Font-Names="@Arial Unicode MS" Width="100%">
                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                <Columns>
                    <asp:BoundField DataField="variableName" HeaderText="Name" SortExpression="variableName" />
                    <asp:BoundField DataField="variableValue" HeaderText="Value" SortExpression="variableValue" />
                </Columns>
                <RowStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                <SelectedRowStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                <PagerStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" HorizontalAlign="Right" />
                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
                <AlternatingRowStyle BackColor="#F7F7F7" />
            </asp:GridView>
            <span >
            <br />
                <asp:Label ID="_lblVerbs" runat="server" Text="Process Start Information Verbs"></asp:Label><br />
            </span>
            <asp:DataList ID="_dlVerbs" runat="server" BackColor="White" BorderColor="#E7E7FF"
                BorderStyle="None" BorderWidth="1px" CellPadding="3"
                GridLines="Horizontal" Font-Names="@Arial Unicode MS" Width="100%">
                <FooterStyle BackColor="#B5C7DE" ForeColor="#4A3C8C" />
                <SelectedItemStyle BackColor="#738A9C" Font-Bold="True" ForeColor="#F7F7F7" />
                <ItemTemplate>
                    verb:
                    <asp:Label ID="verbLabel" runat="server" Text='<%# Eval("verb") %>'></asp:Label><br />
                    <br />
                </ItemTemplate>
                <AlternatingItemStyle BackColor="#F7F7F7" />
                <ItemStyle BackColor="#E7E7FF" ForeColor="#4A3C8C" />
                <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="#F7F7F7" />
            </asp:DataList><span >&nbsp;<br />
                <br />
            <br />
                <br />
            </span>
        </span></strong></div>
    </form>
</body>
</html>

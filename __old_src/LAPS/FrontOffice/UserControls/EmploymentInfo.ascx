<%@ Control Language="C#" AutoEventWireup="true" CodeFile="EmploymentInfo.ascx.cs" Inherits="LAPS.FrontOffice.UserControls_EmploymentInfo" %>

<%@ Register TagPrefix="radCln" Namespace="Telerik.WebControls" Assembly="RadCalendar.NET2" %>
<%@ Register Assembly="Microsoft.Practices.EnterpriseLibrary.Validation.Integration.AspNet"
    Namespace="Microsoft.Practices.EnterpriseLibrary.Validation.Integration.AspNet"
    TagPrefix="cc1" %>
    
<table cellpadding=0 cellspacing=0 border=0 width=100% style="padding-top:4px;">
<tr align=left valign=middle>
    <td><span class="control_label">Source of Income</span></td>
    <td>
    <asp:ListBox Rows=1 runat=server  ID=optSrcOfIncome>
        <asp:ListItem Text="Employment" Value="Employment"></asp:ListItem>
        <asp:ListItem Text="Disability Benefits" Value="Disability Benefits"></asp:ListItem>
        <asp:ListItem Text="Pension" Value="Pension"></asp:ListItem>
        <asp:ListItem Text="Self Employment" Value="Self Employment"></asp:ListItem>
    </asp:ListBox>
    </td>
</tr>
<tr align=left valign=middle>
    <td><span class="control_label">Pay Per Cheque</span></td>
    <td>
    <asp:TextBox runat="server" ID=tbPayPerCheque Columns=10></asp:TextBox>
    <cc1:propertyproxyvalidator id="Propertyproxyvalidator8" runat="server" ControlToValidate="tbPayPerCheque" PropertyName="PayPerCheque" RulesetName="Rule Set" SourceTypeName="LAPS.DataLayer.DataSets.Users+EmploymentInfoRow" Font-Size=Small SpecificationSource=Configuration></cc1:propertyproxyvalidator>
    </td>
</tr>
<tr align=left valign=middle>
    <td><span class="control_label">Is your Income Paid by Direct Deposit</span></td>
    <td>    
    <span class="control_text">
        <asp:RadioButton id=optPayDDYes Text="Yes" Checked="True" GroupName="optPayDD" runat="server" />        
        <asp:RadioButton id=optPayDDNo Text="No" Checked="False" GroupName="optPayDD" runat="server" />
    </span>
    </td>
</tr>
<tr align=left valign=middle>
    <td><span class="control_label">Frequency of Wage</span></td>
    <td>
    <asp:ListBox Rows=1 runat=server  ID=tbFreqWage>
        <asp:ListItem Text="Weekly" Value="Weekly"></asp:ListItem>
        <asp:ListItem Text="Bi-Weekly" Value="Bi-Weekly"></asp:ListItem>
        <asp:ListItem Text="Four-Weekly" Value="Four-Weekly"></asp:ListItem>
        <asp:ListItem Text="Monthly" Value="Monthly"></asp:ListItem>
        <asp:ListItem Text="Twice Monthly" Value="Twice Monthly"></asp:ListItem>
    </asp:ListBox>
    </td>
</tr>
<tr align=left valign=middle>
    <td><span class="control_label">Type of Employment</span></td>
    <td>
    <asp:ListBox Rows=1 runat=server  ID=optEmpType>
        <asp:ListItem Text="Full-Time" Value="Full-Time"></asp:ListItem>
        <asp:ListItem Text="Part-Time" Value="Part-Time"></asp:ListItem>
        <asp:ListItem Text="Temporary Employment" Value="Temporary Employment"></asp:ListItem>
    </asp:ListBox>
    </td>
</tr>
<tr align=left valign=middle>
    <td><span class="control_label">Next Pay Date</span></td>
    <td>        
        <radcln:RadDatePicker id="clnNextPayDate" Runat="server" Width=100>
        </radcln:RadDatePicker>
    </td>
</tr>
<tr align=left valign=middle>
    <td><span class="control_label">Following Pay Date</span></td>
    <td>        
        <radcln:RadDatePicker id="clnFollowingPayDate" Runat="server" Width=100>
        </radcln:RadDatePicker>
    </td>
</tr>
<tr align=left valign=middle>
    <td><span class="control_label">Company Name</span></td><td>
        <asp:TextBox runat="server" ID=tbCoName Columns=40></asp:TextBox>
        <cc1:propertyproxyvalidator id="Propertyproxyvalidator1" runat="server" ControlToValidate="tbCoName" PropertyName="CompanyName" RulesetName="Rule Set" SourceTypeName="LAPS.DataLayer.DataSets.Users+EmploymentInfoRow" Font-Size=Small SpecificationSource=Configuration></cc1:propertyproxyvalidator>
    </td>
</tr>
<tr align=left valign=middle>
    <td><span class="control_label">Department</span></td><td>
        <asp:TextBox runat="server" ID=tbDepartment Columns=40></asp:TextBox>
        <cc1:propertyproxyvalidator id="Propertyproxyvalidator2" runat="server" ControlToValidate="tbDepartment" PropertyName="Department" RulesetName="Rule Set" SourceTypeName="LAPS.DataLayer.DataSets.Users+EmploymentInfoRow" Font-Size=Small SpecificationSource=Configuration></cc1:propertyproxyvalidator>
    </td>
</tr>
<tr align=left valign=middle>
    <td><span class="control_label">Post Held</span></td><td><asp:TextBox runat="server" ID=tbPostHeld Columns=40></asp:TextBox>
    <cc1:propertyproxyvalidator id="Propertyproxyvalidator3" runat="server" ControlToValidate="tbPostHeld" PropertyName="PostHeld" RulesetName="Rule Set" SourceTypeName="LAPS.DataLayer.DataSets.Users+EmploymentInfoRow" Font-Size=Small SpecificationSource=Configuration></cc1:propertyproxyvalidator></td>
    
</tr>
<tr align=left valign=middle>
    <td><span class="control_label">Supervisor/manager’s Name</span></td><td><asp:TextBox runat="server" ID=tbMgrName Columns=30></asp:TextBox>
    <cc1:propertyproxyvalidator id="Propertyproxyvalidator4" runat="server" ControlToValidate="tbMgrName" PropertyName="SupervisorName" RulesetName="Rule Set" SourceTypeName="LAPS.DataLayer.DataSets.Users+EmploymentInfoRow" Font-Size=Small SpecificationSource=Configuration></cc1:propertyproxyvalidator></td>
</tr>
<tr align=left valign=middle>
    <td><span class="control_label">Length of Employment at current company</span></td>
    <td>    
        <asp:TextBox runat="server" ID=tbEmpDurationYears Columns=3 Text=0></asp:TextBox><span class="control_text">Years</span>&nbsp;&nbsp;
        <asp:TextBox runat="server" ID=tbEmpDurationMonths Columns=3 Text=0></asp:TextBox><span class="control_text">Months</span>
        
    </td>
</tr>
<tr align=left valign=middle>
    <td><span class="control_label">Company Main No.</span></td><td><asp:TextBox runat="server" ID=tbCoPhoneNo Columns=20></asp:TextBox></td>
</tr>
</table>

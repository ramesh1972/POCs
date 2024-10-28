<%@ Control Language="C#" AutoEventWireup="true" CodeFile="PersonalInfo.ascx.cs" Inherits="LAPS.FrontOffice.PersonalInfo" %>

<%@ Register TagPrefix="radCln" Namespace="Telerik.WebControls" Assembly="RadCalendar.NET2" %>
<%@ Register Assembly="Microsoft.Practices.EnterpriseLibrary.Validation.Integration.AspNet"
    Namespace="Microsoft.Practices.EnterpriseLibrary.Validation.Integration.AspNet"
    TagPrefix="cc1" %>

<table cellpadding=0 cellspacing=0 border=0 width=100% style="padding-top:4px;">
<tr align=left valign=middle>
    <td><span class="control_label">Title</span></td>
    <td>
    <asp:ListBox Rows=1 runat=server  ID=optTitle>
        <asp:ListItem Text="Mr." Value="Mr." Selected=True></asp:ListItem>
        <asp:ListItem Text="Miss." Value="Miss."></asp:ListItem>
        <asp:ListItem Text="Mrs." Value="Mrs."></asp:ListItem>
    </asp:ListBox>
    </td>
    <td><span class="control_label">Time To Call</span></td>
    <td>
    <span class="control_label">From</span>
    <asp:ListBox Rows=1 runat=server  ID=optTimeToCallFrom>
        <asp:ListItem Text="Select" Value=""></asp:ListItem>
        <asp:ListItem Text="Select" Value=""></asp:ListItem>
        <asp:ListItem Text="00:00" Value="00:00"></asp:ListItem>
        <asp:ListItem Text="01:00" Value="01:00"></asp:ListItem>
        <asp:ListItem Text="02:00" Value="02:00"></asp:ListItem>
        <asp:ListItem Text="03:00" Value="03:00"></asp:ListItem>
        <asp:ListItem Text="04:00" Value="04:00"></asp:ListItem>
        <asp:ListItem Text="05:00" Value="05:00"></asp:ListItem>
        <asp:ListItem Text="06:00" Value="06:00"></asp:ListItem>
        <asp:ListItem Text="07:00" Value="07:00"></asp:ListItem>
        <asp:ListItem Text="08:00" Value="08:00"></asp:ListItem>
        <asp:ListItem Text="09:00" Value="09:00"></asp:ListItem>
        <asp:ListItem Text="10:00" Value="10:00"></asp:ListItem>
        <asp:ListItem Text="11:00" Value="11:00"></asp:ListItem>
        <asp:ListItem Text="12:00" Value="12:00"></asp:ListItem>
        <asp:ListItem Text="13:00" Value="13:00"></asp:ListItem>
        <asp:ListItem Text="14:00" Value="14:00"></asp:ListItem>
        <asp:ListItem Text="15:00" Value="15:00"></asp:ListItem>
        <asp:ListItem Text="16:00" Value="16:00"></asp:ListItem>
        <asp:ListItem Text="17:00" Value="17:00"></asp:ListItem>
        <asp:ListItem Text="18:00" Value="18:00"></asp:ListItem>
        <asp:ListItem Text="19:00" Value="19:00"></asp:ListItem>
        <asp:ListItem Text="20:00" Value="20:00"></asp:ListItem>
        <asp:ListItem Text="21:00" Value="21:00"></asp:ListItem>
        <asp:ListItem Text="22:00" Value="22:00"></asp:ListItem>
        <asp:ListItem Text="23:00" Value="23:00"></asp:ListItem>
        <asp:ListItem Text="24:00" Value="24:00"></asp:ListItem>        
    </asp:ListBox>&nbsp;&nbsp;
    <span class="control_label">To</span>
    <asp:ListBox Rows=1 runat=server  ID=optTimeToCallTo>
        <asp:ListItem Text="Select" Value=""></asp:ListItem>
        <asp:ListItem Text="00:00" Value="00:00"></asp:ListItem>
        <asp:ListItem Text="01:00" Value="01:00"></asp:ListItem>
        <asp:ListItem Text="02:00" Value="02:00"></asp:ListItem>
        <asp:ListItem Text="03:00" Value="03:00"></asp:ListItem>
        <asp:ListItem Text="04:00" Value="04:00"></asp:ListItem>
        <asp:ListItem Text="05:00" Value="05:00"></asp:ListItem>
        <asp:ListItem Text="06:00" Value="06:00"></asp:ListItem>
        <asp:ListItem Text="07:00" Value="07:00"></asp:ListItem>
        <asp:ListItem Text="08:00" Value="08:00"></asp:ListItem>
        <asp:ListItem Text="09:00" Value="09:00"></asp:ListItem>
        <asp:ListItem Text="10:00" Value="10:00"></asp:ListItem>
        <asp:ListItem Text="11:00" Value="11:00"></asp:ListItem>
        <asp:ListItem Text="12:00" Value="12:00"></asp:ListItem>
        <asp:ListItem Text="13:00" Value="13:00"></asp:ListItem>
        <asp:ListItem Text="14:00" Value="14:00"></asp:ListItem>
        <asp:ListItem Text="15:00" Value="15:00"></asp:ListItem>
        <asp:ListItem Text="16:00" Value="16:00"></asp:ListItem>
        <asp:ListItem Text="17:00" Value="17:00"></asp:ListItem>
        <asp:ListItem Text="18:00" Value="18:00"></asp:ListItem>
        <asp:ListItem Text="19:00" Value="19:00"></asp:ListItem>
        <asp:ListItem Text="20:00" Value="20:00"></asp:ListItem>
        <asp:ListItem Text="21:00" Value="21:00"></asp:ListItem>
        <asp:ListItem Text="22:00" Value="22:00"></asp:ListItem>
        <asp:ListItem Text="23:00" Value="23:00"></asp:ListItem>
        <asp:ListItem Text="24:00" Value="24:00"></asp:ListItem>
    </asp:ListBox>
    </td>
</tr>
<tr align=left valign=middle>
    <td>
        <span class="control_label">First Name</span></td><td><asp:TextBox runat="server" ID=tbFirstName Columns=20></asp:TextBox>
        <cc1:propertyproxyvalidator id="Propertyproxyvalidator8" runat="server" ControlToValidate="tbFirstName" PropertyName="FirstName" RulesetName="Rule Set" SourceTypeName="LAPS.DataLayer.DataSets.Users+UsersRow" Font-Size=Small SpecificationSource=Configuration></cc1:propertyproxyvalidator>    
    </td>
    <td>
        <span class="control_label">Building Name</span></td><td><asp:TextBox runat="server" ID=tbBldName Columns=30></asp:TextBox>
        <cc1:propertyproxyvalidator id="Propertyproxyvalidator4" runat="server" ControlToValidate="tbBldName" PropertyName="BuildingName" RulesetName="Rule Set" SourceTypeName="LAPS.DataLayer.DataSets.Users+AddressesRow" Font-Size=Small SpecificationSource=Configuration></cc1:propertyproxyvalidator>    
    </td>
</tr>
<tr align=left valign=middle>
    <td><span class="control_label">Middle Name</span></td><td><asp:TextBox runat="server" ID=tbMidName Columns=20></asp:TextBox></td>
    <td>
        <span class="control_label">Building No.</span></td><td><asp:TextBox runat="server" ID=tbBldNo Columns=10></asp:TextBox>
        <cc1:propertyproxyvalidator id="Propertyproxyvalidator5" runat="server" ControlToValidate="tbBldNo" PropertyName="BuildingNo" RulesetName="Rule Set" SourceTypeName="LAPS.DataLayer.DataSets.Users+AddressesRow" Font-Size=Small SpecificationSource=Configuration></cc1:propertyproxyvalidator>    
    </td>
</tr>
<tr align=left valign=middle>
    <td>
        <span class="control_label">Last Name</span></td><td><asp:TextBox runat="server" ID=tbLastName Columns=20></asp:TextBox>
        <cc1:propertyproxyvalidator id="Propertyproxyvalidator1" runat="server" ControlToValidate="tbLastName" PropertyName="LastName" RulesetName="Rule Set" SourceTypeName="LAPS.DataLayer.DataSets.Users+UsersRow" Font-Size=Small SpecificationSource=Configuration></cc1:propertyproxyvalidator>    
    </td>
    <td>
        <span class="control_label">Flat No.</span></td><td><asp:TextBox runat="server" ID=tbFlatNo Columns=10></asp:TextBox>
        <cc1:propertyproxyvalidator id="Propertyproxyvalidator2" runat="server" ControlToValidate="tbFlatNo" PropertyName="FlatNo" RulesetName="Rule Set" SourceTypeName="LAPS.DataLayer.DataSets.Users+AddressesRow" Font-Size=Small SpecificationSource=Configuration></cc1:propertyproxyvalidator>    
    </td>
</tr>
<tr align=left valign=middle>
    <td><span class="control_label">Data Of Birth</span></td>
    <td>
        <radcln:RadDatePicker ID="clnDOB" Runat="server" MinDate="1900/1/1">
        </radcln:RadDatePicker>
    </td>
    <td>
        <span class="control_label">Street</span></td><td><asp:TextBox runat="server" ID=tbStreet Columns=30></asp:TextBox>
        <cc1:propertyproxyvalidator id="Propertyproxyvalidator3" runat="server" ControlToValidate="tbStreet" PropertyName="Street" RulesetName="Rule Set" SourceTypeName="LAPS.DataLayer.DataSets.Users+AddressesRow" Font-Size=Small SpecificationSource=Configuration></cc1:propertyproxyvalidator>    
    </td>
</tr>
<tr align=left valign=middle>
    <td>
        <span class="control_label">Home Phone No.</span></td><td><asp:TextBox runat="server" ID=tbPhoneNo Columns=20></asp:TextBox>
        <cc1:propertyproxyvalidator id="Propertyproxyvalidator6" runat="server" ControlToValidate="tbPhoneNo" PropertyName="TelephoneNo" RulesetName="Rule Set" SourceTypeName="LAPS.DataLayer.DataSets.Users+UsersRow" Font-Size=Small SpecificationSource=Configuration></cc1:propertyproxyvalidator>    
   </td>
    <td>
        <span class="control_label">Postal Town/City</span></td><td><asp:TextBox runat="server" ID=tbTown Columns=20></asp:TextBox>
        <cc1:propertyproxyvalidator id="Propertyproxyvalidator7" runat="server" ControlToValidate="tbTown" PropertyName="PostalTown" RulesetName="Rule Set" SourceTypeName="LAPS.DataLayer.DataSets.Users+AddressesRow" Font-Size=Small SpecificationSource=Configuration></cc1:propertyproxyvalidator>
    </td>
        
</tr>
<tr align=left valign=middle>
    <td><span class="control_label">Modile No.</span></td><td><asp:TextBox runat="server" ID=tbMobileNo Columns=20></asp:TextBox></td>
    <td>
        <span class="control_label">Postal Code</span></td><td><asp:TextBox runat="server" ID=tbPostalCode Columns=10></asp:TextBox>
        <cc1:propertyproxyvalidator id="Propertyproxyvalidator9" runat="server" ControlToValidate="tbPostalCode" PropertyName="PostalCode" RulesetName="Rule Set" SourceTypeName="LAPS.DataLayer.DataSets.Users+AddressesRow" Font-Size=Small SpecificationSource=Configuration></cc1:propertyproxyvalidator>        
    </td>
</tr>
<tr align=left valign=middle>
    <td><span class="control_label">Fax No. (Optional)</span></td><td><asp:TextBox runat="server" ID=tbFaxNo Columns=20></asp:TextBox></td>
    <td>
        <span class="control_label">County</span></td><td><asp:TextBox runat="server" ID=tbCounty Columns=20></asp:TextBox>
        <cc1:propertyproxyvalidator id="Propertyproxyvalidator10" runat="server" ControlToValidate="tbCounty" PropertyName="County" RulesetName="Rule Set" SourceTypeName="LAPS.DataLayer.DataSets.Users+AddressesRow" Font-Size=Small SpecificationSource=Configuration></cc1:propertyproxyvalidator>
    </td>
</tr>
</table>
<hr />
<table cellpadding=0 cellspacing=0 border=0 width=100%>
<tr align=left valign=middle>
    <td>
    <span class="control_label">Do you Own or Rent your Appartment?</span>
    <span class="control_text">
        <asp:RadioButton id=optrOwn Text="Own" Checked="False" GroupName="optRent" runat="server" />        
        <asp:RadioButton id=optrRent Text="Rent" Checked="True" GroupName="optRent" runat="server" />
    </span>
    </td>
</tr>
<tr align=left valign=middle>
    <td valign=middle>
    <span class="control_label">How long have you lived in your current Residence?</span>
    <asp:TextBox runat="server" ID=tbResDurationYears Columns=3 Text=0></asp:TextBox><span class="control_text">Years</span>&nbsp;&nbsp;
    <asp:TextBox runat="server" ID=tbResDurationMonths Columns=3 Text=0></asp:TextBox><span class="control_text">Months</span>
    <cc1:propertyproxyvalidator id="Propertyproxyvalidator11" runat="server" ControlToValidate="tbResDurationYears" PropertyName="DurationYears" RulesetName="Rule Set" SourceTypeName="LAPS.DataLayer.DataSets.Users+AddressesRow" Font-Size=Small SpecificationSource=Configuration></cc1:propertyproxyvalidator>
    <cc1:propertyproxyvalidator id="Propertyproxyvalidator12" runat="server" ControlToValidate="tbResDurationMonths" PropertyName="DurationMonths" RulesetName="Rule Set" SourceTypeName="LAPS.DataLayer.DataSets.Users+AddressesRow" Font-Size=Small SpecificationSource=Configuration></cc1:propertyproxyvalidator>
    </td>
</tr>
</table>
<hr />
<table cellpadding=0 cellspacing=0 border=0 width=100%>
<tr align=left valign=middle>
    <td><span class="control_label">Driving License No. (Optional)</span></td><td><asp:TextBox runat="server" ID=tbDrvLic Columns=20></asp:TextBox></td>
</tr>
<tr align=left valign=middle>    
    <td><span class="control_label">National Insurance No. (NIN, Optional)</span></td><td><asp:TextBox runat="server" ID=tbNIN Columns=20></asp:TextBox></td>
</tr>
</table>

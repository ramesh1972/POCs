<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SamplePages.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    Pages
    <form id="form1" runat="server">
    <div>
    <a id=A1 href="BootStrap.aspx?BootPage=xmls/simple.xml">Simple</a><br /><a id=A2 href="BootStrap.aspx?BootPage=xmls/simpleReturn.xml">Simple Return</a>
    <br />
    <a id=start href="BootStrap.aspx?BootPage=xmls/sections.xml">Home</a><br /><a id=A3 href="BootStrap.aspx?BootPage=xmls/homereturn.xml">Home Return</a>
    </div>
    <br />
    Controls
    <div>
    <a id=A4 href="BootStrap.aspx?BootPage=controls/dropdownlist.xml">DoropDownList</a>
    </div>
    </form>
</body>
</html>

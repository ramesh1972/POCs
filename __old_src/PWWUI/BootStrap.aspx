<%@ Page language="C#" AutoEventWireup="true" CodeFile="BootStrap.aspx.cs" Inherits="aspx_BootStrap" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script type="text/javascript" language="javascript" src="scripts/ii-page.js"></script>

    <script type="text/javascript" language="javascript" src="scripts/ii-wrapper-html.js"></script>
    <script type="text/javascript" language="javascript" src="scripts/ii-wrapper-xml.js"></script>
    <script type="text/javascript" language="javascript" src="scripts/ii-globals.js"></script>
    <script type="text/javascript" language="javascript" src="scripts/ii-utils.js"></script>
    <script type="text/javascript" language="javascript" src="scripts/ii-debug_js.js"></script>

    <script type="text/javascript" language="javascript" src="scripts/ii-section-dimensions.js"></script>
    <script type="text/javascript" language="javascript" src="scripts/ii-section-collection.js"></script>

    <script type="text/javascript" language="javascript" src="scripts/ii-section-popout.js"></script>
    <script type="text/javascript" language="javascript" src="scripts/ii-control-text.js"></script>

    <script type="text/javascript" language="javascript" src="scripts/ii-section-border.js"></script>
    <script type="text/javascript" language="javascript" src="scripts/ii-section-bar.js"></script>
    <script type="text/javascript" language="javascript" src="scripts/ii-section-tab.js"></script>
    <script type="text/javascript" language="javascript" src="scripts/ii-section-paws.js"></script>

    <script type="text/javascript" language="javascript" src="scripts/ii-section-layout.js"></script>
    <script type="text/javascript" language="javascript" src="scripts/ii-section-re-layout.js"></script>
    <script type="text/javascript" language="javascript" src="scripts/ii-section-create.js"></script>
</head>


<body style="position:absolute;left:0px;top:0px;width:100%;height:100%;margin:0px">
     <!-- Form that holds the xml of a page -->
     <form id="_boot_strap" runat="server">
        <input runat="server" type="hidden" id="_page_name" value="test"/>    
        <input runat="server" type="hidden" id="_page_xml" value="test"/>    
     </form>

    <!-- Load the Page -->
    <script type="text/javascript" language="javascript">
        document.body.onclick = page_onclick;
        document.body.onresize = resize_page;
        document.body.onmousemove = body_mousemove;
        create_root_container();
        groot_container.serialize = true;

        var _page = new CXmlPage();
        _page.Boot();

        check_set_and_show_section_tree(groot_container, true);
        gpage_initialization = false;
    </script>

<!-- <script type="text/javascript" language="javascript" src="scripts/ii-start.js"></script> -->
</body>
</html>

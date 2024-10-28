<script language=javascript type="text/javascript">
    function GenerateAdScript() {
        var strScript =     
        "<script type=\"text/javascript\" language=\"javascript\" src=\"scripts/json2.js\"/>\n" + 
        "<script type=\"text/javascript\" language=\"javascript\" src=\"scripts/jquery-1.4.1.min.js\" />\n" + 
        "<script type=\"text/javascript\" language=\"javascript\" src=\"Scripts/adplusplus.js\" />\n" + 
        "<script type=\"text/javascript\" language=\"javascript\">\n" + 
        "var myAd = \n" +
        "{\n" +
            "\t\t\t\tadkeywords: \"" + document.getElementById("adKeyWords").value + "\"" +
            ", addesc:\"" + document.getElementById("adDesc").value + "\"\n" +
        "};\n" +
        "<\/script>";

        document.getElementById("GeneratedScript").innerText = strScript;
        document.getElementById("ScriptDisplayTable").style.visibility = "visible";
    }
</script>

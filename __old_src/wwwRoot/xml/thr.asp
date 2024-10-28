<%@ Language=VBScript %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<XML id=oXML src="books.xml"></XML>
<script>
function fnCheck(){
   var oNode = oXML.XMLDocument.selectSingleNode("books/book/title");
   alert(oNode.text);
}
</SCRIPT>

<BODY>
<INPUT TYPE=button VALUE="Test" onclick="fnCheck()">
<TABLE datasrc="#oXML" border=1 style=border-collapse:collapse>
<TR>
<TD><SPAN datafld="title"></SPAN></TD>
<TD><SPAN datafld="author"></SPAN></TD>
</TR>
</TABLE>
</BODY>
</HTML>

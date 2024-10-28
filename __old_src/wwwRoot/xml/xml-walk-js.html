<%@LANGUAGE=VBScript%>
<html>
<head>
<title>Tree walk test - VBScript</title>
</head><body>
<%
function attribute_walk(node)

  For i=1 to indent
    Response.Write("&nbsp;")
  Next
  For Each attrib In node.attributes
   Response.Write("|--")
   Response.Write(attrib.nodeTypeString)
   Response.Write(":")
   Response.Write(attrib.name)
   Response.Write("--")
   Response.Write(attrib.nodeValue)
   Response.Write("<br />")
  Next
end function


function tree_walk(node)
dim nodeName

indent=indent+2

For Each child In node.childNodes
  For i=1 to indent
    Response.Write("&nbsp;")
  Next
  Response.Write("|--")
  Response.Write(child.nodeTypeString)
  Response.Write("--")
  If child.nodeType<3 Then
    Response.Write(child.nodeName)
    Response.Write("<br />")
  End If
  If (child.nodeType=1) Then 
    If (child.attributes.length>0) Then
      indent=indent+2
      attribute_walk(child)
      indent=indent-2
    End If
  End If
  If (child.hasChildNodes) Then
    tree_walk(child)
  Else
    Response.Write child.text
    Response.Write("<br />")
  End If
Next

  indent=indent-2

end function

xmlFile=Request.Form("fileURI")
Response.write(xmlFile)
Dim root
Dim xmlDoc
Dim child
Dim indent

indent=0

Set xmlDoc = CreateObject("Msxml2.DOMDocument")
xmlDoc.async = False
xmlDoc.validateOnParse=False
xmlDoc.load(xmlFile)
If xmlDoc.parseError.errorcode = 0 Then 
'Walk from the root to each of its child nodes:
  Response.Write("<pre>")
  tree_walk(xmlDoc)
  Response.Write("</pre>")
Else
%>
<h1>XML Parsing - DOM Tree Walk Demo</h1>
<form id="location" method="post" action="">
<input type="text" name="fileURI" maxlength="255" size="20" id="XMLurl" /> 
<br />
<input type="submit" name="submit" value="submit" />
</form>
<% End If%>
</body></html>

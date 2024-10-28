<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<TITLE></TITLE>
<script language="vbscript">
function circley(x,r) 
	circley = (r*r - x*x) ^ (1/2)
end function

function OnMouseOverBody() 
	Dim lIdx1
	Dim x
	
	for lIdx1 = 0 to 24
		x = (lIdx1 - 12)
		y = circley(x, 12)
		
		if (x < 0) Then
			document.all("div" & lIdx1).innerText = "."
			document.all("div" & lIdx1).style.position = "absolute"
			document.all("div" & lIdx1).style.top = 100 + (y*5)
			document.all("div" & lIdx1).style.left = 100 + x*3
			document.all("div" & lIdx1).style.visibility  = "visible"
			
			document.all("div" & (lIdx1+24)).innerText = "."
			document.all("div" & (lIdx1+24)).style.position = "absolute"
			document.all("div" & (lIdx1+24)).style.top = 100 - (y*5)
			document.all("div" & (lIdx1+24)).style.left = 100 + x*3
			document.all("div" & (lIdx1+24)).style.visibility  = "visible"
		else
			document.all("div" & lIdx1).innerText = "."
			document.all("div" & lIdx1).style.position = "absolute"
			document.all("div" & lIdx1).style.top = 100 - y *5
			document.all("div" & lIdx1).style.left = 100 + x*3 
			document.all("div" & lIdx1).style.visibility  = "visible"

			document.all("div" & (lIdx1+24)).innerText = "."
			document.all("div" & (lIdx1+24)).style.position = "absolute"
			document.all("div" & (lIdx1+24)).style.top = 100 + (y*5)
			document.all("div" & (lIdx1+24)).style.left = 100 + x*3
			document.all("div" & (lIdx1+24)).style.visibility  = "visible"
		end if
	next
end function
</script>
</HEAD>
<BODY onmusemove="OnMouseOverBody()">
<% 
	Dim lIdx
	Dim lName
	
	For lIdx = 0 to 48
		lName = "div" & lIdx
%>	
<div id="<%=lName%>">Ramesh</div>
<% next %>
<input type=button  value="test" onclick="OnMouseOverBody()">

<script language="javascript">
window.setInterval ("OnMouseOverBody()", 5000);
</script>
</BODY>
</HTML>

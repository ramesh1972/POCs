<%@ Language=VBScript %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<script language="vbscript">
function circley(x,r) 
	circley = (r*r - x*x) ^ (1/2)
end function

sub OnMouseOverBody() 
	Dim lIdx1
	
	for lIdx1 = -5 to 7 
		document.all("div" + (5 + lIdx1)).innerText = "R"
		document.all("div" + (5 + lIdx1)).style.position = "absolute"
		document.all("div" + (5 + lIdx1)).style.top = window.event.clientY
		document.all("div" + (5 + lIdx1)).style.left = window.event.clientX
		document.all("div" + (5 + lIdx1)).style.visibility  = "visible"
	next
end sub
</script>
</HEAD>
<BODY>

<P>&nbsp;</P>

</BODY>
</HTML>

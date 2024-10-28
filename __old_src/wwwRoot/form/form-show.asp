<%@ Language=VBScript %>
<HTML>
<HEAD>
</HEAD>
<%
	Dim bLeft
	Dim bTop
	Dim sLeft
	Dim ssTop
	Dim tLeft
	Dim tTop
	
	bLeft = Request.Form("bLeft")
	bTop = Request.Form("bTop")
	sLeft = Request.Form("sLeft")
	ssTop = Request.Form("sTop")
	tLeft = Request.Form("tLeft")
	tTop = Request.Form("tTop")
	
%>
<BODY>
<form name="frmForm" method="post" action="form.asp">
<DIV id=oDivForm style="width=300px;height=200px;background-color:inactivecaption" border=1 LANGUAGE="javascript" ondrag="return oDivForm_ondrag()">
<input type=button name=oButton id=oButton value="Click">
<input type=text name=oText id=oText value="Text">
<select id=oSelect>
<option>select</option>
</select>
</div>
<input type=submit Value="submit">
</form>
</BODY>
<script language="javascript">
oDivForm.style.position = "absolute"; 
oDivForm.style.left = 100;
oDivForm.style.top = 50;
oDivForm.style.right = 400;
oDivForm.style.bottom = 250; 

	frmForm.oButton.style.position = "absolute";
	frmForm.oButton.style.left = "<%=bLeft%>";
	frmForm.oButton.style.top = "<%=bTop%>";

	frmForm.oSelect.style.position = "absolute";
	frmForm.oSelect.style.left = "<%=sLeft%>";
	frmForm.oSelect.style.top = "<%=ssTop%>";

	frmForm.oText.style.position = "absolute";
	frmForm.oText.style.left = "<%=tLeft%>";
	frmForm.oText.style.top = "<%=tTop%>";
	
frmForm.oButton.style.width = 80;
frmForm.oButton.style.height = 20;
frmForm.oSelect.style.width = 120;
frmForm.oSelect.style.height = 20;
frmForm.oText.style.width = 120;
frmForm.oText.style.height = 20;
</script>
</HTML>

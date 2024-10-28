<HTML>
<LINK rel="stylesheet" type="text/css" href="inc/main.css">
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<SCRIPT Language=javascript>
	parent.frames[1].document.imgM.src = parent.frames[1].document.imgMorig.src
	parent.frames[1].document.imgQ.src = parent.frames[1].document.imgQorig.src
	parent.frames[1].document.imgE.src = parent.frames[1].document.imgEorig.src
	parent.frames[1].document.imgR.src = parent.frames[1].document.imgRorig.src
	parent.frames[1].document.imgC.src = parent.frames[1].document.imgCorig.src

	parent.frames[1].document.imgQ.src = parent.frames[1].document.imgQsel.src

function cmdNext_Click(iNext) {
	var iNext=0;
	iNext = document.frmAnnotation.txtDest.value
	iNext++;
	document.frmAnnotation.txtDest.value = iNext;
	document.frmAnnotation.submit;
}

function cmdPrev_Click(iPrev) {
	var iNext=0;
	iNext = document.frmAnnotation.txtDest.value
	iNext--;
	document.frmAnnotation.txtDest.value = iNext;
	document.frmAnnotation.submit;
}

function imageOn()
	{
		document.imgCross.src= "images/viewCrossSel.jpg"
	}
function imageOff(sName)
	{
		document.imgCross.src= "images/viewCross.jpg"
	}

function setmyfocus()
{
	window.parent.frames[3].focus()
}

</SCRIPT>

<% @Language=VBSCRIPT %>
<%
'CODE TO DETECT BROWSER VERSION
Dim strUA,bIE,bNet
	bIE = 0
	bNet = 0
	strUA = Request.ServerVariables("HTTP_USER_AGENT")
	If InStr(strUA, "MSIE") Then 'Internet Explorer
	   bIE= True
	Elseif InStr(strUA, "Mozilla") Then
		If InStr(strUA, "compatible;") = 0 and InStr(strUA, "Opera") = 0 Then  'it's Netscape
		   bNet = True
		End if
	End If

	'Write style for Netscape separately
	if bNet = True then
	  %>
	   <style type="text/css">
	   TD
	   {
	   		  FONT: 12px Verdana, Arial, Helvetica, sans-serif;
	   	      VERTICAL-ALIGN: middle;
	   	      TEXT-TRANSFORM: none;
	   	      HEIGHT: 12px;
	   	      TEXT-DECORATION: none;
	   }
	   </style>
	  <%
	end if
%>

</head>

<style type="text/css">
</style>
</HEAD>
<body onload="setmyfocus()" leftmargin="4" rightmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<FORM name="frmAnnotation" METHOD=POST >
<center>
<table cellpadding=4 cellspacing=0 border=0 class=vb8>
<tr>

<% 'Display Table depending on QID

Dim iQID,iLoop, Q, sAlt


	Q = chr(34)
	iQID = Request.Form("txtDest")
	if iQID = "" then
	   iQID = Request.Querystring("QID")
	end if
	if iQID = "" then iQID = 1
	For iLoop = 1 to 18
		if cint(iLoop) = cint(iQID) then
		   Response.Write "<td class=smallbody><A Href= " & Q & "annotation.asp?QID=" &  iLoop & Q & "><IMG BORDER=0 SRC =images/q" & iLoop & "sel.jpg ></a></td>"
		Else
		  ' Response.Write "<td class=smallbody><A Href= " & Q & "annotation.asp?QID=" &  iLoop & Q & " " & "onMouseOver=" & Q & "imageOn(" &  "'" & "image" & iLoop & "'" & ")" & Q & "><IMG Name=image" & iLoop & " BORDER=0 SRC =images/q" & iLoop & ".jpg ></a></td>"
		   Select Case iLoop
		   	Case 1: sAlt = "Q1. In what way would you say the number of patient requests you receive for brand-name prescription products has changed over the last few months?"
		   	Case 2: sAlt = "Q2. In the last few months, what percent of your patients have requested a prescription for a brand name medication?"
		   	Case 3: sAlt = "Q3. What percent of these patients did you write prescription?"
		   	Case 4: sAlt = "Q4. What are the some of the reasons that you did not write a prescription requested by a patient? (Please check all that apply)"
		   	Case 5: sAlt = "Q5. Which of the following describe your role in responding to the patients request for a brand-name medication that is not covered by the patient’s health plan? (Please check all that apply)"
		   	Case 6: sAlt = "Q6. Generally how likely are you to prescribe a brand-name medication based on a patient request for each of the following therapeutic categories?"
		   	Case 7: sAlt = "Q7. Generally to what extent do you agree with each of the following statements?"
		   	Case 8: sAlt = "Q8. Generally how are patients learning about the prescription products they are requesting? (Please check all that apply)"
		   	Case 9: sAlt = "Q9. What type of manufacturer’s advertisements do your patients generally cite? (Please check all that apply)"
			Case 10: sAlt = "Q10. In general, what messages do you believe patients are reacting to when requesting a specific brand-name medication? (Please check all that apply)"
			Case 11: sAlt = "Q11. What brand-name prescription products are most frequently requested and for what conditions are they requested?"
			Case 12: sAlt = "Q12. For what percent of your patients have you recommended a specific Health Care Web Site on the Internet as a means for learning about prescription products?"
			Case 13: sAlt = "Q13. How often, during a sales call, do the pharma sales reps mention their company’s advertisement to patients?"
			Case 14: sAlt = "Q14. Have you ever participated in an e-detailing program?"
			Case 15: sAlt = "Q15. Do you currently communicate with your patients through e-mail?"
			Case 16: sAlt = "Q16. Do you currently prescribe medications using a handheld e-prescribing device?"
			Case 17: sAlt = "Q17. Generally to what extent do you agree to each of these statements?"
			Case 18: sAlt = "Q18. Would you like to see Direct to Consumer advertisements to patients?"
		  End Select
  	      Response.Write "<td class=smallbody><A Href= " & Q & "annotation.asp?QID=" &  iLoop & Q & "><IMG Name=image" & iLoop & " BORDER=0 ALT = " & Q & sAlt & Q & " SRC =images/q" & iLoop & ".jpg ></a></td>"
		End if
	Next
	'Response.Write "<td class=smalltext>Focus to see question</td>"
	Response.Write "</tr></table><br>"
	Response.Write "<input type=hidden name=txtDest Value=" & iQID & ">"

	DisplayTable iQID

%>


<%
'Given question#, displays the appropriate cross-tab

Sub DisplayTable (iQID)
%>

<%

	Response.write "</center><a class=smalltext href=specialty.asp?QID=" & iQID & " onMouseOver=imageOn() onMouseOut=imageOff()><img name=imgCross border=0 src=images/viewcross.jpg></a><center>"

	Response.Write "<center><table class=VB10 width=101% border=1 bordercolor=#666666 cellspacing=1 cellpadding=2 style='border-collapse:collapse;mso-padding-alt:0in 0in 0in 0in'><tr><td align=center bgcolor=#CCDCEC>"


	If iQID = 1 then %>
		<table border="0" cellspacing=2 cellpadding=2 class="vb10" align="center" width="100%" >
		<!--<table class="VB10" width=96% border=1 bordercolor="#666666" cellspacing=1 cellpadding=2 style='border-collapse:collapse;mso-padding-alt:0in 0in 0in 0in'>-->
		<tr><td>Q1. In what way would you say the number of patient requests you receive for brand-name prescription products has changed over the last few months?</td></tr>
		</TABLE>
		<!-- Table for Options -->
		<TABLE border="0" cellspacing=2 cellpadding=4  class="smallbody" align="center" width="100%" >
		<TR>
			<TD width = 50>&nbsp;</TD><TD width=200>Increasing</TD><TD>42.3%</TD>
		</TR>
		<TR>
			<TD width = 50>&nbsp;</TD><TD width=200>Decreasing</TD><TD>7.0 %</TD>
		</TR>
		<TR>
			<TD width = 50>&nbsp;</TD><TD width=200>Remaining the same</TD><TD>50.7%</TD>
		</TR>
		<TR>
			<TD width = 50>&nbsp;</TD><TD width=100><b>n=2312</b></TD>
		</TR>
		<TR><TD Colspan=3 align=center ><INPUT class=highermenuitem name=cmdNext type=submit  value="Next >>" onClick="cmdNext_Click()"></TD></tr>
		</TABLE>
<%	ElseIf iQID = 2 then %>

		<table border="0" cellspacing=2 cellpadding=2 class="VB10" align="center" width="100%" >
		<tr><td>Q2. In the last few months, what percent of your patients have requested a prescription for a brand name medication?</td></tr>
		</TABLE>
		<!-- Table for Options -->
		<TABLE border="0" cellspacing=2 cellpadding=4  class="smallbody" align="center" width="100%" >
		<TR>
			<TD width = 50>&nbsp;</TD><TD width=200>100%</TD><TD>0.2%</TD>
		</TR>
		<TR>
			<TD width = 50>&nbsp;</TD><TD width=200>More than 50%</TD><TD>6.7%</TD>
		</TR>
		<TR>
			<TD width = 50>&nbsp;</TD><TD width=200>About 50%</TD><TD>10.3%</TD>
		</TR>
		<TR>
			<TD width = 50>&nbsp;</TD><TD width=200>Fewer than 50%</TD><TD>78.3%</TD>
		</TR>
		<TR>
			<TD width = 50>&nbsp;</TD><TD width=200>None</TD><TD>4.5%</TD>
		</TR>

		<TR>
			<TD width = 50>&nbsp;</TD><TD width=100><b>n=2312</b></TD>
		</TR>
		<TR><TD Colspan=3 align=center >
			<INPUT class=highermenuitem name=cmdPrev type=submit value="<< Prev" onClick="cmdPrev_Click()">
			<INPUT class=highermenuitem name=cmdNext type=submit value="Next >>" onClick="cmdNext_Click()">
			</TD>
		</TR>
		</TABLE>
<%	ElseIf iQID = 3 then %>

		<table border="0" cellspacing=2 cellpadding=2 class="VB10" align="center" width="100%" >
		<tr><td>Q3. What percent of these patients did you write prescription?</td></tr>
		</TABLE>
		<!-- Table for Options -->
		<TABLE border="0" cellspacing=2 cellpadding=4  class="smallbody" align="center" width="100%" >
		<TR>
			<TD width = 50>&nbsp;</TD><TD width=200>100%</TD><TD>12.9%</TD>
		</TR>
		<TR>
			<TD width = 50>&nbsp;</TD><TD width=200>More than 50%</TD><TD>38.0%</TD>
		</TR>
		<TR>
			<TD width = 50>&nbsp;</TD><TD width=200>About 50%</TD><TD>17.3%</TD>
		</TR>
		<TR>
			<TD width = 50>&nbsp;</TD><TD width=200>Fewer than 50%</TD><TD>30.0%</TD>
		</TR>
		<TR>
			<TD width = 50>&nbsp;</TD><TD width=200>None</TD><TD>1.9%</TD>
		</TR>
		<TR>
			<TD width = 50>&nbsp;</TD><TD width=100><b>n=2209</b></TD>
		</TR>
		<TR><TD Colspan=3 align=center >
			<INPUT class=highermenuitem name=cmdPrev type=submit value="<< Prev" onClick="cmdPrev_Click()">
			<INPUT class=highermenuitem name=cmdNext type=submit value="Next >>" onClick="cmdNext_Click()">
			</TD>
		</TR>
		</TABLE>
<%	ElseIf iQID = 4 then %>
		<!-- Table for Question -->
		<table border="0" cellspacing=2 cellpadding=2 class="VB10" align="center" width="100%" >
		<tr>
			<td>Q4. What are the some of the reasons that you did not write a prescription
	requested by a patient? (Please check all that apply)</td>
		</tr>
		</TABLE>


		<!-- Table for Options -->
		<TABLE border="0" cellspacing=2 cellpadding=4  class="smallbody" align="center" width="100%" >
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>&nbsp;</TD><TD class=vb10># of Responses</TD><TD class=vb10># of Respondents</TD>
		</TR>

		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>Not covered by health plan</TD><TD>23.9%</TD><TD>56.8%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>Side effect of requested drugs</TD><TD>17.3%</TD><TD>41.1%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>Not indication for condition</TD><TD>35.6%</TD><TD>84.8%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>Taking other medications that cannot be taken with the requested drug</TD><TD>16.7%</TD><TD>39.7%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>Other (specify)&nbsp;&nbsp;</TD><TD>&nbsp;&nbsp;6.5%</TD><TD>15.4%</TD>
		</TR>
		<TR>
			<TD Colspan=4 align=center >
				<INPUT class=highermenuitem name=cmdPrev type=submit value="<< Prev" onClick="cmdPrev_Click()">
				<INPUT class=highermenuitem name=cmdNext type=submit value="Next >>" onClick="cmdNext_Click()">
			</TD>
		</TR>

		</TABLE>

<%	ElseIf iQID = 5 then %>
		<!-- Table for Question -->
		<table border="0" cellspacing=2 cellpadding=2 class="VB10" align="center" width="100%" >
		<tr>
			<td>Q5. Which of the following describe your role in responding to the patients
	request for a brand-name medication that is not covered by the patient’s
	health plan? (Please check all that apply)</td>
		</tr>
		</TABLE>

		<!-- Table for Options -->
		<TABLE border="0" cellspacing=4 cellpadding=4  class="smallbody" align="center" width="100%" >

		<TR>
			<TD width=6%>&nbsp;</TD><TD width=52%>&nbsp;</TD><TD width=16% class=vb10># of Responses</TD><TD  width=16% class=vb10># of Respondents</TD>
		</TR>

		<TR>
			<TD >&nbsp;</TD><TD>Inform that patient that he/she must be willing to pay out-of-pocket cost for the prescription, because it will not be reimbursed</TD><TD valign=top >31.3%</TD><TD  valign=top>76.1%</TD>
		</TR>
		<TR>
			<TD >&nbsp;</TD><TD>Educate the patient on formulary restrictions and why preferred band should be tried first</TD><TD valign=top>17.3%</TD><TD valign=top >42.0%</TD>
		</TR>
			<TD >&nbsp;</TD><TD>Offer substitution (acceptable alternative); remind other patients that other drugs are similar and just as effective</TD><TD valign=top>29.8%</TD><TD valign=top >72.5%</TD>
		</TR>
		<TR>
			<TD >&nbsp;</TD><TD>Convince patient of safety and efficacy of generics; discourage use of brand names because they are so expensive to the patient</TD><TD valign=top>10.2%</TD><TD valign=top >24.7%</TD>
		</TR>
		<TR>
			<TD >&nbsp;</TD><TD>Review treatment protocol, e.g., encourage trial of an OTC drug first</TD><TD valign=top>8.9%</TD><TD valign=top >21.6%</TD>
		</TR>
		<TR>
			<TD >&nbsp;</TD><TD>Other (specify)&nbsp;&nbsp;</TD><TD>2.5%</TD><TD valign=top >6.2%</TD>
		</TR>
		<TR>
			<TD Colspan=4 align=center >
				<INPUT class=highermenuitem name=cmdPrev type=submit value="<< Prev" onClick="cmdPrev_Click()">
				<INPUT class=highermenuitem name=cmdNext type=submit value="Next >>" onClick="cmdNext_Click()">
			</TD>
		</TR>

		</TABLE>


		<!-- Table for Options
		<TABLE border="0" cellspacing=2 cellpadding=4  class="smallbody" align="center" width="100%" >

		<TR>
			<TD width=50>&nbsp;</TD><TD class=vb8 align="left">*These numbers represent the percent of total respondents.</TD>
		</TR>

		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>Inform that patient that he/she must be willing to pay out-of-pocket cost for the prescription, because it will not be reimbursed</TD><TD valign=top width=300>76.1%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>Educate the patient on formulary restrictions and why preferred band should be tried first</TD><TD valign=top width=300>42.0%</TD>
		</TR>
			<TD width=50>&nbsp;</TD><TD width=400>Offer substitution (acceptable alternative); remind other patients that other drugs are similar and just as effective</TD><TD valign=top width=300>72.5%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>Convince patient of safety and efficacy of generics; discourage use of brand names because they are so expensive to the patient</TD><TD valign=top width=300>24.7%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>Review treatment protocol, e.g., encourage trial of an OTC drug first</TD><TD valign=top width=300>21.6%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>Other (specify)&nbsp;&nbsp;</TD><TD valign=top width=300>6.2%</TD>
		</TR>


		<TR>
			<TD Colspan=2 align=center >
				<INPUT class=highermenuitem name=cmdPrev type=submit value="<< Prev" onClick="cmdPrev_Click()">
				<INPUT class=highermenuitem name=cmdNext type=submit value="Next >>" onClick="cmdNext_Click()">
			</TD>
		</TR>
		</TABLE>
		-->
<%	ElseIf iQID = 6 then %>

		<!-- Table for Question -->
		<table border="0" bordercolor="#666666" cellspacing=2 cellpadding=4 style='border-collapse:collapse;mso-padding-alt:0in 0in 0in 0in' class="VB10" align="center" width="100%" >
		<tr>
			<td>Q6. Generally how likely are you to prescribe a brand-name medication based on a
	patient request for each of the following therapeutic categories?</td>
		</tr>
		</TABLE>

		<!-- Table for Options -->
		<table border="1" bordercolor="#666666" cellspacing=2 cellpadding=4 style='border-collapse:collapse;mso-padding-alt:0in 0in 0in 0in' class="smallbody" align="center" width="100%" >
		<TR >
			<TD width=2000>&nbsp</TD><TD width=120 align=center>Very Likely</TD><TD width=150 align=center>Somewhat likely</TD><TD  align=center width=50>Neutral</TD><TD  align=center width=170>Not very likely</TD><TD  align=center width=180>Not at all likely</TD>
		</TR>
		<TR>
			<TD width =2000>SSRI/SNRI (Depression)</TD><TD align=center width =120>&nbsp;24.0%</TD><TD align=center width =150>&nbsp;27.0%</TD><TD align=center width =50>&nbsp;22.6%</TD><TD align=center width =170>&nbsp;8.7%</TD><TD align=center width =180>&nbsp;17.7%</TD>
		</TR>
		<TR>
			<TD width =2000>Anti-Histamines & Nasal Steroids (Allergy)</TD><TD align=center width =120>&nbsp;24.2%</TD><TD align=center width =150>&nbsp;34.5%</TD><TD align=center width =50>&nbsp;22.0%</TD><TD align=center width =170>&nbsp;8.9%</TD><TD align=center width =180>&nbsp;10.3%</TD>
		</TR>
		<TR>
			<TD width =2000>Cox 2 Inhibitors (Arthritis)</TD><TD align=center width =120>&nbsp;21.8%</TD><TD align=center width =150>&nbsp;30.6%</TD><TD align=center width =50>&nbsp;22.4%</TD><TD align=center width =170>&nbsp;9.7%</TD><TD align=center width =180>&nbsp;15.5%</TD>
		</TR>
		<TR>
			<TD width =2000>Cholesterol Reducers</TD><TD align=center width =120>&nbsp;16.6%</TD><TD align=center width =150>&nbsp;23.8%</TD><TD align=center width =50>&nbsp;28.7%</TD><TD align=center width =170>&nbsp;10.5%</TD><TD align=center width =180>&nbsp;20.5%</TD>
		</TR>
		<TR>
			<TD width =2000>Proton Pump Inhibitors (PPIs)</TD><TD align=center width =120>&nbsp;15.8%</TD><TD align=center width =150>&nbsp;24.0%</TD><TD align=center width =50>&nbsp;32.1%</TD><TD align=center width =170>&nbsp;10.6%</TD><TD align=center width =180>&nbsp;17.5%</TD>
		</TR>
		<TR>
			<TD width =2000>Sexual Function Disorder (E.D.)</TD><TD align=center width =120>&nbsp;25.9%</TD><TD align=center width =150>&nbsp;22.0%</TD><TD align=center width =50>&nbsp;25.4%</TD><TD align=center width =170>&nbsp;6.8%</TD><TD align=center width =180>&nbsp;19.8%</TD>
		</TR>
		<TR>
			<TD width =2000>Anti-Obesity (Weight Loss)</TD><TD align=center width =120>&nbsp;7.8%</TD><TD align=center width =150>&nbsp;12.4%</TD><TD align=center width =50>&nbsp;27.4%</TD><TD align=center width =170>&nbsp;16.7%</TD><TD align=center width =180>&nbsp;35.8%</TD>
		</TR>
		<TR>
			<TD width =2000>Anti-Virals Other (Flu or Herpes)</TD><TD align=center width =120>&nbsp;10.7%</TD><TD align=center width =150>&nbsp;22.6%</TD><TD align=center width =50>&nbsp;32.8%</TD><TD align=center width =170>&nbsp;15.1%</TD><TD align=center width =180>&nbsp;18.8%</TD>
		</TR>
		<TR>
			<TD width =2000>Leukotriene Agents & Inhaled Steroids (Bronchodilators)</TD><TD align=center width =120>&nbsp;13.8%</TD><TD align=center width =150>&nbsp;26.8%</TD><TD align=center width =50>&nbsp;30.7%</TD><TD align=center width =170>&nbsp;10.9%</TD><TD align=center width =180>&nbsp;17.8%</TD>
		</TR>
		<TR>
			<TD width =2000>Migraine Therapy</TD><TD align=center width =120>&nbsp;15.3%</TD><TD align=center width =150>&nbsp;30.8%</TD><TD align=center width =50>&nbsp;28.5%</TD><TD align=center width =170>&nbsp;9.1%</TD><TD align=center width =180>&nbsp;16.3%</TD>
		</TR>
		</TABLE>
		<TABLE border="0" cellspacing=2 cellpadding=2  class="VB10" align="center" width="100%" >
		<TR>
			<TD>n=2209</TD>
		</TR>
		<TR>
			<TD Colspan=2 align=center >
				<INPUT class=highermenuitem name=cmdPrev type=submit value="<< Prev" onClick="cmdPrev_Click()">
				<INPUT class=highermenuitem name=cmdNext type=submit value="Next >>" onClick="cmdNext_Click()">
			</TD>
		</TR>
		</TABLE>
<%	ElseIf iQID = 7 then %>
		<!-- Table for Question -->
		<table border="0" cellspacing=1 cellpadding=2 class="VB10" align="center" width="100%" >
		<tr>
			<td>Q7. Generally to what extent do you agree with each of the following statements?</td>
		</tr>
		</TABLE>

		<!-- Table for Options -->
		<table border="1" bordercolor="#666666" cellspacing=2 cellpadding=4 style='border-collapse:collapse;mso-padding-alt:0in 0in 0in 0in' class="smallbody" align="center" width="100%" >
		<TR>
			<TD width=2000>&nbsp;</TD><TD align=center width =120>Agree Strongly</TD><TD align=center width =150>Agree Somewhat</TD><TD align=center width =50>Neutral</TD><TD align=center width =170>Disagree Somewhat</TD><TD align=center width =180>Disagree Strongly</TD>
		</TR>
		<TR>
			<TD width=2000>I am more likely to prescribe a brand-name medication based on a patient
			request for patients who are generally healthy than those who are chronically ill</TD><TD align=center width =120>&nbsp;4.4%</TD><TD align=center width =150>&nbsp;18.7%</TD><TD align=center width =50>&nbsp;30.7%</TD><TD align=center width =170>&nbsp;23.4%</TD><TD align=center width =180>&nbsp;22.8%</TD>
		</TR>
		<TR>
			<TD width=2000>I am more likely to prescribe a brand-name medication based on a patient
			request for patients with an existing condition than those with a new diagnosis</TD><TD align=center width =120>&nbsp;5.2%</TD><TD align=center width =150>&nbsp;31.6%</TD><TD align=center width =50>&nbsp;30.9%</TD><TD align=center width =170>&nbsp;17.6%</TD><TD align=center width =180>&nbsp;14.7%</TD>
		</TR>
		<TR>
			<TD width=2000>I am more likely to prescribe a brand-name medication based on a patient
			request when a sample is available to provide to the patient</TD><TD align=center width =120>&nbsp;24.2%</TD><TD align=center width =150>&nbsp;47.0%</TD><TD align=center width =50>&nbsp;14.4%</TD><TD align=center width =170>&nbsp;7.6%</TD><TD align=center width =180>&nbsp;6.8%</TD>
		</TR>
		<TR>
			<TD width=2000>I am more likely to prescribe a brand-name medication based on a patient
			request if the patient is not responding to existing medication</TD><TD align=center width =120>&nbsp;41.9%</TD><TD align=center width =150>&nbsp;46.5%</TD><TD align=center width =50>&nbsp;6.9%</TD><TD align=center width =170>&nbsp;3.0%</TD><TD align=center width =180>&nbsp;1.6%</TD>
		</TR>
		<TR>
			<TD width=2000>I am more likely to prescribe a brand-name medication based on a patient
			request if the patient is not tolerating an existing medication</TD><TD align=center width =120>&nbsp;43.7%</TD><TD align=center width =150>&nbsp;46.7%</TD><TD align=center width =50>&nbsp;5.7%</TD><TD align=center width =170>&nbsp;2.4%</TD><TD align=center width =180>&nbsp;1.6%</TD>
		</TR>
		</TABLE>
		<TABLE border="0" cellspacing=2 cellpadding=4  class="smallbody" align="center" width="100%" >
		<TR>
			<TD><b>n=2209</b></TD>
		</TR>

		<TR>
			<TD Colspan=2 align=center >
				<INPUT class=highermenuitem name=cmdPrev type=submit value="<< Prev" onClick="cmdPrev_Click()">
				<INPUT class=highermenuitem name=cmdNext type=submit value="Next >>" onClick="cmdNext_Click()">
			</TD>
		</TR>
		</TABLE>

<%	ElseIf iQID = 8 then %>

		<!-- Table for Question -->
		<table border="0" cellspacing=2 cellpadding=2 class="VB10" align="center" width="100%" >
		<tr>
			<td>Q8. Generally how are patients learning about the prescription products they are
	requesting? (Please check all that apply)</td>
		</tr>
		</TABLE>

		<!-- Table for Options -->
		<TABLE border="0" cellspacing=2 cellpadding=4  class="smallbody" align="center" width="100%" >

		<TR>
			<TD width=6%>&nbsp;</TD><TD width=52%>&nbsp;</TD><TD width=16% class=vb10># of Responses</TD><TD  width=16% class=vb10># of Respondents</TD>
		</TR>

		<TR>
			<TD >&nbsp;</TD><TD >A manufacturer’s advertisement</TD><TD>36.1%</TD><TD>86.4%</TD>
		</TR>
		<TR>
			<TD >&nbsp;</TD><TD >A suggestion from a friend/relative</TD><TD>33.2%</TD><TD>79.4%</TD>
		</TR>
		<TR>
			<TD >&nbsp;</TD><TD >A suggestion from a pharmacist or other healthcare professional</TD><TD>12.4%</TD><TD>29.7%</TD>
		</TR>
		<TR>
			<TD >&nbsp;</TD><TD >A prior prescription</TD><TD>12.9%</TD><TD>30.8%</TD>
		</TR>
		<TR>
			<TD >&nbsp;</TD><TD >Don’t know</TD><TD>4.1%</TD><TD>9.8%</TD>
		</TR>
		<TR>
			<TD >&nbsp;</TD><TD >Other (specify)&nbsp;&nbsp;</TD><TD>1.4%</TD><TD>3.2%</TD>
		</TR>
		<TR>
			<TD Colspan=4 align=center >
				<INPUT class=highermenuitem name=cmdPrev type=submit value="<< Prev" onClick="cmdPrev_Click()">
				<INPUT class=highermenuitem name=cmdNext type=submit value="Next >>" onClick="cmdNext_Click()">
			</TD>
		</TR>

		</TABLE>


		<!-- Table for Options -->
		<!--<TABLE border="0" cellspacing=2 cellpadding=4  class="smallbody" align="center" width="100%" >
		<TR>
			<TD width=50>&nbsp;</TD><TD class=vb8 align="left">*These numbers represent the percent of total respondents.</TD>
		</TR>

		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>A manufacturer’s advertisement</TD><TD>86.4%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>A suggestion from a friend/relative</TD><TD>79.4%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>A suggestion from a pharmacist or other healthcare professional</TD><TD>29.7%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>A prior prescription</TD><TD>30.8%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>Don’t know</TD><TD>9.8%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>Other (specify)&nbsp;&nbsp;</TD><TD>3.2%</TD>
		</TR>
		<TR>
			<TD Colspan=2 align=center >
				<INPUT class=highermenuitem name=cmdPrev type=submit value="<< Prev" onClick="cmdPrev_Click()">
				<INPUT class=highermenuitem name=cmdNext type=submit value="Next >>" onClick="cmdNext_Click()">
			</TD>
		</TR>
		</TABLE>
		-->

<%	ElseIf iQID = 9 then %>
		<!-- Table for Question -->
		<table border="0" cellspacing=2 cellpadding=2 class="VB10" align="center" width="100%" >
		<tr>
			<td>Q9. What type of manufacturer’s advertisements do your patients generally cite?
	(Please check all that apply)</td>
		</tr>
		</TABLE>

		<!-- Table for Options -->
		<TABLE border="0" cellspacing=2 cellpadding=4  class="smallbody" align="center" width="100%" >
		<TR>
			<TD width=6%>&nbsp;</TD><TD width=52%>&nbsp;</TD><TD width=16% class=vb10># of Responses</TD><TD  width=16% class=vb10># of Respondents</TD>
		</TR>

		<TR>
			<TD >&nbsp;</TD><TD >Broadcast TV</TD><TD >29.9%</TD><TD>89.1%</TD>
		</TR>
		<TR>
			<TD >&nbsp;</TD><TD >TV in Doctors’ offices</TD><TD>1.3%</TD><TD>3.9%</TD>
		</TR>
		<TR>
			<TD >&nbsp;</TD><TD >Brochures in Doctors’ offices</TD><TD>5.9%</TD><TD>17.5%</TD>
		</TR>
		<TR>
			<TD >&nbsp;</TD><TD >Medical Journals</TD><TD>0.9%</TD><TD>2.7%</TD>
		</TR>
		<TR>
			<TD >&nbsp;</TD><TD >Consumer Journals/Magazines</TD><TD>25.3%</TD><TD>75.4%</TD>
		</TR>
		<TR>
			<TD >&nbsp;</TD><TD >Newspapers</TD><TD>17.7%</TD><TD>52.8%</TD>
		</TR>
		<TR>
			<TD >&nbsp;</TD><TD >Internet/On-line services</TD><TD>16.5%</TD><TD>49.3%</TD>
		</TR>
		<TR>
			<TD >&nbsp;</TD><TD >Don’t know</TD><TD>2.1%</TD><TD>6.3%</TD>
		</TR>
		<TR>
			<TD >&nbsp;</TD><TD >Other (specify)&nbsp;&nbsp;</TD><TD>0.4%</TD><TD>1.2%</TD>
		</TR>
		<TR>
		<TD Colspan=4 align=center >
			<INPUT class=highermenuitem name=cmdPrev type=submit value="<< Prev" onClick="cmdPrev_Click()">
			<INPUT class=highermenuitem name=cmdNext type=submit value="Next >>" onClick="cmdNext_Click()">
		</TD>
		</TR>

		</TABLE>


		<!-- Table for Options -->
		<!--
		<TABLE border="0" cellspacing=2 cellpadding=4  class="smallbody" align="center" width="100%" >
		<TR>
			<TD width=50>&nbsp;</TD><TD class=vb8 align="left">*These numbers represent the percent of total respondents.</TD>
		</TR>

		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>Broadcast TV</TD><TD>89.1%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>TV in Doctors’ offices</TD><TD>3.9%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>Brochures in Doctors’ offices</TD><TD>17.5%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>Medical Journals</TD><TD>2.7%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>Consumer Journals/Magazines</TD><TD>75.4%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>Newspapers</TD><TD>52.8%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>Internet/On-line services</TD><TD>49.3%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>Don’t know</TD><TD>6.3%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>Other (specify)&nbsp;&nbsp;</TD><TD>1.2%</TD>
		</TR>

		<TR>
			<TD Colspan=2 align=center >
				<INPUT class=highermenuitem name=cmdPrev type=submit value="<< Prev" onClick="cmdPrev_Click()">
				<INPUT class=highermenuitem name=cmdNext type=submit value="Next >>" onClick="cmdNext_Click()">
			</TD>
		</TR>
		</TABLE>
		-->
<%	ElseIf iQID = 10 then %>
		<!-- Table for Question -->
		<table border="0" cellspacing=2 cellpadding=2 class="VB10" align="center" width="100%" >
		<tr>
			<td>Q10. In general, what messages do you believe patients are reacting to when
	requesting a specific brand-name medication? (Please check all that apply)</td>
		</tr>
		</TABLE>

		<!-- Table for Options -->
		<TABLE border="0" cellspacing=2 cellpadding=4  class="smallbody" align="center" width="100%" >
		<TR>
			<TD width=6%>&nbsp;</TD><TD width=42%>&nbsp;</TD><TD width=16% class=vb10># of Responses</TD><TD  width=16% class=vb10># of Respondents</TD>
		</TR>

		<TR>
			<TD >&nbsp;</TD><TD >Efficacy</TD><TD>19.6%</TD><TD>57.0%</TD>
		</TR>
		<TR>
			<TD >&nbsp;</TD><TD >Price</TD><TD>2.0%</TD><TD>5.8%</TD>
		</TR>
		<TR>
			<TD >&nbsp;</TD><TD >Branding</TD><TD>9.3%</TD><TD>27.1%</TD>
		</TR>
		<TR>
			<TD >&nbsp;</TD><TD >New product to try</TD><TD>19.7%</TD><TD>57.4%</TD>
		</TR>
		<TR>
			<TD >&nbsp;</TD><TD >New treatment awareness</TD><TD>19.6%</TD><TD>57.2%</TD>
		</TR>
		<TR>
			<TD >&nbsp;</TD><TD >Convenience</TD><TD>6.8%</TD><TD>19.8%</TD>
		</TR>
		<TR>
			<TD >&nbsp;</TD><TD >Internet/On-line services</TD><TD>16.1%</TD><TD>47.0%</TD>
		</TR>
		<TR>
			<TD >&nbsp;</TD><TD >Safety</TD><TD>5.3%</TD><TD>15.5%</TD>
		</TR>
		<TR>
			<TD >&nbsp;</TD><TD >Other (specify)&nbsp;&nbsp;</TD><TD>1.6%</TD><TD>4.8%</TD>
		</TR>
		<TR>
			<TD Colspan=4 align=center >
				<INPUT class=highermenuitem name=cmdPrev type=submit value="<< Prev" onClick="cmdPrev_Click()">
				<INPUT class=highermenuitem name=cmdNext type=submit value="Next >>" onClick="cmdNext_Click()">
			</TD>
		</TR>
		</TABLE>


		<!-- Table for Options -->
		<!--
		<TABLE border="0" cellspacing=2 cellpadding=4  class="smallbody" align="center" width="100%" >
		<TR>
			<TD width=50>&nbsp;</TD><TD class=vb8 align="left">*These numbers represent the percent of total respondents.</TD>
		</TR>

		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>Efficacy</TD><TD>57.0%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>Price</TD><TD>5.8%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>Branding</TD><TD>27.1%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>New product to try</TD><TD>57.4%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>New treatment awareness</TD><TD>57.2%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>Convenience</TD><TD>19.8%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>Internet/On-line services</TD><TD>47.0%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>Safety</TD><TD>15.5%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>Other (specify)&nbsp;&nbsp;</TD><TD>4.8%</TD>
		</TR>
		<TR>
			<TD Colspan=2 align=center >
				<INPUT class=highermenuitem name=cmdPrev type=submit value="<< Prev" onClick="cmdPrev_Click()">
				<INPUT class=highermenuitem name=cmdNext type=submit value="Next >>" onClick="cmdNext_Click()">
			</TD>
		</TR>
		</TABLE>
		-->

<%	ElseIf iQID = 11 then %>
		<!-- Table for Question -->
		<table border="0" cellspacing=2 cellpadding=2 class="VB10" align="center" width="100%" >
		<tr>
			<td>Q11. What brand-name prescription products are most frequently requested and
	for what conditions are they requested?</td>
		</tr>
		</TABLE>
		<br>
		<!-- Table for Options -->
		<TABLE border="0" cellspacing=1 cellpadding=2  class="smallbody" align="center" >
		<TR>
			<TD class= vb10 align="left">Brand Name</TD>
			<TD class= vb10 align="left">Condition</TD>
		</TR>
		<TR>
			<TD><INPUT value="Claritin"></TD>
			<TD><INPUT value="Allergy"></TD>
		</TR>
		<TR>
			<TD><INPUT value="Viagra"></TD>
			<TD><INPUT value="E.D."></TD>
		</TR>
		<TR>
			<TD><INPUT value="Celebrex"></TD>
			<TD><INPUT value="Arthritis"></TD>
		</TR>
		<TR>
			<TD><INPUT value="Vioxx"></TD>
			<TD><INPUT value="Arthritis"></TD>
		</TR>
		<TR>
			<TD><INPUT value="Allegra"></TD>
			<TD><INPUT value="Allergy"></TD>
		</TR>
		<TR>
			<TD Colspan=2 align=center >
				<INPUT class=highermenuitem name=cmdPrev type=submit value="<< Prev" onClick="cmdPrev_Click()">
				<INPUT class=highermenuitem name=cmdNext type=submit value="Next >>" onClick="cmdNext_Click()">
			</TD>
		</TR>
		</TABLE>
<%	ElseIf iQID = 12 then %>
		<!-- Table for Question -->
		<table border="0" cellspacing=2 cellpadding=2 class="VB10" align="center" width="100%" >
		<tr>
			<td>Q12. For what percent of your patients have you recommended a specific Health Care
	Web Site on the Internet as a means for learning about prescription products?</td>
		</tr>
		</TABLE>

		<!-- Table for Options -->
		<TABLE border="0" cellspacing=2 cellpadding=4  class="smallbody" align="center" width="100%" >
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>100%</TD><TD>0.3%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>More than 50%</TD><TD>3.0%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>About 50%</TD><TD>3.1%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>Fewer than 50%</TD><TD>35.0%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>None</TD><TD>58.6%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=100><b>n=2312</b></TD>
		</TR>
		<TR>
			<TD Colspan=3 align=center >
				<INPUT class=highermenuitem name=cmdPrev type=submit value="<< Prev" onClick="cmdPrev_Click()">
				<INPUT class=highermenuitem name=cmdNext type=submit value="Next >>" onClick="cmdNext_Click()">
			</TD>
		</TR>
		</TABLE>
<%	ElseIf iQID = 13 then %>
		<!-- Table for Question -->
		<table border="0" cellspacing=2 cellpadding=2 class="VB10" align="center" width="100%" >
		<tr>
			<td>Q13. How often, during a sales call, do the pharma sales reps mention their
	company’s advertisement to patients?</td>
		</tr>
		</TABLE>

		<!-- Table for Options -->
				<TABLE border="0" cellspacing=2 cellpadding=4  class="smallbody" align="center" width="100%" >
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>Usually</TD><TD>0.3%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>Frequently</TD><TD>3.0%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>Occasionally</TD><TD>3.1%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>Seldom</TD><TD>35.0%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>Never</TD><TD>58.6%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=100><b>n=2311</b></TD>
		</TR>
		<TR>
			<TD Colspan=3 align=center >
				<INPUT class=highermenuitem name=cmdPrev type=submit value="<< Prev" onClick="cmdPrev_Click()">
				<INPUT class=highermenuitem name=cmdNext type=submit value="Next >>" onClick="cmdNext_Click()">
			</TD>
		</TR>
		</TABLE>
<%	ElseIf iQID = 14 then %>
		<!-- Table for Question -->
		<table border="0" cellspacing=2 cellpadding=2 class="VB10" align="center" width="100%" >
		<tr>
			<td>Q14. Have you ever participated in an e-detailing program?</td>
		</tr>
		</TABLE>

		<!-- Table for Options -->
				<TABLE border="0" cellspacing=2 cellpadding=4  class="smallbody" align="center" width="100%" >
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>Yes</TD><TD>19.3%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>No</TD><TD>70.6%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>No, but I am likely to start in the next 6 months</TD><TD>10.0%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=100><b>n=2312</b></TD>
		</TR>



		<TR>
			<TD Colspan=3 align=center >
				<INPUT class=highermenuitem name=cmdPrev type=submit value="<< Prev" onClick="cmdPrev_Click()">
				<INPUT class=highermenuitem name=cmdNext type=submit value="Next >>" onClick="cmdNext_Click()">
			</TD>
		</TR>
		</TABLE>
<%	ElseIf iQID = 15 then %>
		<!-- Table for Question -->
		<table border="0" cellspacing=2 cellpadding=2 class="VB10" align="center" width="100%" >
		<tr>
			<td>Q15. Do you currently communicate with your patients through e-mail?</td>
		</tr>
		</TABLE>

		<!-- Table for Options -->
				<TABLE border="0" cellspacing=2 cellpadding=4  class="smallbody" align="center" width="100%" >
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>Yes</TD><TD>15.5%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>No</TD><TD>78.5%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>No, but I am likely to start in the next 6 months</TD><TD>6.1%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=100><b>n=2312</b></TD>
		</TR>
		<TR>
			<TD Colspan=3 align=center >
				<INPUT class=highermenuitem name=cmdPrev type=submit value="<< Prev" onClick="cmdPrev_Click()">
				<INPUT class=highermenuitem name=cmdNext type=submit value="Next >>" onClick="cmdNext_Click()">
			</TD>
		</TR>
		</TABLE>
<%	ElseIf iQID = 16 then %>
		<!-- Table for Question -->
		<table border="0" cellspacing=2 cellpadding=2 class="VB10" align="center" width="100%" >
		<tr>
			<td>Q16. Do you currently prescribe medications using a handheld e-prescribing device?</td>
		</tr>
		</TABLE>

		<!-- Table for Options -->
		<TABLE border="0" cellspacing=2 cellpadding=4  class="smallbody" align="center" width="100%" >
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>Yes</TD><TD>4.2%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>No</TD><TD>87.1%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>No, but I am likely to start in the next 6 months</TD><TD>8.8%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=100><b>n=2312</b></TD>
		</TR>

		<TR>
			<TD Colspan=3 align=center >
				<INPUT class=highermenuitem name=cmdPrev type=submit value="<< Prev" onClick="cmdPrev_Click()">
				<INPUT class=highermenuitem name=cmdNext type=submit value="Next >>" onClick="cmdNext_Click()">
			</TD>
		</TR>
		</TABLE>
<%	ElseIf iQID = 17 then %>
		<!-- Table for Question -->
		<table border="0" bordercolor="#666666" cellspacing=2 cellpadding=4 style='border-collapse:collapse;mso-padding-alt:0in 0in 0in 0in' class="VB10" align="center" width="100%" >
		<tr>
			<td>Q17. Generally to what extent do you agree to each of these statements?</td>
		</tr>
		</TABLE>

		<!-- Table for Options -->
		<TABLE border="1" bordercolor="#666666" cellspacing=2 cellpadding=4 style='border-collapse:collapse;mso-padding-alt:0in 0in 0in 0in' class="smallbody" align="center" width="100%" >
		<TR>
			<TD width=2000>&nbsp;</TD><TD width=120>Agree Strongly</TD><TD width=150>Agree Somewhat</TD><TD width=50>Neutral</TD><TD width=170>Disagree Somewhat</TD><TD width=180>Disagree Strongly</TD>
		</TR>
		<TR>
			<TD width=2000>Direct-to-Consumer advertising contributes to a stronger doctor/patient
			relationship, due to promoting higher levels of patient interest in their well-being.</TD><TD width=120>&nbsp;3.0%</TD><TD width=150>&nbsp;16.3%</TD><TD width=50>&nbsp;22.2%</TD><TD width=170>&nbsp;30.0%</TD><TD width=180>&nbsp;28.5%</TD>
		</TR>
		<TR>
			<TD width=2000>Direct-to-Consumer leads to better patient behavior through education,
			e.g. compliance and/or motivation to seek help.</TD><TD width=120>&nbsp;3.9%</TD><TD width=150>&nbsp;25.7%</TD><TD width=50>&nbsp;23.4%</TD><TD width=170>&nbsp;25.3%</TD><TD width=180>&nbsp;21.6%</TD>
		</TR>
		<TR>
			<TD width=2000>Pharmaceutical companies should have the right to promote their products
			directly to the consumer population.</TD><TD width=120>&nbsp;9.4%</TD><TD width=150>&nbsp;27.4%</TD><TD width=50>&nbsp;25.5%</TD><TD width=170>&nbsp;20.1%</TD><TD width=180>&nbsp;17.6%</TD>
		</TR>
		<TR>
			<TD width=2000>As a general rule, consumers have the ability to understand DTC
			advertisements so that a meaningful dialogue can occur with the physicians.</TD><TD width=120>&nbsp;2.9%</TD><TD width=150>&nbsp;21.2%</TD><TD width=50>&nbsp;19.3%</TD><TD width=170>&nbsp;34.0%</TD><TD width=180>&nbsp;22.6%</TD>
		</TR>
		<TR>
			<TD width=2000>Pharmaceutical companies should provide advance notice to physicians
			prior to rolling out of new DTC campaign.</TD><TD width=120>&nbsp;32.2%</TD><TD width=150>&nbsp;32.0%</TD><TD width=50>&nbsp;25.0%</TD><TD width=170>&nbsp;8.0%</TD><TD width=180>&nbsp;2.7%</TD>
		</TR>
		<TR>
			<TD width=2000>Direct-to-Consumer advertising results in excessive physician effort to
			explain reasons for not prescribing a requested medication.</TD><TD width=120>&nbsp;15.2%</TD><TD width=150>&nbsp;21.5%</TD><TD width=50>&nbsp;43.6%</TD><TD width=170>&nbsp;10.9%</TD><TD width=180>&nbsp;9.0%</TD>
		</TR>
		<TR>
			<TD width=2000>DTC advertising inappropriately influences patient demands.</TD><TD width=120>&nbsp;32.4%</TD><TD width=150>&nbsp;42.7%</TD><TD width=50>&nbsp;13.7%</TD><TD width=170>&nbsp;9.3%</TD><TD width=180>&nbsp;1.9%</TD>
		</TR>
		<TR>
			<TD width=2000>Advertising should only be directed to doctors as it is inappropriate
			to advertise pharmaceuticals directly to patients.</TD><TD width=120>&nbsp;30.0%</TD><TD width=150>&nbsp;43.0%</TD><TD width=50>&nbsp;16.5%</TD><TD width=170>&nbsp;8.6%</TD><TD width=180>&nbsp;1.9%</TD>
		</TR>
		<TR>
			<TD width=2000>DTC messages /ads are misleading to patients.</TD><TD width=120>&nbsp;24.3%</TD><TD width=150>&nbsp;27.1%</TD><TD width=50>&nbsp;24.9%</TD><TD width=170>&nbsp;18.3%</TD><TD width=180>&nbsp;5.5%</TD>
		</TR>
		<TR>
			<TD width=2000>DTC advertising creates a personal conflict for a physician, via balancing
			the desire to satisfy a patient request versus satisfying the formulary guidelines set
			forth by managed care organizations.</TD><TD width=120>&nbsp;22.0%</TD><TD width=150>&nbsp;39.0%</TD><TD width=50>&nbsp;23.6%</TD><TD width=170>&nbsp;12.4%</TD><TD width=180>&nbsp;2.9%</TD>
		</TR>
		<TR>
			<TD width=2000>Pharmaceutical companies should provide advance notice to managed care
			organizations prior to rolling out a new DTC campaign.</TD><TD width=120>&nbsp;23.0%</TD><TD width=150>&nbsp;39.0%</TD><TD width=50>&nbsp;21.6%</TD><TD width=170>&nbsp;12.1%</TD><TD width=180>&nbsp;4.3%</TD>
		</TR>
		</table>

		<TABLE border="0" cellspacing=2 cellpadding=2  class="VB10" align="center" width="100%" >
		<TR>
			<TD>n=2312</TD>
		</TR>
				<TR>
			<TD Colspan=2 align=center >
				<INPUT class=highermenuitem name=cmdPrev type=submit value="<< Prev" onClick="cmdPrev_Click()">
				<INPUT class=highermenuitem name=cmdNext type=submit value="Next >>" onClick="cmdNext_Click()">
			</TD>
		</TR>
		</TABLE>
<%	ElseIf iQID = 18 then %>
		<!-- Table for Question -->
		<table border="0" cellspacing=2 cellpadding=2 class="VB10" align="center" width="100%" >
		<tr>
			<td>Q18. Would you like to see Direct to Consumer advertisements to patients:</td>
		</tr>
		</TABLE>

		<!-- Table for Options -->
		<TABLE border="0" cellspacing=2 cellpadding=4  class="smallbody" align="center" width="100%" >
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>Increase</TD><TD>6.7%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>Decrease</TD><TD>29.5%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>Remain the same</TD><TD>26.4%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=400>Discontinue</TD><TD>37.5%</TD>
		</TR>
		<TR>
			<TD width=50>&nbsp;</TD><TD width=100><b>n=2312</b></TD>
		</TR>
		<TR>
			<TD Colspan=3 align=center >
				<INPUT class=highermenuitem name=cmdPrev type=submit value="<< Prev" onClick="cmdPrev_Click()">
			</TD>
		</TR>
		</TABLE>

<%  End if%>

<%End Sub%>
	</FORM>
	<%Response.Write "</td></tr></table>"%>
</BODY>
</HTML>



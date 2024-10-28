<Script language=javascript>
img1 = new Image(150,21)
img1.src = "images/topnavMethod.gif"
img2 = new Image(150,21)
img2.src = "images/topnavQuest.gif"
img3 = new Image(150,21)
img3.src = "images/topnavExec.gif"
img4 = new Image(150,21)
img4.src = "images/topnavResearch.gif"
img5 = new Image(150,21)
img5.src = "images/topnavCross.gif"

img1sel = new Image(150,21)
img1sel.src = "images/topnavMethodsel.gif"
img2sel = new Image(150,21)
img2sel.src = "images/topnavQuestsel.gif"
img3sel = new Image(150,21)
img3sel.src = "images/topnavExecsel.gif"
img4sel = new Image(150,21)
img4sel.src = "images/topnavResearchsel.gif"
img5sel = new Image(150,21)
img5sel.src = "images/topnavCrosssel.gif"


function swapimages(iImg)
{
	top.document.getElementById('frmsetLeft').cols = '0, *';
	document.imgM.src=img1.src;
	document.imgQ.src=img2.src;
	document.imgE.src=img3.src;
	document.imgR.src=img4.src;
	document.imgC.src=img5.src;
	if (iImg == 1)
	   document.imgM.src = img1sel.src;
	if (iImg == 2)
	   document.imgQ.src = img2sel.src;
	if (iImg == 3)
	   document.imgE.src = img3sel.src;
	if (iImg == 4)
	{
	   document.imgR.src = img4sel.src;
	   parent.frames[1].document.imgM.src = parent.frames[1].document.imgMorig.src
	   top.document.getElementById('frmsetLeft').cols = '40%, *';

	}
	if (iImg == 5)
	   document.imgC.src = img5sel.src;
}
</script>
<LINK rel="stylesheet" type="text/css" href="inc/main.css">
<center>
<table cellspacing="0" cellpadding="0" border="0" align="center" width="100%" height="70">
  <tr><td colspan=2><hr size=1 color="#000099"></td></tr>
  <tr height="70">
      <td width=30% valign=middle align="left" nowrap>&nbsp;&nbsp;<a href=start.asp target="content_area"><img border=0 src="images/ppsleft.jpg"></a></td>
      <td align=left valign=top ><img src="images/topbanner.gif"></td>
  </tr>
</table>
<!--
<table cellspacing="0" cellpadding="0" border="0" align="center" width="100%">
  <tr>
      <td colspan=2><hr size=1 color="#000099"></td>
  </tr>
  <tr>
      <td width="67%" align=right><img src=images/pps.gif></td>
      <td align=right><img src=images/contactus.gif>&nbsp;&nbsp;&nbsp;&nbsp;</td>
  </tr>
  <tr>
      <td colspan=2><hr size=1 color="#000099"></td>
  </tr>
</table>
-->
<table cellspacing=0 cellpadding=0><tr><td><center><A target="content_area" Href =methodology.asp onClick="swapimages(1)"><img name=imgM border=0 width =150 src="images/topnavMethodSel.gif"></A><A target="content_area" onClick="swapimages(2)" Href =annotation.asp><img name=imgQ border=0 width =150 src="images/topnavQuest.gif"></A><A target="content_area" Href =executive.asp onClick="swapimages(3)"><img name=imgE border=0 width =150 src="images/topnavExec.gif"></A><A target="content_area" Href =research.asp onClick="swapimages(4)"><img name=imgR border=0 width =150 src="images/topnavResearch.gif"></A><A target="content_area" Href =specialty.asp onClick="swapimages(5)"><img name=imgC border=0 width =150 src="images/topnavCross.gif"></A></center></td></tr></table>
<br><br><br><br>
<img name=imgMorig src=images/topnavMethod.gif>
<img name=imgQorig src=images/topnavQuest.gif>
<img name=imgEorig src=images/topnavExec.gif>
<img name=imgRorig src=images/topnavResearch.gif>
<img name=imgCorig src=images/topnavCross.gif>

<img name=imgMsel src=images/topnavMethodsel.gif>
<img name=imgQsel src=images/topnavQuestsel.gif>
<img name=imgEsel src=images/topnavExecsel.gif>
<img name=imgRsel src=images/topnavResearchsel.gif>
<img name=imgCsel src=images/topnavCrosssel.gif>

</center>





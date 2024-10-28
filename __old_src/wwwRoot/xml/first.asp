<%@ Language=VBScript %>
<HTML>
<HEAD>
<SCRIPT LANGUAGE="JScript">
var collBehaviorID = new Array();
var collLI = new Array ();
var countLI = 0;

function attachBehavior()
{
	collLI = document.all.tags ("LI");
	countLI = collLI.length;
	for (i=0; i < countLI; i++)
	{

	var iID = collLI[i].addBehavior ("hi.htc");
		if (iID)
		{
		collBehaviorID[i] = iID;
		}
	}
}
</SCRIPT>
:
Click <A HREF="javascript:attachBehavior()">here</A>
to add a highlighting effect as you hover over each item below.

<UL>
  <LI STYLE="behavior:url(hi.htc)">HTML Authoring</LI>
  <LI STYLE="behavior:url(hi.htc)">Dynamic HTML</LI>
</UL>
</HTML>

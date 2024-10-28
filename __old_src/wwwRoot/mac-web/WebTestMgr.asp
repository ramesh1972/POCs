<HTML>
<BODY>
<TITLE> Testing C++Builder ASP </TITLE>
<CENTER>
<H3> You should see the results of your C++Builder Active Server method below </H3>
</CENTER>
<HR>
<% Set CBuilderASPObj = Server.CreateObject("WebTest.WebTestMgr") 

   Call CBuilderASPObj.DisplayString(lMsg)
   
   Response.Write("Message = " & lMsg)
%>
<HR>
</BODY>
</HTML>
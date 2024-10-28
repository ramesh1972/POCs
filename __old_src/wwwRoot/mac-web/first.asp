<%@ Language=VBScript %>
<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
</HEAD>
<BODY>
Hello
<P>&nbsp;</P>
<% 
	Set CBuilderASPObj = Server.CreateObject("Mac.MarketMonitorMgr") 
   
   length = CBuilderASPObj.DoBrowse("BOOE",mktcode, Desc, Max, Min, mindrip, circ, scirc, maop, gel1, gel2, gel3, geedfactor, gesdfactor, mml1, mml2, mml3, mmedfactor, mmsdfactor, smm, pass, tradec, traded, lot, tick)
    
    Response.Write("Desc = " & Desc & "<BR>")
    Response.Write("Ord Max = " & Max & "<BR>")
    Response.Write("Ord Min = " & Min & "<BR>")
    Response.Write("Ord Drip = " & mindrip & "<BR>")
    Response.Write("Ord Circ = " & circ & "<BR>")
                
    set CBuilderASPObj = nothing
%>
</BODY>
</HTML>

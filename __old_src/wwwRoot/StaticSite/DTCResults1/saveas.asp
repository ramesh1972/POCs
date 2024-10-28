<HEAD>

<STYLE>
   .userData {behavior:url(#default#userdata);}
</STYLE>   

<SCRIPT>
   function fnSave(){
	  alert("hello");
      oPersistInput.setAttribute("sPersistAttr","region.xls");
      oPersistInput.save("oDataStore");
   }
</SCRIPT>
</HEAD>

<BODY >
<A href="" class=userData id=oPersistInput onclick="fnSave()"> Save </A>
</BODY>

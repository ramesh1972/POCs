<body></body>
<script language=javascript>
function test_array()
{
	var a = new Array();
	var x = "1";
	a.push(x);
	a.push("2");
	
	alert(a.length);
	
	delete x;
	
	alert(a.length);
}

test_array();
</script>
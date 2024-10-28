<%@ Language=VBScript %>
<HTML>
<HEAD>
<script language="javascript">
var currentTab = -1;

var aText = new Array(4);
aText[0] = "New";
aText[1] = "Open";
aText[2] = "Save";
aText[3] = "Close";

function DisplayImages(piLeft, piTop, piWidth, piHeight, piNumCols) {
	var lCellWidth = piWidth/piNumCols;
	
	for (var lIdx = 0;lIdx < piNumCols; lIdx++) {
		var oImg = document.all("oImgColHeadCell" + lIdx);
		var oSpan = document.all("oSpanColHeadCell" + lIdx);
		
		oImg.src = "image001.gif";
		oSpan.innerText = aText[lIdx];
		oSpan.style.align ="center";
		
		oImg.style.position = "absolute";
		oImg.style.left = piLeft + (lCellWidth * lIdx);
		oImg.style.top = piTop;
		oImg.style.width = lCellWidth + (lCellWidth/6);
		oImg.style.height = piHeight;
		oImg.style.zIndex = (piNumCols-lIdx);
		
		oSpan.style.position = "absolute";
		oSpan.style.left = piLeft + (lCellWidth * lIdx) + (lCellWidth/3);
		oSpan.style.top = piTop;
		oSpan.style.width = lCellWidth;
		oSpan.style.height = piHeight;
		oSpan.style.zIndex = (piNumCols+1);
	}
}

function SelectTab(tabNo, piNumCols) {
	if (tabNo == currentTab)
		return;
		
	var oImg = document.all("oImgColHeadCell" + tabNo);
	var oImgCurrent
	var oSpan;
	var oSpanCurrent;

	if (currentTab != -1) {
		oImgCurrent = document.all("oImgColHeadCell" + currentTab);	
		oSpan = document.all("oSpanColHeadCell" + tabNo);
		oSpanCurrent = document.all("oSpanColHeadCell" + currentTab);
	}
	
	oImg.src = "image002.gif";
	
	if (currentTab != -1) {	
		oImgCurrent.src = "image001.gif";
		oImgCurrent.style.zIndex = currentTab+1;

		oSpan.style.fontWeight = "700";
		oSpanCurrent.style.fontWeight = "normal";
	}
		
	oImg.style.zIndex = piNumCols;
	for (var lIdx=0; lIdx < tabNo;lIdx++) {
		var oImg1 = document.all("oImgColHeadCell" + lIdx);
		oImg1.style.zIndex = piNumCols-(1+lIdx);
	}
	
	var currentzIndex = piNumCols-lIdx;
	for (var lIdx1=tabNo+1; lIdx1 < piNumCols;lIdx1++) {
		var oImg1 = document.all("oImgColHeadCell" + lIdx1);
		oImg1.style.zIndex = currentzIndex - 1;
		currentzIndex--;
	}

	currentTab = tabNo;
}
</script>
</HEAD>

<body marginheight="0" marginwidth="0" topmargin='0' leftmargin='0'>
<% Call DisplayColHeader(200,100, 300, 20, 4) %>
<script language="javascript">
DisplayImages(200,100, 300, 20, 4);
SelectTab(0, 4);
</script>
</BODY>

<% 
Function DisplayColHeader(piLeft, piTop, piWidth, piHeight, piNumCols)
	Dim lIdx
	For lIdx = 0 To piNumCols-1
	%>
		<Img id="oImgColHeadCell<%=lIdx%>">
		<Span onclick="SelectTab(<%=lIdx%>, <%=piNumCols%>)" id="oSpanColHeadCell<%=lIdx%>"></Span>
	<%
	Next
End Function
%>
</HTML>

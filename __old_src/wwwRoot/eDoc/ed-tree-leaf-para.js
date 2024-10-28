// Paragraph related functions
function ParaTitlePropertyApply(piElementID) {
	var lForm = document.forms("frmUpdatePara" + piElementID);
	var lTitle = lForm("tbParaTitle" + piElementID);
	
	// Set the properties for the para title
	lTitle.style.textAlign = lForm.sTextAlign.value;
	lTitle.style.color = lForm.sTextColor.value;
	lTitle.style.textDecoration = lForm.sTextDeco.value;
	lTitle.style.backgroundColor = lForm.sBGColor.value;
	lTitle.style.borderWidth = lForm.tbBorderWidth.value;
	lTitle.style.borderColor = lForm.sBorderColor.value;
	lTitle.style.borderStyle = lForm.sBorderStyle.value;
	lTitle.style.fontFamily = lForm.sFontFamily.value;
	lTitle.style.fontWeight = lForm.sFontWeight.value;
	lTitle.style.fontSize = lForm.tbFontSize.value;
	
	// set the values for the hidden fields
	lForm.hTextAlign.value = lForm.sTextAlign.value;
	lForm.hTextColor.value = lForm.sTextColor.value;
	lForm.hTextDeco.value = lForm.sTextDeco.value;
	lForm.hBGColor.value = lForm.sBGColor.value;
	lForm.hBGImage.value = lForm.fBGImage.value;
	lForm.hBorderWidth.value = lForm.tbBorderWidth.value;
	lForm.hBorderColor.value = lForm.sBorderColor.value;
	lForm.hBorderStyle.value = lForm.sBorderStyle.value;
	lForm.hFontFamily.value = lForm.sFontFamily.value;
	lForm.hFontWeight.value = lForm.sFontWeight.value;
	lForm.hFontSize.value = lForm.tbFontSize.value;
}

function ParaPropertyApply(piElementID) {
	var lForm = document.forms("frmUpdatePara" + piElementID);
	var lPara = lForm("taPara" + piElementID);
	
	// Set the properties for the para Para
	lPara.style.textAlign = lForm.sParaTextAlign.value;
	lPara.style.color = lForm.sParaTextColor.value;
	lPara.style.textDecoration = lForm.sParaTextDeco.value;
	lPara.style.backgroundColor = lForm.sParaBGColor.value;
	lPara.style.borderWidth = lForm.tbParaBorderWidth.value;
	lPara.style.borderColor = lForm.sParaBorderColor.value;
	lPara.style.borderStyle = lForm.sParaBorderStyle.value;
	lPara.style.fontFamily = lForm.sParaFontFamily.value;
	lPara.style.fontWeight = lForm.sParaFontWeight.value;
	lPara.style.fontSize = lForm.tbParaFontSize.value;
	
	// set the values for the hidden fields
	lForm.hParaTextAlign.value = lForm.sParaTextAlign.value;
	lForm.hParaTextColor.value = lForm.sParaTextColor.value;
	lForm.hParaTextDeco.value = lForm.sParaTextDeco.value;
	lForm.hParaBGColor.value = lForm.sParaBGColor.value;
	lForm.hParaBGImage.value = lForm.fParaBGImage.value;
	lForm.hParaBorderWidth.value = lForm.tbParaBorderWidth.value;
	lForm.hParaBorderColor.value = lForm.sParaBorderColor.value;
	lForm.hParaBorderStyle.value = lForm.sParaBorderStyle.value;
	lForm.hParaFontFamily.value = lForm.sParaFontFamily.value;
	lForm.hParaFontWeight.value = lForm.sParaFontWeight.value;
	lForm.hParaFontSize.value = lForm.tbParaFontSize.value;
}

function TitlePropOnClick(piElementID) {
	var lForm = document.forms("frmUpdatePara" + piElementID);
	var lDiv = document.all("dParaTitleProp" + piElementID);
	var lExpanded = lForm.hExpanded.value;
	
	if (lExpanded == "false") {	
		lDiv.innerHTML="<TABLE align='center' width=100% border=1 class='tdbglight' STYLE='BORDER-COLLAPSE: collapse'>" +
				   "<TR><TD width=30%><B>Text</B> Align</TD><TD width=100><Select name='sTextAlign' onchange='ParaTitlePropertyApply(" + piElementID + ");'>" + gHAlignSelectStr + "</Select></TD></TR>" +
				   "<TR><TD width=30%><B>Text</B> Color</TD><TD width=100><Select name='sTextColor' onchange='ParaTitlePropertyApply(" + piElementID + ");'>" + gColorsSelectStr + "</Select></TD></TR>" +
				   "<TR><TD width=30%><B>Text</B> Decoration</TD><TD width=100><Select name='sTextDeco' onchange='ParaTitlePropertyApply(" + piElementID + ");'>" + gTDecorationSelectStr + "</Select></TD></TR>" + 				   				   				   				    				   				   				   
				   "<TR><TD width=30%><B>Background</B> Color</B></TD><TD width=100><Select name='sBGColor' onchange='ParaTitlePropertyApply(" + piElementID + ");'>" + gColorsSelectStr + "</Select></TD></TR>" + 
				   "<TR><TD width=30%><B>Background</B> Image</TD><TD width=100><Input type=file name='fBGImage' onchange='ParaTitlePropertyApply(" + piElementID + ");'></TD></TR>" + 
				   "<TR><TD width=30%><B>Border</B> Width</TD><TD width=100><Input size=5 type=text name='tbBorderWidth'></TD></TR>" + 				   
				   "<TR><TD width=30%><B>Border</B> Color</TD><TD width=100><Select name='sBorderColor' onchange='ParaTitlePropertyApply(" + piElementID + ");'>" + gColorsSelectStr + "</Select></TD></TR>" +
				   "<TR><TD width=30%><B>Border</B> Style</TD><TD width=100><Select name='sBorderStyle' onchange='ParaTitlePropertyApply(" + piElementID + ");'>" + gBorderStyleSelectStr + "</Select></TD></TR>" +
				   "<TR><TD width=30%><B>Font</B> Family</TD><TD width=100><Select name='sFontFamily' onchange='ParaTitlePropertyApply(" + piElementID + ");'>" + gFontFamilySelectStr + "</Select></TD></TR>" +
				   "<TR><TD width=30%><B>Font</B> Size</TD><TD width=100><Input size=5 type=text name='tbFontSize' onchange='ParaTitlePropertyApply(" + piElementID + ");'></TD></TR>" +
				   "<TR><TD width=30%><B>Font</B> Weight</TD><TD width=100><Select name='sFontWeight' onchange='ParaTitlePropertyApply(" + piElementID + ");'>" + gFontWeightSelectStr + "</Select></TD></TR>" +				   
				   "</TABLE>";

		lForm.sTextAlign.value = lForm.hTextAlign.value;
		lForm.sTextColor.value = lForm.hTextColor.value;
		lForm.sTextDeco.value = lForm.hTextDeco.value;
		lForm.sBGColor.value = lForm.hBGColor.value;
		lForm.fBGImage.value = lForm.hBGImage.value;
		lForm.tbBorderWidth.value = lForm.hBorderWidth.value;
		lForm.sBorderColor.value = lForm.hBorderColor.value;
		lForm.sBorderStyle.value = lForm.hBorderStyle.value;
		lForm.sFontFamily.value = lForm.hFontFamily.value;
		lForm.sFontWeight.value = lForm.hFontWeight.value;
		lForm.tbFontSize.value = lForm.hFontSize.value;

		lForm.hExpanded.value = "true";
	}
	else {
		lDiv.innerHTML="";
		lForm.hExpanded.value = "false";
	}
}

function ParaPropOnClick(piElementID) {
	var lForm = document.forms("frmUpdatePara" + piElementID);
	var lDiv = document.all("dParaProp" + piElementID);
	var lExpanded = lForm.hParaExpanded.value;
	
	if (lExpanded == "false") {	
		lDiv.innerHTML="<TABLE align='center' width=100% border=1 class='tdbglight' STYLE='BORDER-COLLAPSE: collapse'>" +
				   "<TR><TD width=30%><B>Text</B> Align</TD><TD width=100><Select name='sParaTextAlign' onchange='ParaPropertyApply(" + piElementID + ");'>" + gHAlignSelectStr + "</Select></TD></TR>" +
				   "<TR><TD width=30%><B>Text</B> Color</TD><TD width=100><Select name='sParaTextColor' onchange='ParaPropertyApply(" + piElementID + ");'>" + gColorsSelectStr + "</Select></TD></TR>" +
				   "<TR><TD width=30%><B>Text</B> Decoration</TD><TD width=100><Select name='sParaTextDeco' onchange='ParaPropertyApply(" + piElementID + ");'>" + gTDecorationSelectStr + "</Select></TD></TR>" + 
				   "<TR><TD width=30%><B>Background</B> Color</B></TD><TD width=100><Select name='sParaBGColor' onchange='ParaPropertyApply(" + piElementID + ");'>" + gColorsSelectStr + "</Select></TD></TR>" + 
				   "<TR><TD width=30%><B>Background</B> Image</TD><TD width=100><Input type=file name='fParaBGImage' onchange='ParaPropertyApply(" + piElementID + ");'></TD></TR>" + 
				   "<TR><TD width=30%><B>Border</B> Width</TD><TD width=100><Input size=5 type=text name='tbParaBorderWidth'></TD></TR>" + 				   
				   "<TR><TD width=30%><B>Border</B> Color</TD><TD width=100><Select name='sParaBorderColor' onchange='ParaPropertyApply(" + piElementID + ");'>" + gColorsSelectStr + "</Select></TD></TR>" +
				   "<TR><TD width=30%><B>Border</B> Style</TD><TD width=100><Select name='sParaBorderStyle' onchange='ParaPropertyApply(" + piElementID + ");'>" + gBorderStyleSelectStr + "</Select></TD></TR>" +
				   "<TR><TD width=30%><B>Font</B> Family</TD><TD width=100><Select name='sParaFontFamily' onchange='ParaPropertyApply(" + piElementID + ");'>" + gFontFamilySelectStr + "</Select></TD></TR>" +
				   "<TR><TD width=30%><B>Font</B> Size</TD><TD width=100><Input size=5 type=text name='tbParaFontSize' onchange='ParaPropertyApply(" + piElementID + ");'></TD></TR>" +
				   "<TR><TD width=30%><B>Font</B> Weight</TD><TD width=100><Select name='sParaFontWeight' onchange='ParaPropertyApply(" + piElementID + ");'>" + gFontWeightSelectStr + "</Select></TD></TR>" +				   
				   "</TABLE>";

		lForm.sParaTextAlign.value = lForm.hParaTextAlign.value;
		lForm.sParaTextColor.value = lForm.hParaTextColor.value;
		lForm.sParaTextDeco.value = lForm.hParaTextDeco.value;
		lForm.sParaBGColor.value = lForm.hParaBGColor.value;
		lForm.fParaBGImage.value = lForm.hParaBGImage.value;
		lForm.tbParaBorderWidth.value = lForm.hParaBorderWidth.value;
		lForm.sParaBorderColor.value = lForm.hParaBorderColor.value;
		lForm.sParaBorderStyle.value = lForm.hParaBorderStyle.value;
		lForm.sParaFontFamily.value = lForm.hParaFontFamily.value;
		lForm.sParaFontWeight.value = lForm.hParaFontWeight.value;
		lForm.tbParaFontSize.value = lForm.hParaFontSize.value;

		lForm.hParaExpanded.value = "true";
	}
	else {
		lDiv.innerHTML="";
		lForm.hParaExpanded.value = "false";
	}
}

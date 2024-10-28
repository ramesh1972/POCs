<HTML>
<HEAD>
<META NAME="GENERATOR" Content="Microsoft Visual Studio 6.0">
<% ' Colors
	Dim gColorsSelectStr
	
	gColorsSelectStr = gColorsSelectStr & "<Option Value='red'>red</Option>"
	gColorsSelectStr = gColorsSelectStr & "<Option Value='green'>green</Option>"
	gColorsSelectStr = gColorsSelectStr & "<Option Value='blue'>blue</Option>"
	gColorsSelectStr = gColorsSelectStr & "<Option Value='yellow'>yellow</Option>"
	gColorsSelectStr = gColorsSelectStr & "<Option Value='purple'>purple</Option>"
	gColorsSelectStr = gColorsSelectStr & "<Option Value='cyan'>cyan</Option>"
	gColorsSelectStr = gColorsSelectStr & "<Option Value='gray'>gray</Option>"
	gColorsSelectStr = gColorsSelectStr & "<Option Value='black'>black</Option>"
	gColorsSelectStr = gColorsSelectStr & "<Option Value='white'>white</Option>"
	gColorsSelectStr = gColorsSelectStr & "<Option Value='lightred'>lightred</Option>"
	gColorsSelectStr = gColorsSelectStr & "<Option Value='lightgreen'>lightgreen</Option>"
	gColorsSelectStr = gColorsSelectStr & "<Option Value='lightblue'>lightblue</Option>"
	gColorsSelectStr = gColorsSelectStr & "<Option Value='lightyellow'>lightyellow</Option>"
	gColorsSelectStr = gColorsSelectStr & "<Option Value='lightpurple'>lightpurple</Option>"
	gColorsSelectStr = gColorsSelectStr & "<Option Value='lightcyan'>lightcyan</Option>"
	gColorsSelectStr = gColorsSelectStr & "<Option Value='lightgray'>lightgray</Option>"
	gColorsSelectStr = gColorsSelectStr & "<Option Value='lightblack'>lightblack</Option>"
	gColorsSelectStr = gColorsSelectStr & "<Option Value='darkred'>darkred</Option>"
	gColorsSelectStr = gColorsSelectStr & "<Option Value='darkgreen'>darkgreen</Option>"
	gColorsSelectStr = gColorsSelectStr & "<Option Value='darkblue'>darkblue</Option>"
	gColorsSelectStr = gColorsSelectStr & "<Option Value='darkyellow'>darkyellow</Option>"
	gColorsSelectStr = gColorsSelectStr & "<Option Value='darkpurple'>darkpurple</Option>"
	gColorsSelectStr = gColorsSelectStr & "<Option Value='darkcyan'>darkcyan</Option>"
	gColorsSelectStr = gColorsSelectStr & "<Option Value='darkgray'>darkgray</Option>"
%>

<% ' Alignments
	Dim gHAlignSelectStr
	
	gHAlignSelectStr = gHAlignSelectStr & "<Option Value='left'>left</Option>"
	gHAlignSelectStr = gHAlignSelectStr & "<Option Value='center'>center</Option>"
	gHAlignSelectStr = gHAlignSelectStr & "<Option Value='right'>right</Option>"
%>

<% ' Text Decorations
	Dim gTDecorationSelectStr
	
	gTDecorationSelectStr = gTDecorationSelectStr & "<Option Value='none'>none</Option>"
	gTDecorationSelectStr = gTDecorationSelectStr & "<Option Value='underline'>underline</Option>"
	gTDecorationSelectStr = gTDecorationSelectStr & "<Option Value='overline'>overline</Option>"
	gTDecorationSelectStr = gTDecorationSelectStr & "<Option Value='line-through'>line-through</Option>"
	gTDecorationSelectStr = gTDecorationSelectStr & "<Option Value='blink'>blink</Option>"
%>

<% ' Border Styles
	Dim gBorderStyleSelectStr
	
	gBorderStyleSelectStr = gBorderStyleSelectStr & "<Option Value='none'>none</Option>"
	gBorderStyleSelectStr = gBorderStyleSelectStr & "<Option Value='dashed'>dashed</Option>"
	gBorderStyleSelectStr = gBorderStyleSelectStr & "<Option Value='solid'>solid</Option>"
	gBorderStyleSelectStr = gBorderStyleSelectStr & "<Option Value='double'>double</Option>"
	gBorderStyleSelectStr = gBorderStyleSelectStr & "<Option Value='groove'>groove</Option>"
	gBorderStyleSelectStr = gBorderStyleSelectStr & "<Option Value='ridge'>ridge</Option>"
	gBorderStyleSelectStr = gBorderStyleSelectStr & "<Option Value='inset'>inset</Option>"
	gBorderStyleSelectStr = gBorderStyleSelectStr & "<Option Value='window-inset'>window-inset</Option>"
	gBorderStyleSelectStr = gBorderStyleSelectStr & "<Option Value='outset'>outset</Option>"
%>

<%
	' Font Weight
	Dim gFontFamilySelectStr
	
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='Arial'>Arial</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='Arial Black'>Arial Black</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='Arial Narrow'>Arial Narrow</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='Arial Unicode MS'>Arial Unicode MS</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='Batang'>Batang</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='Book Antiqua'>Book Antiqua</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='Bookman Old Style'>Bookman Old Style</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='Century'>Century</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='Century Gothic'>Century Gothic</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='Comic Sans MS'>Comic Sans MS</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='Courier'>Courier</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='Courier New'>Courier New</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='CPI Symbol'>CPI Symbol</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='Fixedsys'>Fixedsys</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='Garamond'>Garamond</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='Haettenschweiler'>Haettenschweiler</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='Impact'>Impact</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='Lucida Console'>Lucida Console</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='Lucida Sans Unicode'>Lucida Sans Unicode</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='Map Symbols'>Map Symbols</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='Marlett'>Marlett</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='Modern'>Modern</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='Monotype Corsiva'>Monotype Corsiva</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='MS Mincho'>MS Mincho</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='MS Outlook'>MS Outlook</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='MS Sans Serif'>MS Sans Serif</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='MS Serif'>MS Serif</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='MT Extra'>MT Extra</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='PMingLiU'>PMingLiU</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='Roman'>Roman</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='Script'>Script</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='SimSun'>SimSun</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='Small Fonts'>Small Fonts</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='System'>System</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='Tahoma'>Tahoma</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='Terminal'>Terminal</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='Times New Roman'>Times New Roman</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='Trebuchet MS'>Arial</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='Verdana'>Verdana</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='Webdings'>Webdings</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='Wingdings'>Wingdings</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='Wingdings 2'>Wingdings 2</Option>"
	gFontFamilySelectStr = gFontFamilySelectStr & "<Option Value='Wingdings 3'>Wingdings 3</Option>"
%>

<% ' Font Weight
	Dim gFontWeightSelectStr
	
	gFontWeightSelectStr = gFontWeightSelectStr & "<Option Value='normal'>normal</Option>"
	gFontWeightSelectStr = gFontWeightSelectStr & "<Option Value='bold'>bold</Option>"
	gFontWeightSelectStr = gFontWeightSelectStr & "<Option Value='bolder'>bolder</Option>"
	gFontWeightSelectStr = gFontWeightSelectStr & "<Option Value='lighter'>lighter</Option>"
	gFontWeightSelectStr = gFontWeightSelectStr & "<Option Value='100'>100</Option>"
	gFontWeightSelectStr = gFontWeightSelectStr & "<Option Value='200'>200</Option>"
	gFontWeightSelectStr = gFontWeightSelectStr & "<Option Value='300'>300</Option>"
	gFontWeightSelectStr = gFontWeightSelectStr & "<Option Value='400'>400</Option>"
	gFontWeightSelectStr = gFontWeightSelectStr & "<Option Value='500'>500</Option>"
	gFontWeightSelectStr = gFontWeightSelectStr & "<Option Value='600'>600</Option>"
	gFontWeightSelectStr = gFontWeightSelectStr & "<Option Value='700'>700</Option>"
	gFontWeightSelectStr = gFontWeightSelectStr & "<Option Value='800'>800</Option>"
	gFontWeightSelectStr = gFontWeightSelectStr & "<Option Value='900'>900</Option>"
%>
</HEAD>
</HTML>

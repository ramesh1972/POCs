<HTML>
<style>
A {text-decoration:none;}
</style>

<HEAD>
<%
	Dim lPH 
	Dim lProject
	Dim lTree
	Dim lFile
	
	lProject = Request.QueryString("MSProject")
	Set lPH = Server.CreateObject("MSProjectHTML.MSProjHTML")
	
	lFile = "c:\inetpub\wwwroot\msproj\uploadfiles\" & lProject & ".mpp"
	
	Call lPH.SetProjFile(lFile) 
	lTree = lPH.GetTaskTree
%>

<script LANGUAGE="JavaScript">
var total=1;
var db = new Array();

// create the tree
<%=lTree%>

// Get current cookie setting
var current=getCurrState()

// tree functions
function getCurrState() {
  var label = "currState="
  var labelLen = label.length
  var cLen = document.cookie.length
  var i = 0
  while (i < cLen) {
    var j = i + labelLen
    if (document.cookie.substring(i,j) == label) {
      var cEnd = document.cookie.indexOf(";",j)
      if (cEnd == -1) { cEnd = document.cookie.length }
      return unescape(document.cookie.substring(j,cEnd))
    }
    i++
  }
  return ""
}

// Add an entry to the database
function dbAdd(mother,display,URL,indent,top,newitem) {
  db[total] = new Object;
  db[total].mother = mother
  db[total].display = display
  db[total].URL = URL
  db[total].indent = indent
  db[total].top = top
  db[total].newitem = newitem
  total++
  }

// Record current settings in cookie
function setCurrState(setting) {
  var expire = new Date();
  expire.setTime(expire.getTime() + ( 7*24*60*60*1000 ) ); // expire in 1 week
  document.cookie = "currState=" + escape(setting) + "; expires=" + expire.toGMTString();
  }

// toggles an outline mother entry, storing new value in the cookie
function toggle(n) {
  if (n != 0) {
    var newString = ""
    var expanded = current.substring(n-1,n) // of clicked item
    newString += current.substring(0,n-1)
    newString += expanded ^ 1 // Bitwise XOR clicked item
    newString += current.substring(n,current.length)
    setCurrState(newString) // write new state back to cookie
  }
}

// returns padded spaces (in mulTIPles of 2) for indenting
function pad(n) {
  var result = ""
  for (var i = 1; i <= n; i++) { result += "&nbsp;&nbsp;&nbsp;&nbsp;" }
  return result
}

// Expand everything
function explode() {
  current = "";
  initState="";
  for (var i = 1; i < db.length; i++) { 
    initState += "1"
    current += "1"
    }
  setCurrState(initState);
  history.go(0);
  }

// Collapse everything
function contract() {
  current = "";
  initState="";
  for (var i = 1; i < db.length; i++) { 
    initState += "0"
    current += "0"
    }
  setCurrState(initState);
  history.go(0);
  }
</script>
</HEAD>

<BODY bgcolor=#ffffff LINK="#006666" VLINK="#004444" nowrap>
<script LANGUAGE="JavaScript">
// Set the initial state if no current state or length changed
if (current == "" || current.length != (db.length-1)) {
  current = ""
  initState = ""
  for (i = 1; i < db.length; i++) { 
    initState += "0"
    current += "0"
    }
  setCurrState(initState)
  }
var prevIndentDisplayed = 0
var showMyDaughter = 0

var Outline=""
// cycle through each entry in the outline array
for (var i = 1; i < db.length; i++) {
  var currIndent = db[i].indent           // get the indent level
  var expanded = current.substring(i-1,i) // current state
  var top = db[i].top
  if (top == "") { top="content" }
  // display entry only if it meets one of three criteria
  if ((currIndent == 0 || currIndent <= prevIndentDisplayed || (showMyDaughter == 1 && (currIndent - prevIndentDisplayed == 1)))) {
  Outline += pad(currIndent)

  // Insert the appropriate GIF and HREF
  newitem = "";
  if (db[i].newitem) { newitem="_new"; }
  if (!(db[i].mother)) {
    Outline += "<IMG SRC=\"images/blank.gif\" WIDTH=16 HEIGHT=16 BORDER=0><IMG SRC=\"images/document" + newitem + ".gif\" WIDTH=16 HEIGHT=16 BORDER=0>"
    } 
  else { 
      if (current.substring(i-1,i) == 1) {
        Outline += "<A HREF=\"javascript:history.go(0)\" onMouseOver=\"window.parent.status=\'Click to collapse\';return true;\" onClick=\"toggle(" + i + ")\">";
        Outline += "<IMG SRC=\"images/minus.gif\" WIDTH=16 HEIGHT=16 BORDER=0><IMG SRC=\"images/open" + newitem + ".gif\" WIDTH=16 HEIGHT=16 BORDER=0>"
        Outline += "</A>"
        }
      else {
	    Outline += "<A HREF=\"javascript:history.go(0)\" onMouseOver=\"window.parent.status=\'Click to expand\';return true;\" onClick=\"toggle(" + i + ")\">"
        Outline += "<IMG SRC=\"images/plus.gif\" WIDTH=16 HEIGHT=16 BORDER=0><IMG SRC=\"images/closed" + newitem + ".gif\" WIDTH=16 HEIGHT=16 BORDER=0>"
        Outline += "</A>"
        }
      }
    Outline += "&nbsp;";
     
    if (db[i].URL == "" || db[i].URL == null) {
      Outline += " " + db[i].display      // no link, just a listed item  
      }
    else {
      Outline += " <A HREF=\"" + db[i].URL + "\" TARGET=\"fNodeBody" + "\">" + db[i].display + "</A>"
      }
	// Bold if at level 0
    if (currIndent == 0) { 
      Outline = "<B>" + Outline + "</B>"
      }
    Outline += "<BR>"
    prevIndentDisplayed = currIndent
    showMyDaughter = expanded
    // if (i == 1) { Outline = ""}
    if (db.length > 25) {
      document.write(Outline)
      Outline = ""
      }
    }
  }
document.write(Outline)
</script>
</BODY>
</HTML>
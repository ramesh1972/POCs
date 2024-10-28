function URLescapeeee(arg) {
var urlParameter = escape(arg);
  if (screen) {
	var leftPos = (screen.availWidth - 320)/2;
	var newWin = window.open('/exit_popup.jsp?url=' + urlParameter + ' + ','exitPage','');
	 } else {
		var newWin = window.open('/exit_popup.jsp?url=' + urlParameter + ' + ','exitPage','');
		}
}

function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}

function URLescape(arg) {

var urlParameter = escape(arg);
var browser=navigator.appName;
var windowWidth="500";
var windowHeight="350";
var windowTop="50";
var leftPos = (screen.availWidth/2) - (windowWidth/2);

if (browser=="Netscape")
{
    windowCoord="screenX=" + leftPos + ",screenY=" + windowTop;
}
else
{
    windowCoord="left=" + leftPos + ",top=" + windowTop;
}

  if (screen) 
    {
	    
        
        if (((arg.indexOf("anemiapro") >=0) || (arg.indexOf("procrit") >=0) || (arg.indexOf("orthobiotech") >=0)))
        {
        var newWin = window.open('/exit_popup.jsp?url=' + urlParameter + ' + ','exitPage','');
        }
        else
        {
            var vURL = "/webcommon/outlink_disclaimer.jsp?redirect=" + escape(arg);
            window.open(vURL, 'interstitial', 'scrollbars=yes,resizable=no,menubar=no,status=no,toolbar=no,width=' + windowWidth + ',height=' + windowHeight + ',' + windowCoord);
        }   
     } 
     else 
     {
        var newWin = window.open('/exit_popup.jsp?url=' + urlParameter + ' + ','exitPage','');
     }
}



function interstitialPopup(pInterstitial, pURL) { 
    var vURL = "/webcommon/" + pInterstitial + "?redirect=" + escape(pURL);
    window.open(vURL, 'interstitial', 'scrollbars=yes,resizable=no,menubar=no,status=no,toolbar=no,width=800,height=400');
}

function getAdobe(pURL) 
{ 
    var vURL = "/webcommon/pdf.jsp?link=" + escape(pURL);
    window.open(vURL, 'pdf', 'scrollbars=yes,resizable=no,menubar=no,status=no,toolbar=no,width=800,height=400');
}


//Outlink Pop Up disclaimer
function outLinkPopUp(outlinkURL)
{

//	var newWindow = window.open('/includes/outlink_disclaimer.jsp?outlink='+outlinkURL, "outlink", "width=350,height=250,toolbar=0,screenX=000,screenY=000,top=000,left=000,location=0,directories=0,status=0,menuBar=0,scrollBars=0,resizable=0");
//	newWindow.focus();
}

//Outlink Disclaimer Function
function ConfirmOutLink(outLinkURL)
{
	window.open(outLinkURL);
	self.close()
}

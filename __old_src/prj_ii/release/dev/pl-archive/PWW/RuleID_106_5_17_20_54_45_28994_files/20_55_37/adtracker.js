/******************************************************************************
Name: Google Analytics Ad Tracking Javascript
Author: Jerry Ferguson
Email: tech@xooni.com
Website: http://www.xooni.com

Instructions: Save this file as adtracker.js and place 
<script src="/adtracker.js" type="text/javascript"></script>
at the end of your page code (after the last AdSense).
******************************************************************************/

/******************************************************
SECTION 1: onload add-event scripting, for all browsers
*******************************************************/

if(typeof window.addEventListener != 'undefined')
{
	//.. gecko, safari, konqueror and standard
	window.addEventListener('load', ad_init, false);
}
else if(typeof document.addEventListener != 'undefined')
{
	//.. opera 7
	document.addEventListener('load', ad_init, false);
}
else if(typeof window.attachEvent != 'undefined')
{
	//.. win/ie
	window.attachEvent('onload', ad_init);
}
//** remove this condition to degrade older browsers
else
{
	//.. mac/ie5 and anything else that gets this far
	//if there's an existing onload function
	if(typeof window.onload == 'function')
	{
		//store it
		var existing = onload;
		//add new onload handler
		window.onload = function()
		{
			//call existing onload function
			existing();
			//call adsense_init onload function
			ad_init();
		};
	 }
	 else
	 {
	 	//setup onload function
	 	window.onload = ad_init;
	 }
}

/********************************************************
SECTION 2: Add the initialization code to track ad clicks.
We basically look for a substring that uniquely identifies 
the ad (in the iframe's 'src' attribute or the 
anchor tag's 'href' attribute). Then we call the corresponding
'advertisername_click' function.
*********************************************************/

function ad_init () {
	//deal with ads in iframes
	if (document.all){  //ie specific iframe handling

		var el = document.getElementsByTagName("iframe");
		for(var i = 0; i < el.length; i++) {
			//el[i].onfocus = ad_click;
			
			if(el[i].src.indexOf('googlesyndication.com') > -1) {
				el[i].onfocus = as_click;
			}
			
		}//end for loop
	}//end if document.all
	else{   //call the mozilla/firefox code
		window.addEventListener('beforeunload', doPageExit, false);
		window.addEventListener('mousemove', getMouse, true);
	}
	
}//end ad_init function

/****************************************
SECTION 3: Set up the urchinTracker call functions
By default, these functions construct the url so that all virtual pageviews follow the pattern:
/ads/referrer_path/advertiser_name/
*****************************************/

function as_click() {
	urchinAdTracker("adsense"); //this defines what your retailer path in GA will be
}

function urchinAdTracker(retailer){
	var utString = "/ads/"; //this defines the 'directory structure' of the virtual page view
	
	//check to make sure that the variables are set
	if(retailer != null && retailer != "undefined" && retailer != ""){//if retailer is set, add it 
		utString += "" + retailer + "/";
	}
	//call urchinTracker
	urchinTracker("" + utString);
}

/**********************************************
SECTION 4: Mozilla/Firefox Iframe Handling
Mozilla doesn't allow access to 3rd party iframes, 
so we use an x-y coordinate system to determine if
the user clicked somewhere within an iframe. This is
admittedly not 100% accurate.
***********************************************/

var px;
var py;

function getMouse(e) {
	px=e.pageX;
	py=e.clientY;
}

function findY(obj) {
	var y = 0;
	while (obj) {
		y += obj.offsetTop;
		obj = obj.offsetParent;
	}
	return(y);
}

function findX(obj) {
	var x = 0;
	while (obj) {
		x += obj.offsetLeft;
		obj = obj.offsetParent;
	}
	return(x);
}

function doPageExit(e) {
	//process iframes
	var utCall;
	var ad = document.getElementsByTagName("iframe");
	if(ad.length > 0){
		for(i=0; i < ad.length; i++){
			var adLeft = findX(ad[i]);
			var adTop = findY(ad[i]);
			//alert("adLeft: "+ adLeft +"\nadTop: "+ adTop);
			var inFrameX = ((px > (parseInt(adLeft) - 10)) && (px < (parseInt(adLeft) + parseInt(ad[i].width) + 10)));
			var inFrameY = ((py > (parseInt(adTop) - 10)) && (py < (parseInt(adTop) + parseInt(ad[i].height) + 10)));
			if (inFrameY && inFrameX) {
				utCall = "adsense";
				break;
			}
		}
		if(utCall){
			urchinAdTracker(utCall);
		}
	}//end if ad length > zero
	
}//end doPageExit function
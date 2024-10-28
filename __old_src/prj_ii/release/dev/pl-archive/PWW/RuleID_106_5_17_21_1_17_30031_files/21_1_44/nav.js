<!--
     skinDir = "/_skin/200604/";
     homeon = new Image();
     homeon.src = skinDir + "img/btn_home_on.gif";
	 domainon = new Image();
     domainon.src = skinDir + "img/btn_domains_on.gif";
	 hostingon = new Image();
     hostingon.src = skinDir + "img/btn_hosting_on.gif";
	 signupon = new Image();
     signupon.src = skinDir + "img/btn_signup_on.gif";
	 affiliateon = new Image();
     affiliateon.src = skinDir + "img/btn_affiliate_on.gif";
	 supporton = new Image();
     supporton.src = skinDir + "img/btn_support_on.gif";
	 contacton = new Image();
     contacton.src = skinDir + "img/btn_contact_on.gif";
		
     homeoff = new Image();
     homeoff.src = skinDir + "img/btn_home.gif";
     domainoff = new Image();
     domainoff.src = skinDir + "img/btn_domains.gif";
	 hostingoff = new Image();
     hostingoff.src = skinDir + "img/btn_hosting.gif";
	 signupoff = new Image();
     signupoff.src = skinDir + "img/btn_signup.gif";
	 affiliateoff = new Image();
     affiliateoff.src = skinDir + "img/btn_affiliate.gif";
	 supportoff = new Image();
     supportoff.src = skinDir + "img/btn_support.gif";
	 contactoff = new Image();
     contactoff.src = skinDir + "img/btn_contact.gif";
       
function Button_Active (hName) {
     imgOn = eval(hName + "on.src");
     document [hName].src = imgOn;
}
function Button_InActive (hName) {
     imgOff = eval(hName + "off.src");
     document [hName].src = imgOff;
}
// -->
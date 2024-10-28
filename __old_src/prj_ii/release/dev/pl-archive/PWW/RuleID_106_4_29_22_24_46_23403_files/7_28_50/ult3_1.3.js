var CTRL_C            = '\x03';
var CTRL_D            = '\x04';
var YAHOO_BASE64_STR  =  "ABCDEFGHIJKLMNOP" +
                         "QRSTUVWXYZabcdef" +
                         "ghijklmnopqrstuv" +
                         "wxyz0123456789._-";
var ULT_KEY='',ULT_KEY_PPOUND='',s_pp='',decoded=0,ln='',c_pp=new Object(),c_p=new Object(),pp='',c_pp_done=0;
function yahoo_encode64(input) {
 var output = '';
 var chr1, chr2, chr3 = '';
 var enc1, enc2, enc3, enc4 = '';
 var i = 0;
 do {
   chr1 = input.charCodeAt(i++);
   chr2 = input.charCodeAt(i++);
   chr3 = input.charCodeAt(i++);

   enc1 = chr1 >> 2;
   if (isNaN(chr2)) {
      enc2 = ((chr1 & 3) << 4);
      enc3 = enc4 = 64;
   }
   else {
      enc2 = ((chr1 & 3) << 4) | (chr2>> 4);
   }
   if (isNaN(chr3)) {
      enc3 = ((chr2 & 15) << 2);
      enc4 = 64;
   }
   else {
      enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
      enc4 = chr3 & 63;
   }
   output = output +
   YAHOO_BASE64_STR.charAt(enc1) +
   YAHOO_BASE64_STR.charAt(enc2) +
   YAHOO_BASE64_STR.charAt(enc3) +
   YAHOO_BASE64_STR.charAt(enc4);

   chr1 = chr2 = chr3 = '';
   enc1 = enc2 = enc3 = enc4 = '';
 } while (i < input.length);

 return output;
}

function yahoo_decode64(s){
 var r=new Array();
 var o='';
 var c1,c2,c3,e1,e2,e3,e4='';
 var i=0;
 var k=YAHOO_BASE64_STR;
 if(s.length==0 || s.length%4!=0) return o;
 do {
   e1=k.indexOf(s.charAt(i++));
   e2=k.indexOf(s.charAt(i++));
   e3=k.indexOf(s.charAt(i++));
   e4=k.indexOf(s.charAt(i++));

   c1=(e1<<2)|(e2>>4);
   c2=((e2&15)<<4)|(e3>>2);
   c3=((e3&3)<<6)|e4;

   o=o+String.fromCharCode(c1);

   if(e3!=64){
    o=o+String.fromCharCode(c2);
   }

   if(e4!=64){
    o=o+String.fromCharCode(c3);
   }
 }while(i<s.length);
 return o;
}

function yahoo_has_ctrl_char(s,type,key) {
 for (i = 0; i < s.length; i++) {
   if (type=='val' && key=='page' && s.charCodeAt(i)==0x02) continue;
   if( s.charCodeAt(i) < 0x20 ) {
     return true;
   }
 }
 return false;
}

function flatten_hash(p,str1,str2,type){
 var str='';
 if (str1!='' && str2!='') {str=str1+CTRL_D+str2;if (str.length<1||str.length>825) {return str1;}}
 else if (str1!='') {str=str1;  if (str.length<1||str.length>825) {return str1;}}
 else if (str2!='') {str=str2;  if (str.length<1||str.length>825) {return str2;}}
 var has_elem=0;
 if (p) {
   for (var k in p) {
     has_elem=1;
     break;
   }
 }
 if (has_elem==0) return str;
 p['_r'] = '3';
 var ks = [];
 var i = 0;
 for (var k in p) {
   var v = p[k];
   if (typeof(v) == 'undefined') { v = p[k] = ''; }
   if (k.length < 1) { return str; }
   if (k.length > 8) { return str; }
   if (k.indexOf(' ') != -1) { return str; }
   if (yahoo_has_ctrl_char(k,'key',type) || yahoo_has_ctrl_char(v,'val',type)) { return str; }
   ks[i++] = k;
 }
 ks = ks.sort();
 var f = [];
 for (var i = 0; i < ks.length; i++) {
    f[i] = ks[i] + CTRL_C + p[ks[i]];
 }
 f = f.join(CTRL_D);
 if (str!=''){
  f=str+CTRL_D+f;
 }
 if (f.length < 1 || f.length > 985) { return str; }
 return f;
}

function app_c_pp(key,value){
 c_pp[key]=value;
 c_pp_done=0;
}

function create_click(){
 var fh='';
 if(ln!='' && (fh=flatten_hash(c_p,'','','click'))!=''){
  return yahoo_encode64(fh);
 }
 return fh;
}
function create_pp(){
 if (decoded==0&&ULT_KEY!=''){
  pp=yahoo_decode64(ULT_KEY);
  decoded=1;
 }

 if (!c_pp_done) { 
  pp=flatten_hash(c_pp,pp,'','page');
  c_pp_done=1;
 }

 var ppound=ULT_KEY_PPOUND.split(':');
 var p_str='';
 for(var i=0;i<ppound.length&&ULT_KEY_PPOUND!='';i++) {
   p_str=yahoo_decode64(ppound[i]);
   pp=flatten_hash('',pp,p_str,'page');
 }
 if (pp!='') return yahoo_encode64(pp);
 else return '';
}

function set_dcook(n,v,e){
 now=new Date;
 nt=now.getTime();
 nt=nt+e*1000;
 var nh=(new Date(nt)).toGMTString();
 var dm='.yahoo.com';
 document.cookie=n+'='+v+';expires='+nh+';path=/'+';domain='+dm;
}

function dcook_val() {
 var ylc='',ylg='',d_cook='';
 ylc=create_click();
 ylg=create_pp();
 if (ylc!=''){dcook='_ylc='+ylc;}
 if (ylg!=''&&dcook!=''){dcook=dcook+'&_ylg='+ylg;}
 return (dcook);
}

function set_ult_value(){
 if (ln!=''){
  var dcook=dcook_val();
  if(dcook!=''){set_dcook('D',dcook,10);}
 }
}

function ygAddEventListener(obj,eventName,func) {
 if (obj.attachEvent){ //ie browsers
  obj.attachEvent('on'+eventName, func);
 }
 else if (obj.addEventListener) { //w3c compliant browsers
   obj.addEventListener(eventName, func, false);
 }
}

function ygUltClient() {
 this.bindEvents = ygUltClientBindEvents;
 this.bindLinks = ygUltClientBindLinks;
 this.bindForms = ygUltClientBindForms;
 this.bindChildElements = ygUltClientBindChildElements;
 this.handleEvent = ygUltClientHandleEvent;
}

function ygUltClientBindChildElements(elem){
 this.bindLinks(elem.getElementsByTagName('a'));
 this.bindLinks(elem.getElementsByTagName('area'));
 this.bindForms(elem.getElementsByTagName('form'));
}

function ygUltClientBindLinks(links) {
 for (var i=0;i<links.length;i++) {
  var o = links[i];
  var oo = o.onclick;
  if (oo) {
    o.onclick = this.handleEvent;
    ygAddEventListener(o,'click',oo);
  }
  else {
    ygAddEventListener(o,'click',this.handleEvent);
  }
 }
}

function ygUltClientBindForms(forms) {
 for (var i=0;i<forms.length;i++) {
  var f = forms[i];
  var ff = f.onsubmit;
  if (ff) {
   f.onsubmit = this.handleEvent;
   ygAddEventListener(f,'submit',ff);
  }
  else {
   ygAddEventListener(f,'submit',this.handleEvent);
  }
 }
}

function ygUltClientBindEvents() {
 var d = document;
 this.bindLinks(d.links);
 this.bindForms(d.forms);
}

function ygUltClientHandleEvent(v) {
 var e = null;
 if (this.tagName)
 e = this;
 else if (v.srcElement)
 e = v.srcElement;
 var t = e.tagName.toLowerCase();
 while(t != 'a' && t != 'area' && t != 'form') {
  e = e.parentNode;
  t = e.tagName.toLowerCase();
 }

 var r = '';
 if (t == 'a' || t =='area') {
  r = e.href;
 }
 else if (t == 'form') {
  r=e.action;
 }
 var rstart=-1;
 if(r&&r!='undefined'){
  if ((rstart=r.indexOf('/r/'))!=-1 ||
    (rstart=r.indexOf('/s/'))!=-1 ||
    ((rstart=r.indexOf('r/'))!=-1 && rstart==0) ||
    ((rstart=r.indexOf('s/'))!=-1 && rstart==0)) {
   rend=r.indexOf('/*');
   ln=r.substring(((rstart==0)?rstart:rstart+1),((rend!=-1)?rend:r.length));
  }
 }
 if (ln!='') {
  c_p['fp']=ln;
  set_ult_value();
  var ult_c=' '+document.cookie+';';
  if (ult_c.indexOf(' D=_yl')<0) {
    var ult_nr='';
    if (rstart>=0){
      if (rstart==0)
        ult_nr=YLH+'/'+r;
      else
        ult_nr=r.substring(0,rstart+1)+YLH+'/'+r.substring(rstart+1,r.length);
      if (t == 'a' || t =='area') {
        e.href=ult_nr;  
      } 
      else if (t == 'form') {
        e.action=ult_nr;
      }
    }
  }
  ln='';
 }
 if (typeof(window.attachEvent)=="undefined" && typeof(window.addEventListener)!="undefined" && v.stopPropagation) {
	if (typeof(window.event)!="undefined" && t=="form")
	{
		if (e.name == "w") v.stopPropagation();
	}
	else
	{
		if (!((typeof(v.altKey)!= "undefined" && v.altKey) || (typeof(v.ctrlKey)!= "undefined" && v.ctrlKey) || (typeof(v.shiftKey)!= "undefined" && v.shiftKey)))
		{
			v.stopPropagation();
		}
		return false;
	}
 }
 if (typeof(window.attachEvent)!="undefined" && typeof(window.addEventListener)!="undefined" && v.stopPropagation) {
	return false;      
 }

}

function ygUltOnLoad() {
 if (!yguc) yguc = new ygUltClient();
 yguc.bindEvents();
}

var yguc = null;
if (window.attachEvent) { //ie
 window.attachEvent('onload', ygUltOnLoad);
}
else if (window.addEventListener) { //w3c compliant browsers
 window.addEventListener('load', ygUltOnLoad, false);
}
else { //all else
 var baseTags = document.getElementsByTagName("base")
 var base = baseTags.length==0?null:baseTags[baseTags.length-1];
 base.href = base.href + YLH;
}

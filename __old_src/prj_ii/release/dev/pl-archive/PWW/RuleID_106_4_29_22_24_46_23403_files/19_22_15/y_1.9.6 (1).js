var st=at=_ffs=0;
var _bv=lt='',ta=1,_ver=(typeof(ver)!='undefined')?ver:'';

d.onmousedown=md;
d.onkeydown=kd;

if(_ff){
	hm.href=((typeof(YLH)!='undefined')?YLH+'/':'')+'r/hf';
	if (typeof(app_c_pp)!='undefined') app_c_pp('hpf',shp?1:0);
	cc='&hpf='+(shp?1:0);
	hm.onclick=function(){
		gebid("ffhpcx").innerHTML='<div id=shpd class=shdw><div class=bd><div id=pnt></div><a title="Yahoo!" class=shp href="http://www.yahoo.com/"><strong>Yahoo!</strong></a><ol><li>Drag the "Y!" and drop it onto the "House" icon.</li><li>Select "Yes" from the pop up window.</li><li>Nothing, you&#39;re done.</li></ol><div class=hr></div><p>If this didn&#39;t work for you or you want more detailed instructions <a class=shps href=http://www.yahoo.com/r/hs>click here</a>.</p></div></div>';
		gebid("shpd").style.display="block";
		var bcn=new Image;bcn.src="r/hf";
		return false;
	}
}

var searchTabs=gebid("v").getElementsByTagName("a");
for(var i=0;i<searchTabs.length;i++){
	if(searchTabs[i].id!='vmore'){
		if(searchTabs[i].className=='h')var lt=searchTabs[i];
		if(!_sf){
			searchTabs[i].onfocus=function(){t(this);}
			searchTabs[i].onclick=function(){return false;}
		}else if(_sf){
			searchTabs[i].onclick=function(){t(this);return false;}
		}
	}
}

var ts=[];
ts[1]=new Array(2,'r/so','web');
ts[2]=new Array(2,'r/01','img');
ts[3]=new Array(2,'r/15','vid','new');
ts[4]=new Array(4,'r/1k','aud');
ts[5]=new Array(2,'r/0b','dir');
ts[6]=new Array(0,0,'lcl');
ts[7]=new Array(2,'r/0c','news');
ts[8]=new Array(3,'r/07','prod');

function t(o){
	if(_sf)gebid('mk').focus();
	d.sf1.action=o.href;
	ta=o.id.substring(1);
	d.sf1.fr.value='FP-tab-'+ts[ta][2]+'-t';
	lt.className=(lt.className.indexOf('new')>0)?'o new':'o';
	u(lt,1);
	o.className=(ts[ta][3])?'h a '+ts[ta][3]:'h a ';
	u(o,0);
	sl(ts[ta][0],ts[ta][1]);
	gebid('s').className='v'+ta;
	gebid('sb').innerHTML='Search '+((ta==1)?'the ':'')+o.innerHTML+':';
	d.sf1.cop.value=(o.innerHTML.indexOf('Shopping')>=0)?'mss':'';
	if(o.innerHTML.indexOf('Local')>=0){
		_bv=box.value;
		gebid('ip').innerHTML='<span id=bss class=f><label for=fp id=bs>Businesses & Services</label><input type=text name=p id=fp></span><span id=in class=f>in</span><span id=acs class=f><label for=csz id=ac>Address, City & State, or ZIP</label><input type=text name=csz id=csz></span>';
		gebid('csz').value=_lcs;
		box=gebid('fp');
		box.value=_bv;
	}else if(lt.innerHTML.indexOf('Local')>=0){
		_bv=box.value;
		_lcs=gebid('csz').value;
		gebid('ip').innerHTML='<input type=text name=p id=fp>';
		d.sf1.onsubmit=null;
		box=gebid('fp');
		box.value=_bv;
	}
	lt=o;
	st=1;
	if(!_ffs)setTimeout('box.focus()',1);
}
function u(o,z){
	var em=o.id.substring(1);
	var p=gebid('e'+em);
	if(p)p.style.backgroundColor=(z)?'#989898':'#fff';
	p=gebid('e'+(em-1));
	if(p)p.style.backgroundColor=(z)?'#989898':'#fff';
}
function md(e){
	e=e||window.event;
	var src=e.target||e.srcElement;
	if(e&&src&&src.id=="fp"||src.id=="sb")st=1;
	if(src.className.indexOf("pllist")<0&&src.className!="more"&&src.className!="plinkc"&&src.tagName!="scrollbar"&&_plink1&&_plink1._plinks.openPlink!=""){
		_plink1.ddclose(_plink1._plinks.openPlink);
	}else if(src.className.indexOf("shp")<0&&gebid("shpd")){
		gebid("shpd").style.display="none";
	}
}
function kd(e){
	e=e||window.event;
	var src=e.target||e.srcElement;
	var code=e.keyCode,id=src.id,gk,cnt,ctn=lt.id.substring(1);
	function mt(){
		var nextTab;
		if(!e.ctrlKey&&!e.altKey&&!_sf){
			if(e.shiftKey)nextTab=parseInt(ctn)-1;
			else nextTab=parseInt(ctn)+1;
			if(!nextTab){gebid('mk').focus();}
			else if(nextTab<searchTabs.length+1){t(gebid('v'+nextTab));}
		}
	}
	if(code==13){return;}
	else if((code==191||code==222)&&id!='fp'&&_ff){_ffs=1;gk=0;}
	else if((code<31||code>41)&&(code<16||code>18)&&code!=9&&code!=8){gk=1;}
	else{gk=0;}
	if(!_ffs&&(id=='fp'||id=='st')){
		if(code==9){
			if(box.value==''||(box.value!=''&&(at==1||e.shiftKey))){
				mt();
			}else if(id=='st'&&box.value!=''&&at==0){
				at=1;
				mt();
			}
		}else if(id=='fp'&&gk==0&&(box.value==''&&st==0)&&!e.shiftKey&&!e.ctrlKey&&!e.altKey){
			gebid('mk').focus();
			gebid('mk').blur();
		}else if(gk==1){
			at=0;
		}
	}else if((id=='mk2'&&box.value!=''&&e.shiftKey&&code==9)||(id=='m6'&&!e.shiftKey&&code==9)){
		gebid('mk').focus();
	}else if(!_ffs&&gk==1&&src.type!='text'&&!e.ctrlKey&&!e.altKey){
		box.value='';
		box.focus();
	}
}

var now,mon,day,now,hour,min,ampm,time,str,tz,end,beg;
now=new Date(sss*1000);
mon=new Array("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec");
day=new Array("Sun","Mon","Tue","Wed","Thu","Fri","Sat");
hour=now.getHours();
min=now.getMinutes();
ampm=(hour>=12)?"pm":"am";hour=(hour==0)?12:(hour>12)?hour-12:hour;
min=(min<10)?"0"+min:min;
tz="";
if(_ie5){
	str=now.toString();
	end=str.lastIndexOf(" ");
	beg=str.lastIndexOf(" ",end-1)+1;
	if(_ie5&&end-beg==3){tz=" "+str.charAt(beg)+"T";}
}
time=hour+":"+min+ampm+tz+", <nobr>"+day[now.getDay()]+" "+mon[now.getMonth()]+" "+now.getDate()+"</nobr>";
gebid('nw').innerHTML=time;

function zp(z){d.w.p.value=z;gw(d.w);}
function gw(f){
	if(_useult&&f.elements.length==0)f=d.forms['w'];
	procframe.location.replace("http://"+_bhostname+"/module/wtr_tr.php?.crumb="+crumb+"&p="+escape(f.p.value)+"&sv="+((d.w.sv.checked)?'on':'off')+(_ver?'&test='+_ver:''));
	return false;
}
var clo=0;
function cl(){
	var cld=gebid('lc');
	var ca=gebid('ca');
	if(clo){
		cld.innerHTML=cwi;
		ca.className='';
		clo=0;
	}else{
		cwi=cld.innerHTML;
		cld.innerHTML='<form name=w onsubmit="return gw(this)"><div id=wa></div><label for=zi class=np><span id=wg>Enter City or U.S. Zip Code</span></label><div><span id=z><input type=text id=zi name=p></span><span id=ws><input class=s2 type=submit value=Go></span></div><div id=wc class=wa><input type=checkbox id=we name=sv value=on checked> <label for=we>Save location on this page</label></div></form>';
		ca.className='r';
		clo=1;
		setTimeout('d.w.p.focus()',1);
	}
	if(_useult&&typeof(yguc)!='undefined'&&yguc.bindChildElements)yguc.bindChildElements(cld);
}
gebid("ca").onclick=function(){cl();return false;}

function plink(b,v){
	this.ddopen=this.arrow='';
	this.plinkNumber=b;
	this.currentPlink=gebid('m'+b);
	this.currentValue=v;
	this.dataUrl='http://'+_bhostname+'/module/plinksdd4.php?.crumb='+crumb+'&'+(_ver?'test='+_ver+'&':'');
	this.currentPlink.innerHTML+='<div id=b'+b+'></div>';
	this.plinkCx=gebid('b'+b);
	this.setPlink(v);
	this.buttonText=this.currentPlink.getElementsByTagName("em")[0];
	this.buttonLink=this.currentPlink.getElementsByTagName("a")[0];
	this.buttonImg=this.currentPlink.getElementsByTagName("img")[0];
	var obj=this,atag=this.currentPlink.childNodes[1];
	atag.onclick=function(e){obj.getData(e);return false;}
}
plink.prototype._plinks=new plinks();
plink.prototype.setPlink=function(v){	
	this.currentValue=v;
	_plinks['plink'+this.plinkNumber]=v;
}
plink.prototype.getData=function(e){
	if(!this.ddopen){
		if(this._plinks.openPlink!=''){this._plinks.openPlink.ddclose(this._plinks.openPlink);}
		e=window.event||e;
		this.arrow=e.srcElement||e.target;
		this.arrow.blur();
		var bcn=new Image,rnd=Math.random();
		bcn.src=this.dataUrl+'action=beacon&b=b'+this.plinkNumber+'&r=&rnd='+rnd;
		procframe.location.replace(this.dataUrl+'plink=_plink'+this.plinkNumber+'&value='+this.currentValue);
		this.arrow.parentNode.className='plinka';
		this.ddopen=1;
	}else if(this.ddopen){
		this.ddclose(this);
	}
	return false;
}
plink.prototype.ddclose=function(o){
	o.arrow.parentNode.className='';
	o.arrow.blur();
	o.plinkCx.innerHTML=o._plinks.openPlink='';
	o.plinkCx.style.display="none";
	o.ddopen=0;
}
for(var i=0;i<=_plinks.plinkList.length;i++){
	var j=i+1;
	window['_plink'+j]=new plink(j,_plinks.plinkList[i]);
}
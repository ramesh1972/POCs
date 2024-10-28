<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>test adpp client</title>
    <script type="text/javascript" language="javascript" src="http://localhost:1224/adpp/json2.js"></script>
    <script type="text/javascript" language="javascript" src="http://localhost:1224/adpp/jquery-1.4.4.min.js"></script>
    <script type="text/javascript" language="javascript" src="http://localhost:1224/adpp/adplusplus.js"></script>

    <script type="text/javascript" language="javascript">
        var myAds =
        {
            Ads:
            [
                { adkeywords: "phone, samsung", addesc: "the best phone in the world" },
                { adkeywords: "clean, soap, fresh day", addesc: "fresh and dry" }
            ]
        };

        $(document).ready(
        function () {
            var thisLink = document.URL;
            var thisDocInnerText = document.body.innerText;
            myAds.pubUrl = thisLink;
            myAds.docText = thisDocInnerText;

            var myAdsStr = "input='" + JSON.stringify(myAds) + "'";
            alert(myAdsStr);

            $.ajax(
            {
                type: "POST",
                url: "http://localhost:1224/adpp/getads.ashx",
                data: myAdsStr,
//                contentType: "application/json; charset=utf-8",
                success: function (adsjson) {
                    alert(adsjson)
                    $("#results").html(adsjson);
                    //HighlightAdWords2(adsjson);
                }
            });
        });
    
    </script>
</head>
<body>
    <div id="results">

<div class="sub-headline">
<a href="http://www.thehindu.com/news/national/article1065234.ece?homepage=true"> <img src="http://www.thehindu.com/multimedia/dynamic/00346/IN08_FOG1_346652b.jpg"
alt="Planes standing at the IGI airport as fog disrupted movement of flights in New Delhi. File Photo" title="Planes standing at the IGI airport as fog disrupted movement of flights in New Delhi. File Photo" class="bordered-image -align" /> </a>
<h2>
<a href="http://www.thehindu.com/news/national/article1065234.ece?homepage=true" title="Updated: January 8, 2011 at 09:07 IST &#013;
Published: January 8, 2011 at 09:05 IST &#013;
in NATIONAL" alt="Updated: January 8, 2011 at 09:07 IST &#013;
Published: January 8, 2011 at 09:05 IST &#013;
in NATIONAL">
Fog disrupts flight operations at "IGI" 'airport'
</a> </h2>
<div class="article-additional-info">
Fog started to descend on the airport on Friday night and thickened around 11 PM, forcing airport authorities to implement low visibility procedures at around 11.20 PM.
<a href="http://www.thehindu.com/news/national/article1065234.ece?homepage=true" class="more"><span class="arrows">&#187;</span></a>
<div class="headline-links">
Related:
<a href="http://www.thehindu.com/news/cities/Delhi/article1037743.ece" title="Updated: January 6, 2011 at 10:32 IST &#013;
Published: January 6, 2011 at 10:32 IST &#013;
in DELHI" alt="Updated: January 6, 2011 at 10:32 IST &#013;
Published: January 6, 2011 at 10:32 IST &#013;
in DELHI">Another chilly day for Delhi</a> <br>
Related:
<a href="http://www.thehindu.com/news/national/article1034382.ece" title="Updated: January 5, 2011 at 10:01 IST &#013;
Published: January 5, 2011 at 10:01 IST &#013;
in NATIONAL" alt="Updated: January 5, 2011 at 10:01 IST &#013;
Published: January 5, 2011 at 10:01 IST &#013;
in NATIONAL">Chilly day for Delhiites</a> </div>
</div>    
</div>

</body>
</html>

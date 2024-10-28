<%@ Register TagPrefix="radU" Namespace="Telerik.WebControls" Assembly="RadUpload.NET2" %>
<%@ Page language="c#" CodeFile="Default.aspx.cs" AutoEventWireup="false" Inherits="RVK.Uploader" %>
<!doctype html public "-//w3c//dtd xhtml 1.1//en" "http://www.w3.org/tr/xhtml11/dtd/xhtml11.dtd"> 

<html>
    <head id="Head1" runat="server">
    </head>
    <body class="BODY">
        <form runat="server" id="mainForm" method="post" style="WIDTH:100%">
        <script type="text/javascript">
            function OnClientProgressBarUpdating (progressArea, args) 
            {
                progressArea.UpdateVerticalProgressBar(args.ProgressBarElement, args.ProgressValue);
                return false;
            }
        </script>
            <table width="754">
                To see the progress area, please upload a large file.
                <tr>
                    <td style="vertical-align: top;">
                        <radu:radupload id="Radupload1" runat="server" 
                        targetfolder="~/Files"
                        overwriteexistingfiles="false"/>
                        <asp:button id="buttonSubmit" runat="server" text="Submit" cssclass="RadUploadButton" />
                    </td>
                    <td style="vertical-align: top;">
                        <div class="module" style="margin-top: 5px; float: right; width: 320px; overflow: auto; height: 98px;">
                            <asp:label id="labelNoResults" runat="server" visible="True">No uploaded files yet</asp:label>
                            <asp:repeater id="reportResults" runat="server" visible="False">
                                <headertemplate>
                                    <span >Uploaded files:</span><br />
                                </headertemplate>
                                <itemtemplate>
                                    '<%#DataBinder.Eval(Container.DataItem, "FileName")%>' 
                                    (
                                    '<%#DataBinder.Eval(Container.DataItem, "ContentLength").ToString() + " bytes"%>' 
                                    )<br />
                                </itemtemplate>
                            </asp:repeater>
                        </div>
                    </td>
                </tr>
            </table>
            <radu:radprogressmanager id="Radprogressmanager1" runat="server" />
            <radu:radprogressarea id="RadProgressArea1" runat="server" class="module" onclientprogressbarupdating="OnClientProgressBarUpdating">
                <progresstemplate >
                    <div class="RadUploadProgressArea" style="padding:10px;height:400px;">TotalProgressBar:<br/>
                        <div style="z-index:100;position:absolute;">
                                <embed 
                                    src="speedometer.swf" 
                                    quality="high" 
                                    wmode="transparent" 
                                    bgcolor="#ffffff" 
                                    width="168" 
                                    height="168" 
                                    name="speedometer" 
                                    align="middle" 
                                    allowscriptaccess="sameDomain" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />
                        </div>
                        <table style="height:168px;width:168px;" cellpadding="0" cellspacing="0">
                            <tr>
                                <td valign="bottom" style="height:168px;">
                                    <asp:panel runat="server" id="PrimaryProgressBar" style="height:0%;width:168px;background-color:blue;vertical-align:bottom;">&nbsp;</asp:panel>
                                </td>
                            </tr>
                        </table>
                        <br />
                        TotalProgress: <span runat="server" id="PrimaryValue"></span><br />
                        TotalProgressPercent: <span runat="server" id="PrimaryPercent"></span><br />
                        FilesCountBar: <div runat="server" id="SecondaryProgressBar" style="display:inline;width:0px;background-color:red"></div><br />
                        FilesCount: <span runat="server" id="SecondaryValue"></span><br />
                        FilesCountPercent: <span runat="server" id="SecondaryPercent"></span><br />
                        RequestSize: <span runat="server" id="PrimaryTotal"></span><br />
                        SelectedFilesCount: <span runat="server" id="SecondaryTotal"></span><br />
                        CurrentFileName: <span runat="server" id="CurrentOperation"></span><br />
                        TimeElapsed: <span runat="server" id="TimeElapsed"></span><br />
                        TimeEstimated: <span runat="server" id="TimeEstimated"></span><br />
                        TransferSpeed: <span runat="server" id="Speed"></span><br />        
                    </div>
                </progresstemplate>
            </radu:radprogressarea>
        </form>
    </body>
</html>




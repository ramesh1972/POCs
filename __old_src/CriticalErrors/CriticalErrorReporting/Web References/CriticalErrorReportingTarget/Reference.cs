﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:2.0.50727.42
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

// 
// This source code was auto-generated by Microsoft.VSDesigner, Version 2.0.50727.42.
// 
#pragma warning disable 1591

namespace CriticalErrorReporting.CriticalErrorReportingTarget {
    using System.Diagnostics;
    using System.Web.Services;
    using System.ComponentModel;
    using System.Web.Services.Protocols;
    using System;
    using System.Xml.Serialization;
    
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "2.0.50727.42")]
    [System.Diagnostics.DebuggerStepThroughAttribute()]
    [System.ComponentModel.DesignerCategoryAttribute("code")]
    [System.Web.Services.WebServiceBindingAttribute(Name="CriticalErrorReportingServiceSoap", Namespace="http://MSDN.EntLib.CriticalErrors.org/")]
    public partial class CriticalErrorReportingService : System.Web.Services.Protocols.SoapHttpClientProtocol {
        
        private System.Threading.SendOrPostCallback ReportCriticalErrorOperationCompleted;
        
        private bool useDefaultCredentialsSetExplicitly;
        
        /// <remarks/>
        public CriticalErrorReportingService() {
            this.Url = global::CriticalErrorReporting.Properties.Settings.Default.CriticalErrorReporting_CriticalErrorReportingService_ReportingService;
            if ((this.IsLocalFileSystemWebService(this.Url) == true)) {
                this.UseDefaultCredentials = true;
                this.useDefaultCredentialsSetExplicitly = false;
            }
            else {
                this.useDefaultCredentialsSetExplicitly = true;
            }
        }
        
        public new string Url {
            get {
                return base.Url;
            }
            set {
                if ((((this.IsLocalFileSystemWebService(base.Url) == true) 
                            && (this.useDefaultCredentialsSetExplicitly == false)) 
                            && (this.IsLocalFileSystemWebService(value) == false))) {
                    base.UseDefaultCredentials = false;
                }
                base.Url = value;
            }
        }
        
        public new bool UseDefaultCredentials {
            get {
                return base.UseDefaultCredentials;
            }
            set {
                base.UseDefaultCredentials = value;
                this.useDefaultCredentialsSetExplicitly = true;
            }
        }
        
        /// <remarks/>
        public event ReportCriticalErrorCompletedEventHandler ReportCriticalErrorCompleted;
        
        /// <remarks/>
        [System.Web.Services.Protocols.SoapDocumentMethodAttribute("http://MSDN.EntLib.CriticalErrors.org/ReportCriticalError", RequestNamespace="http://MSDN.EntLib.CriticalErrors.org/", ResponseNamespace="http://MSDN.EntLib.CriticalErrors.org/", Use=System.Web.Services.Description.SoapBindingUse.Literal, ParameterStyle=System.Web.Services.Protocols.SoapParameterStyle.Wrapped)]
        public void ReportCriticalError([System.Xml.Serialization.XmlElementAttribute(DataType="base64Binary")] byte[] message) {
            this.Invoke("ReportCriticalError", new object[] {
                        message});
        }
        
        /// <remarks/>
        public void ReportCriticalErrorAsync(byte[] message) {
            this.ReportCriticalErrorAsync(message, null);
        }
        
        /// <remarks/>
        public void ReportCriticalErrorAsync(byte[] message, object userState) {
            if ((this.ReportCriticalErrorOperationCompleted == null)) {
                this.ReportCriticalErrorOperationCompleted = new System.Threading.SendOrPostCallback(this.OnReportCriticalErrorOperationCompleted);
            }
            this.InvokeAsync("ReportCriticalError", new object[] {
                        message}, this.ReportCriticalErrorOperationCompleted, userState);
        }
        
        private void OnReportCriticalErrorOperationCompleted(object arg) {
            if ((this.ReportCriticalErrorCompleted != null)) {
                System.Web.Services.Protocols.InvokeCompletedEventArgs invokeArgs = ((System.Web.Services.Protocols.InvokeCompletedEventArgs)(arg));
                this.ReportCriticalErrorCompleted(this, new System.ComponentModel.AsyncCompletedEventArgs(invokeArgs.Error, invokeArgs.Cancelled, invokeArgs.UserState));
            }
        }
        
        /// <remarks/>
        public new void CancelAsync(object userState) {
            base.CancelAsync(userState);
        }
        
        private bool IsLocalFileSystemWebService(string url) {
            if (((url == null) 
                        || (url == string.Empty))) {
                return false;
            }
            System.Uri wsUri = new System.Uri(url);
            if (((wsUri.Port >= 1024) 
                        && (string.Compare(wsUri.Host, "localHost", System.StringComparison.OrdinalIgnoreCase) == 0))) {
                return true;
            }
            return false;
        }
    }
    
    /// <remarks/>
    [System.CodeDom.Compiler.GeneratedCodeAttribute("System.Web.Services", "2.0.50727.42")]
    public delegate void ReportCriticalErrorCompletedEventHandler(object sender, System.ComponentModel.AsyncCompletedEventArgs e);
}

#pragma warning restore 1591
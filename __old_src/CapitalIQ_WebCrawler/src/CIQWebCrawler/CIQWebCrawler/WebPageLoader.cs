using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net;
using System.IO;

namespace CIQWebCrawler
{
    /// <summary>
    /// A helper object to load a webpage Synchronously
    /// </summary>
    class WebPageLoader
    {
        private WebClient _mClient = new WebClient();
        private mshtml.IHTMLDocument2 _mHTMLDoc;

        public WebPageLoader(string pUrl)
        {
            _SynchronousRead(pUrl);
        }

        private void _SynchronousRead(String pUrl)
        {
            if (String.IsNullOrEmpty(pUrl))
                return;

            try
            {
                _mClient.Headers.Add(HttpRequestHeader.UserAgent, "CapitalIQ-Demo/1.0 (MSIE 6.0; Windows XP)");

                Stream data = _mClient.OpenRead(new Uri(pUrl));

                // read the contents of the webpage
                StreamReader reader = new StreamReader(data);
                string htmlContent = reader.ReadToEnd();

                // cleanup
                reader.Close();
                data.Close();

                // create the doc
                _mHTMLDoc = (mshtml.IHTMLDocument2)new mshtml.HTMLDocument();
                _mHTMLDoc.write(htmlContent);
            }
            catch (System.Net.WebException wexp)
            {
                throw wexp;
            }
            catch (Exception exp)
            {
                throw exp;
            }
        }

        /// <summary>
        /// returns the HTMLDocument DOM object associated with the resource
        /// </summary>
        /// <returns></returns>
        public mshtml.IHTMLDocument2 GetHTMLDocument()
        {
            return _mHTMLDoc;
        }
    }
}

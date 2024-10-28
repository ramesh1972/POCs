using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;

namespace CIQWebCrawler
{
    class Program
    {
        // Configurations
        public static string ResultantDocumentsStore = String.Empty;
        public static string ResultantDocumentsInfoFile = String.Empty;

        // The driver which is a file having code to crawl a website.
        public const string DefaultCustomCrawlerCodeFile = "CustomCrawlerCode.xml";
        static public CustomCrawlerCodes mCrawlerCodes = null;

        static void Main(string[] args)
        {
            /* Starting Point is the Custom Crawler Code File which has the following,
             * 1) list of websites to crawl.
             * 2) for each website, content to select and/or to crawl further
             * 3) for each content, meta data information to be stored.
             * 
             * The default file is CustomCrawlerCode.xml. 
             * A different Custom Crawler Code file can be passed in as an argument as an option. This
             * will allow to start multiple sets of crawlers (this program with different files). However all the
             * websites to crawl can be included in one file and each website will be crawled on an individual thread.
             * So basically giving an option for multi-threading Vs multi-tasking.
            */

            // create the global 
            if (args.Length == 1)
                mCrawlerCodes = new CustomCrawlerCodes(args[0]);
            else
                mCrawlerCodes = new CustomCrawlerCodes();

            /* Setup Basic Confirguation */
            ResultantDocumentsStore = System.Configuration.ConfigurationManager.AppSettings.Get("ResultantDocumentsStore");
            ResultantDocumentsInfoFile = System.Configuration.ConfigurationManager.AppSettings.Get("ResultantDocumentsInfoFile");

            /* Loop through the list of crawler codes and start crawling each site on a new thread */
            foreach (CustomCrawlerCode crawlerCode in mCrawlerCodes)
            {
                Thread crawlerThread = new Thread(new ParameterizedThreadStart(_CrawlSite));
                crawlerThread.Start(crawlerCode);
            }
        }

        /// <summary>
        /// The driver funtion for the crawling, parsing, extracting and saving content.
        /// A thread function started, one for each CustomCralwerCode instance
        /// </summary>
        /// <param name="pCrawlerCode">CustomCrawlerCode created from the crawler code file</param>
        private static void _CrawlSite(object pCrawlerCode)
        {
            try
            {
                Console.WriteLine("Crawling [" + ((CustomCrawlerCode) pCrawlerCode).mUrlToCrawl + "] Site" + Environment.NewLine);

                // creating an instance of the Document object crawls site, extracts content and saves
                new Document((CustomCrawlerCode)pCrawlerCode);

                Console.WriteLine("Finished Crawling [" + ((CustomCrawlerCode) pCrawlerCode).mUrlToCrawl + "] Site" + Environment.NewLine);
            }
            catch (Exception exp)
            {
                Console.WriteLine("FATAL: Exception caught: " + exp.Message + Environment.NewLine);
            }
        }
    }
}

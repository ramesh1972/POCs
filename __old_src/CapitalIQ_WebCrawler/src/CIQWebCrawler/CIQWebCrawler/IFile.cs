using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;

namespace CIQWebCrawler
{
    /// <summary>
    /// Defines the file representation of an HTML document or the result of downloading a resource.
    /// </summary>
    public interface IFile
    {
        /// <summary>
        /// A stream containing the file content.
        /// </summary>
        Stream Data { get; set; }

        /// <summary>
        /// The original name of the file at the source.
        /// </summary>
        string DisplayName { get; set; }

        /// <summary>
        /// The extension of the file.
        /// </summary>
        string Extension { get; set; }

        /// <summary>
        /// Metadata describing the specific file.
        /// </summary>
        ICollection<IMetaData> MetaData { get; set; }

        /// <summary>
        /// Helper function to create the resultant resource file and save the contents
        /// </summary>
        /// <param name="pUrl">Url of the Resultant Document/Content</param>
        /// <param name="pResultStore">Relative/Absolute path under which documents are stored</param>
        /// <param name="data">the data to be written to the file</param>
        void CreateFile(string pUrl, string pResultStore, string data);  
    }
}

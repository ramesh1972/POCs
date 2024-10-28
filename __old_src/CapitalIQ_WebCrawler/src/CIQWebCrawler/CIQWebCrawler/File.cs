using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Xml;
using System.Xml.Serialization;

namespace CIQWebCrawler
{
    public class File : IFile
    {
        /// <summary>
        /// A stream containing the file content.
        /// </summary>
        public Stream Data { get; set; }

        /// <summary>
        /// The original name of the file at the source.
        /// </summary>
        public string DisplayName { get; set; }

        /// <summary>
        /// The extension of the file.
        /// </summary>
        public string Extension { get; set; }

        List<IMetaData> _mMetaData = new List<IMetaData>();

        /// <summary>
        /// Metadata describing the specific file.
        /// </summary>
        public ICollection<IMetaData> MetaData 
        { 
            get
            {
                return _mMetaData;
            }
            set
            {
                _mMetaData = (List<IMetaData>) value;
            }
        }

        /// <summary>
        /// Helper function to create the resultant resource file and save the contents
        /// </summary>
        /// <param name="pUrl">Url of the Resultant Document/Content</param>
        /// <param name="pResultStore">Relative/Absolute path under which documents are stored</param>
        /// <param name="data">the data to be written to the file</param>
        public void CreateFile(string pUrl, string pResultStore, string pData)
        {
            // create the Uri object that will the split up of the Url
            Uri uri = new Uri(pUrl);

            // setup DisplayName and Extension
            string[] segs = uri.AbsolutePath.Split('/');
            string fname = segs[segs.Length - 1];
            string[] fileparts = fname.Split('.');
            string ext = fileparts[fileparts.Length - 1];
            if (fileparts.Length == 0)
            {
                fname = "Default";
                ext = "htm";
            }
            else if (fileparts.Length == 1)
            {
                fname = fileparts[0];
                ext = "htm";
            }
            else if (fileparts.Length == 2)
            {
                fname = fileparts[0];
                ext = fileparts[1];
            }

            if (fname.Trim() == String.Empty)
                fname = "Default";

            if (ext.Trim() == String.Empty)
                ext = "htm";

            DisplayName = fname;
            Extension = ext;

            // ResultStore in which all documents will be stored
            if (!String.IsNullOrEmpty(pResultStore) && pResultStore[pResultStore.Length - 1] != '\\')
                pResultStore += "\\";

            // every site gets its own folder for storing documents related to it
            string siteFolder = uri.Host;

            // resource folder is made up of the paht in the Url.
            // so for e.g.. path like /Archives/cgi-bin/index.php translates into a folder
            // like "Archvies_cgi-bin"
            string resourceFolder = "";
            for (int idx = 0; idx < segs.Length - 1; idx++)
                if (segs[idx].Trim() != String.Empty)
                    resourceFolder += segs[idx] + "_";
            resourceFolder = resourceFolder.Substring(0, resourceFolder.Length - 1); //Strip the last _

            // put the whole path together
            string path = pResultStore + siteFolder + "\\" + resourceFolder + "\\";
            if (!Directory.Exists(path))
                Directory.CreateDirectory(path);

            // the name of the file is <DateTime>_DisplayName.Extension. So the same resource if changes over
            // time can be stored without overwriting the previous extraction.
            string date = DateTime.Now.ToString("yy_MM_dd_HH_mm_ss");
            string file = path + "\\" + date + "--" + DisplayName + "." + Extension;

            // write the contents to the file
            FileStream stream = new FileStream(file, FileMode.CreateNew);
            System.IO.BinaryWriter bWriter = new BinaryWriter(stream);
            byte[] bData = Encoding.UTF8.GetBytes(pData);
            bWriter.Write(bData);

            bWriter.Flush();
            bWriter.Close();
            stream.Close();

            // save metadata
            // Create a new XmlSerializer instance with the type of the test class
            XmlSerializer serializerObj = new XmlSerializer(typeof(MetaData));

            // Create a new file stream to write the serialized object to a file
            // Note: for each resource, the metadata.xml is created in the same folder
            // as the resource document.
            TextWriter metaDataStream = new StreamWriter(path + "\\MetaData.xml");
            
            // write each piece of MetaData information to the MetaData file
            foreach (IMetaData metaData in MetaData)
                serializerObj.Serialize(metaDataStream, metaData);

            metaDataStream.Flush();
            metaDataStream.Close();
        }
    }
}

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CIQWebCrawler
{
    /// <summary>
    /// Type of the meta data being stored for the content extracted.
    /// </summary>
    public enum MetaDataType
    {
        Int = 0,
        String = 1,
        Date = 2
    }

    /// <summary>
    /// Defines a single datapoint for describing a file or resource.
    /// </summary>
    public interface IMetaData
    {
        /// <summary>
        /// An identifier for the type of datapoint.
        /// </summary>
        int TypeId { get; set; }

        /// <summary>
        /// The datapoint value. This object will be stored as a string value in the database.
        /// </summary>
        object Value { get; set; }
    }
}

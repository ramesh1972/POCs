using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Diagnostics;
using System.Text;
using System.Data;
using System.IO;
using CriticalErrorReporting.Data;
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.EnterpriseLibrary.Security.Cryptography;

[WebService(Namespace = "http://MSDN.EntLib.CriticalErrors.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class CriticalErrorReportingService : System.Web.Services.WebService
{
    public CriticalErrorReportingService() 
    {
    }

    [WebMethod]
    public void ReportCriticalError(byte [] message) 
    {
        if(message.Length == 0)
            return;

        // get the string for the entry message
        string base64EncryptedEntryMessage = Encoding.UTF8.GetString(message);

        // Base 64 decode the encrypted bytes
        byte[] encryptedEntryBytes =
            Convert.FromBase64String(base64EncryptedEntryMessage);

        // Dencrypt the information using the Cryptography block
        // The "RijindaelManaged" string is the name of the Symmetric Provider
        // that is set up in the configuration file of the application.
        byte[] entryBytes =
            Cryptographer.DecryptSymmetric("RijndaelManaged", encryptedEntryBytes);

        // get the xml string from the bytes
        string entryMessage = Encoding.Unicode.GetString(entryBytes);

        // dump it on this side when debugging to check the payload
        Debug.WriteLine(entryMessage);

        // Create a database connection using the Data block and the
        // connection string to the CriticalErrors database
        Database db = DatabaseFactory.CreateDatabase("CriticalErrorConnectionString");

        // Create the CriticalError DataSet and process the log entry
        CriticalErrorDS errorDS = new CriticalErrorDS();
        errorDS.ProcessCriticalError(entryMessage, db);
    }
}

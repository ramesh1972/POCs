using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Net;
using System.IO;
using System.Runtime.InteropServices;
using System.Collections;

class ManageCache
{
    // For PInvoke: Contains information about an entry in the Internet cache
    [StructLayout(LayoutKind.Sequential)]
    public struct INTERNET_CACHE_ENTRY_INFOA
    {
        public UInt32 dwStructSize;
        public string lpszSourceUrlName;
        public string lpszLocalFileName;
        public UInt32 CacheEntryType;
        public UInt32 dwUseCount;
        public UInt32 dwHitRate;
        public UInt32 dwSizeLow;
        public UInt32 dwSizeHigh;
        public FILETIME LastModifiedTime;
        public FILETIME ExpireTime;
        public FILETIME LastAccessTime;
        public FILETIME LastSyncTime;
        public IntPtr lpHeaderInfo;
        public UInt32 dwHeaderInfoSize;
        public string lpszFileExtension;
        public UInt32 dwExemptDelta;
    } ;

    // For PInvoke: Initiates the enumeration of the cache groups in the Internet cache
    [DllImport(@"wininet",
        SetLastError = true,
        CharSet = CharSet.Auto,
        EntryPoint = "FindFirstUrlCacheGroup",
        CallingConvention = CallingConvention.StdCall)]

public static  extern IntPtr FindFirstUrlCacheGroup(
        int dwFlags,
        int dwFilter,
        IntPtr lpSearchCondition,
        int dwSearchCondition,
        ref long lpGroupId,
        IntPtr lpReserved);

    // For PInvoke: Retrieves the next cache group in a cache group enumeration
    [DllImport(@"wininet",
        SetLastError = true,
        CharSet = CharSet.Auto,
        EntryPoint = "FindNextUrlCacheGroup",
        CallingConvention = CallingConvention.StdCall)]
    public static extern bool FindNextUrlCacheGroup(
        IntPtr hFind,
        ref long lpGroupId,
        IntPtr lpReserved);

    // For PInvoke: Releases the specified GROUPID and any associated state in the cache index file
    [DllImport(@"wininet",
        SetLastError = true,
        CharSet = CharSet.Auto,
        EntryPoint = "DeleteUrlCacheGroup",
        CallingConvention = CallingConvention.StdCall)]
    public static extern bool DeleteUrlCacheGroup(
        long GroupId,
        int dwFlags,
        IntPtr lpReserved);

    // For PInvoke: Begins the enumeration of the Internet cache
    [DllImport(@"wininet",
        SetLastError = true,
        CharSet = CharSet.Auto,
        EntryPoint = "FindFirstUrlCacheEntryA",
        CallingConvention = CallingConvention.StdCall)]
    public static extern IntPtr FindFirstUrlCacheEntry(
        [MarshalAs(UnmanagedType.LPTStr)] string lpszUrlSearchPattern,
        IntPtr lpFirstCacheEntryInfo,
        ref int lpdwFirstCacheEntryInfoBufferSize);

    // For PInvoke: Retrieves the next entry in the Internet cache
    [DllImport(@"wininet",
        SetLastError = true,
        CharSet = CharSet.Auto,
        EntryPoint = "FindNextUrlCacheEntryA",
        CallingConvention = CallingConvention.StdCall)]
    public static extern bool FindNextUrlCacheEntry(
        IntPtr hFind,
        IntPtr lpNextCacheEntryInfo,
        ref int lpdwNextCacheEntryInfoBufferSize);

    // For PInvoke: Removes the file that is associated with the source name from the cache, if the file exists
    [DllImport(@"wininet",
        SetLastError = true,
        CharSet = CharSet.Auto,
        EntryPoint = "DeleteUrlCacheEntryA",
        CallingConvention = CallingConvention.StdCall)]
    public static extern bool DeleteUrlCacheEntry(
        string lpszUrlName);
};

public partial class StartTargetPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string url = Request.Params["loadurl"];
        string html = FetchAndLoadURL(url);

        //CopyPageFilesFromCache(url);
        FindUrlCacheEntries(url);
        this.Response.Write(html);
    }

    private string FetchAndLoadURL(string pUrl)
    {
        if (string.IsNullOrEmpty(pUrl))
            return "";

        WebRequest requestHtml = WebRequest.Create(pUrl);
        WebResponse responseHtml = requestHtml.GetResponse();

        StreamReader r = new StreamReader(responseHtml.GetResponseStream());
        string htmlContent = r.ReadToEnd();
        r.Close();

        return htmlContent;
    }

    private void CopyPageFilesFromCache(string pUrl)
    {
        if (string.IsNullOrEmpty(pUrl))
            return;

        if (!System.IO.Directory.Exists("TempFiles"))
            System.IO.Directory.CreateDirectory("TempFiles");

        // No more items have been found.
        const int ERROR_NO_MORE_ITEMS = 259;

        int cacheEntryInfoBufferSizeInitial = 418;
        int cacheEntryInfoBufferSize = 1000;
        IntPtr cacheEntryInfoBuffer = IntPtr.Zero;
        
        ManageCache.INTERNET_CACHE_ENTRY_INFOA internetCacheEntry;
        IntPtr enumHandle = IntPtr.Zero;
        bool returnValue = false;

        cacheEntryInfoBufferSize = cacheEntryInfoBufferSizeInitial;
        cacheEntryInfoBuffer = Marshal.AllocHGlobal(cacheEntryInfoBufferSize);
        enumHandle = ManageCache.FindFirstUrlCacheEntry(null, cacheEntryInfoBuffer, ref cacheEntryInfoBufferSizeInitial);

        if (enumHandle != IntPtr.Zero)
            returnValue = true;
        else
            return;

        while(true)
        {
            if (!returnValue && ERROR_NO_MORE_ITEMS == Marshal.GetLastWin32Error())
                break;


            if (returnValue)
            {
                internetCacheEntry = (ManageCache.INTERNET_CACHE_ENTRY_INFOA)Marshal.PtrToStructure(cacheEntryInfoBuffer, typeof(ManageCache.INTERNET_CACHE_ENTRY_INFOA));
                cacheEntryInfoBufferSizeInitial = cacheEntryInfoBufferSize;

                string lfile = internetCacheEntry.lpszLocalFileName.ToString();
                string rfile = internetCacheEntry.lpszSourceUrlName.ToString();
            }

            cacheEntryInfoBuffer = Marshal.ReAllocHGlobal(cacheEntryInfoBuffer, (IntPtr)cacheEntryInfoBufferSizeInitial);
            returnValue = ManageCache.FindNextUrlCacheEntry(enumHandle, cacheEntryInfoBuffer, ref cacheEntryInfoBufferSize);
        }
        Marshal.FreeHGlobal(cacheEntryInfoBuffer);
    }

    public static ArrayList FindUrlCacheEntries(string urlPattern)
    {
        const int ERROR_NO_MORE_ITEMS = 259;
        const int ERROR_INSUFFICIENT_BUFFER = 0x7A;
        ArrayList results = new ArrayList();

        IntPtr buffer = IntPtr.Zero;
        Int32 structSize = 0;

        //This call will fail but returns the size required in structSize
        //to allocate necessary buffer
        IntPtr hEnum = ManageCache.FindFirstUrlCacheEntry(null, buffer, ref structSize);
        try
        {
            if (hEnum == IntPtr.Zero)
            {
                int lastError = Marshal.GetLastWin32Error();
                if (lastError == ERROR_INSUFFICIENT_BUFFER)
                {
                    //Allocate buffer
                    buffer = Marshal.AllocHGlobal((int)structSize);
                    //Call again, this time it should succeed
                    hEnum = ManageCache.FindFirstUrlCacheEntry(null, buffer, ref structSize);
                }
                else if (lastError == ERROR_NO_MORE_ITEMS)
                {
                    return results;
                }
            }

            ManageCache.INTERNET_CACHE_ENTRY_INFOA result = (ManageCache.INTERNET_CACHE_ENTRY_INFOA)Marshal.PtrToStructure(buffer, typeof(ManageCache.INTERNET_CACHE_ENTRY_INFOA));
            try
            {
                string r = "microsoft";
                if (System.Text.RegularExpressions.Regex.IsMatch(result.lpszSourceUrlName, r, System.Text.RegularExpressions.RegexOptions.IgnoreCase))
                {
                    results.Add(result);
                }
                try { System.IO.File.Delete(result.lpszLocalFileName); }
                catch { }
                bool ret = ManageCache.DeleteUrlCacheEntry(result.lpszSourceUrlName);
                if (!ret)
                {
                    int lastError = Marshal.GetLastWin32Error();
                }
            }
            catch (ArgumentException ae)
            {
                throw new ApplicationException("Invalid regular expression, details=" + ae.Message);
            }

            if (buffer != IntPtr.Zero)
            {
                try { Marshal.FreeHGlobal(buffer); }
                catch { }
                buffer = IntPtr.Zero;
                buffer = Marshal.AllocHGlobal((int)structSize);
                structSize = 0;
            }

            //Loop through all entries, attempt to find matches
            while (true)
            {
                bool nextResult = ManageCache.FindNextUrlCacheEntry(hEnum, buffer, ref structSize);
                if (!nextResult) //TRUE
                {
                    int lastError = Marshal.GetLastWin32Error();
                    if (lastError == ERROR_INSUFFICIENT_BUFFER)
                    {
                        try { Marshal.FreeHGlobal(buffer); }
                        catch { }
                        buffer = IntPtr.Zero;
                        buffer = Marshal.AllocHGlobal((int)structSize);
                        nextResult = ManageCache.FindNextUrlCacheEntry(hEnum, buffer, ref structSize);
                    }
                    else if (lastError == ERROR_NO_MORE_ITEMS)
                    {
                        break;
                    }
                }

                ManageCache.INTERNET_CACHE_ENTRY_INFOA result1 = (ManageCache.INTERNET_CACHE_ENTRY_INFOA)Marshal.PtrToStructure(buffer, typeof(ManageCache.INTERNET_CACHE_ENTRY_INFOA));
                string r1 = "microsoft";
                if (System.Text.RegularExpressions.Regex.IsMatch(result1.lpszSourceUrlName, r1, System.Text.RegularExpressions.RegexOptions.IgnoreCase))
                {
                    results.Add(result1);
                    
                }
                try
                {
                    System.IO.File.Delete(result1.lpszLocalFileName);
                }
                catch
                {
                }
                bool ret = ManageCache.DeleteUrlCacheEntry(result1.lpszSourceUrlName);
                if (!ret)
                {
                    int lastError = Marshal.GetLastWin32Error();
                }
                if (buffer != IntPtr.Zero)
                {
                    try { Marshal.FreeHGlobal(buffer); }
                    catch { }
                    buffer = IntPtr.Zero;
                    buffer = Marshal.AllocHGlobal((int)structSize);
                    structSize = 0;
                }
            }
        }
        finally
        {
            if (hEnum != IntPtr.Zero)
            {
                //ManageCache.FindCloseUrlCache(hEnum);
            }
            if (buffer != IntPtr.Zero)
            {
                try { Marshal.FreeHGlobal(buffer); }
                catch { }
            }
        }

        return results;
    }
}
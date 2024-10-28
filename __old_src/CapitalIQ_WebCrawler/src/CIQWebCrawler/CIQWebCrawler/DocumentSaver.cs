using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CIQWebCrawler
{
    /// <summary>
    /// Helper class that assists IFile to save the extracted content and assocaited meta data
    /// </summary>
    public class DocumentSaver
    {
        IDocument _mDocToSave = null;
        IElement _mElemToSave = null;
        CrawlerCode _mCrawlerCode = null;

        public DocumentSaver(CrawlerCode pCrawlerCode, IDocument pDocToSave)
        {
            _mDocToSave = pDocToSave;
            _mCrawlerCode = pCrawlerCode;
        }

        public DocumentSaver(CrawlerCode pCrawlerCode, IElement pElemToSave)
        {
            _mElemToSave = pElemToSave;
            _mCrawlerCode = pCrawlerCode;
        }
        
        /// <summary>
        /// delegates the function to Document or Element object based on which ever is set.
        /// </summary>
        /// <returns>a IFile object that holds a file that holds the extracted content</returns>
        public IFile Save()
        {
            IFile file = null;

            if (_mDocToSave != null)
                file = _mDocToSave.SaveDocument();
            else if (_mElemToSave != null)
                file = _mElemToSave.SaveTarget();
            
            return file;
        }
    }
}

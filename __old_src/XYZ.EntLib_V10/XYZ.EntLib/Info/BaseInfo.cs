using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Text;
using System.Data;

using XYZ.EntLib.DataLayer;

namespace XYZ.EntLib.AppBlocks
{
    abstract public class BaseInfo
    {
        public XYZ_EntLib_DB_DS _logDS = null;
        public Guid _logEntryId;

        public BaseInfo(XYZ_EntLib_DB_DS logDS)
        {
            _logDS = logDS;

            try
            {
                _logEntryId = ((XYZ_EntLib_DB_DS.LogEntryRow)_logDS.LogEntry.Rows[0]).id;
            }
            catch (Exception e)
            {
            }
        }

        public BaseInfo(XYZ_EntLib_DB_DS logDS, Guid id)
        {
            _logDS = logDS;
            _logEntryId = id;
        }

        public BaseInfo()
        {
            _logDS = new XYZ_EntLib_DB_DS();
            _logEntryId = Guid.NewGuid();
        }

        public string GetDSXml()
        {
            if (_logDS != null)
                return _logDS.GetXml();

            return "empty ds";
        }

        public string GetHtmlVerticalTable(DataTable dt)
        {
            string html = "<table width=100% height=100%>";

            for (int idx = 0; idx < dt.Columns.Count; idx++)
            {
                html += "<tr><td width=200px><b>" + dt.Columns[idx].ColumnName + "</b></td>";
                for (int idx1 = 0; idx1 < dt.Rows.Count; idx1++)
                {
                    foreach (DataRow dr in dt.Rows)
                        html += "<td>" + dr.ItemArray[idx].ToString() + "</td>";
                }
            }

            html += "</table>";

            return html;
        }

        public string GetHtmlHorzTable(DataTable dt)
        {
            string html = "<table width=100% height=100%><tr>";
            for (int idx = 0; idx < dt.Columns.Count; idx++)
            {
                html += "<td><b>" + dt.Columns[idx].ColumnName + "</b></td>";
            }
            html += "</tr>";

            for (int idx1 = 0; idx1 < dt.Rows.Count; idx1++)
            {
                html += "<tr>";
                foreach (object x in dt.Rows[idx1].ItemArray)
                    html += "<td>" + x.ToString() + "</td>";

                html += "</tr>";
               
            }

            html += "</table>";

            return html;
        }

    }
}

using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections;
using System.Diagnostics;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class IssueDetails : System.Web.UI.Page
{
    private string _exceptionId = "";
    private string[] _totalProcessorFieldNames = new string[5] {"totalProcessorTimeDays", "totalProcessorTimeHours",
                "totalProcessorTimeMinutes","totalProcessorTimeSeconds","totalProcessorTimeFraction"};
    private string[] _userProcessorFieldNames = new string[5] {"userProcessorTimeDays", "userProcessorTimeHours",
                "userProcessorTimeMinutes","userProcessorTimeSeconds","userProcessorTimeFraction"};

    protected void Page_Load(object sender, EventArgs e)
    {
        Debug.WriteLine(Request.QueryString["exceptionId"]);
     
        if(!IsPostBack)
        {
            _exceptionId = Request.QueryString["exceptionId"];
            if (string.IsNullOrEmpty(_exceptionId))
            {
                Response.Write("Invalid exception id");
                return;
            }

            if (!LoadException())
                return;

            LoadInnerExceptions();
            LoadExceptionData();
            LoadTargetSite();
            LoadAdditionalData();
            LoadDiagnosticInfo();
            LoadExceptionProperties();
            LoadExceptionFields();
        }
    }

    private bool LoadException()
    {
        // Declare the query string.
        string queryString =
            string.Format("Select * FROM [Exception] WHERE [id]='{0}'",
                _exceptionId);

        // Run the query and bind the resulting DataSet
        // to the GridView control.
        DataSet ds = GetData(queryString);
        if (ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
        {
            _dvException.DataSource = ds;
            _dvException.DataBind();
        }
        else
        {
            _lnkException.Enabled = false;
            _lblException.Text = "Invalid exception id: " + _exceptionId;
            _dvException.Visible = false;
            return false;
        }
        return true;
    }

    private void LoadInnerExceptions()
    {
        // Get the dataset for the inner exceptions
        string queryString =
            "SELECT Exception.id, Exception.description, Exception.dateTime, Exception.exceptionType, Exception.exceptionMessage, Exception.source, " +
            "      Exception.helpLink, Exception.exceptionDataId, Exception.targetSiteId, Exception.stackTrace, Exception.additionalInfoId, Exception.diagnosticInfoId, " +
            "      InnerExceptions.exceptionId, InnerExceptions.innerExceptionId " +
            "FROM Exception INNER JOIN InnerExceptions " +
            "ON Exception.id <> InnerExceptions.exceptionId AND Exception.id = InnerExceptions.innerExceptionId";
        DataSet innerDS = GetData(queryString);
        if (innerDS.Tables.Count > 0 && innerDS.Tables[0].Rows.Count > 0)
        {
            _gvInnerExceptions.DataSource = innerDS;
            _gvInnerExceptions.DataBind();
        }
        else
        {
            _lnkInner.Enabled = false;
            _lblInner.Visible = false;
            _gvInnerExceptions.Visible = false;
        }
    }

    private void LoadExceptionData()
    {
        // Get the exception data for the exception
        string queryString =
            string.Format("SELECT [dataKey],[dataValue] FROM [Exception],[ExceptionData] " +
                "WHERE [Exception].[exceptionDataId]=[ExceptionData].[id] AND " +
                "[Exception].[id]='{0}'",
                _exceptionId);

        DataSet exDataDS = GetData(queryString);
        if (exDataDS.Tables.Count > 0 && exDataDS.Tables[0].Rows.Count > 0)
        {
            _gvExceptionData.DataSource = exDataDS;
            _gvExceptionData.DataBind();
        }
        else
        {
            _lnkExceptionData.Enabled = false;
            _lblExceptionData.Visible = false;
            _gvExceptionData.Visible = false;
        }
    }

    private void LoadTargetSite()
    {
        // Get the target site info for the exception
        string queryString =
            string.Format("SELECT [name],[callingConvention],[declaringType],[memberType],[token],[declaringModule],[genericArgumentsId] " +
                "FROM [Exception],[TargetSite] " +
                "WHERE [Exception].[targetSiteId]=[TargetSite].[id] AND " +
                "[Exception].[id]='{0}'",
                _exceptionId);

        DataSet tgtSiteDS = GetData(queryString);
        string genericArgumentsId = "";
        _lblGenArg.Visible = false;
        _dlGenericArguments.Visible = false;
        if (tgtSiteDS.Tables.Count > 0 && tgtSiteDS.Tables[0].Rows.Count > 0)
        {
            this._dtlTargetSite.DataSource = tgtSiteDS;
            this._dtlTargetSite.DataBind();
            genericArgumentsId = ((Guid)tgtSiteDS.Tables[0].Rows[0]["genericArgumentsId"]).ToString();

            if (!string.IsNullOrEmpty(genericArgumentsId))
            {
                queryString =
                    string.Format("SELECT [GenericArguments].[type] " +
                        "FROM [GenericArguments] " +
                        "WHERE [GenericArguments].[id]='{0}'",
                        genericArgumentsId);

                DataSet genArgDS = GetData(queryString);
                if (genArgDS.Tables.Count > 0 && genArgDS.Tables[0].Rows.Count > 0)
                {
                    _lnkGenArgs.Visible = true;
                    _lblGenArg.Visible = true;
                    _dlGenericArguments.Visible = true;
                    this._dlGenericArguments.DataSource = genArgDS;
                    this._dlGenericArguments.DataBind();
                }
                else
                {
                    _lnkGenArgs.Enabled = false;
                    _lblGenArg.Visible = false;
                    _dlGenericArguments.Visible = false;
                }
            }
        }
        else
        {
            _lnkTgtSite.Enabled = false;
            _lblTgtSite.Visible = false;
            _dtlTargetSite.Visible = false;
        }
    }

    private void LoadAdditionalData()
    {
        // Get the additional data for the exception
        string queryString =
            string.Format("SELECT [name],[value] FROM [Exception],[AdditionalInfo] " +
                "WHERE [Exception].[additionalInfoId]=[AdditionalInfo].[id] AND " +
                "[Exception].[id]='{0}'",
                _exceptionId);

        DataSet addDataDS = GetData(queryString);
        if (addDataDS.Tables.Count > 0 && addDataDS.Tables[0].Rows.Count > 0)
        {
            this._gvAdditionalInfo.DataSource = addDataDS;
            this._gvAdditionalInfo.DataBind();
        }
        else
        {
            _lnkAdditionalInfo.Enabled = false;
            _lblAdditionalInfo.Visible = false;
            _gvAdditionalInfo.Visible = false;
        }
    }

    private void LoadDiagnosticInfo()
    {
        // Get the diagnostic info for the exception
        string queryString =
            string.Format("SELECT D.* " +
                "FROM [Exception] E,[DiagnosticInfo] D " +
                "WHERE E.[diagnosticInfoId]=D.[id] AND " +
                "E.[id]='{0}'",
                _exceptionId);

        DataSet diagDS = GetData(queryString);
        string id = "";
        if (diagDS.Tables.Count > 0 && diagDS.Tables[0].Rows.Count > 0)
        {
            this._dvDiagnosticInfo.DataSource = diagDS;
            this._dvDiagnosticInfo.DataBind();

            id = (diagDS.Tables[0].Rows[0]["processInfoId"]).ToString();
            if (!string.IsNullOrEmpty(id))
            {
                LoadProcessInfo(id);
            }
            else
            {
                this._lnkProcessInfo.Enabled = false;
                this._lblProcessInfo.Visible = false;
                this._dvProcessInfo.Visible = false;
            }

            id = (diagDS.Tables[0].Rows[0]["hostEnvironmentId"]).ToString();
            if (!string.IsNullOrEmpty(id))
            {
                LoadHostEnvironment(id);
            }
            else
            {
                this._lnkHostEnv.Enabled = false;
                this._lblHostEnv.Visible = false;
                this._dvHostEnv.Visible = false;
            }
        }
        else
        {
            _lnkDiagnosticInfo.Enabled = false;
            _lblDiagInfo.Visible = false;
            _dvDiagnosticInfo.Visible = false;
        }
    }

    private void LoadHostEnvironment(string id)
    {
        // Get the host environment for the exception
        string queryString =
            string.Format("SELECT * FROM [HostEnvironment]" +
                "WHERE [id]='{0}'",
                id);

        DataSet hostEnvDS = GetData(queryString);
        if (hostEnvDS.Tables.Count > 0 && hostEnvDS.Tables[0].Rows.Count > 0)
        {
            this._dvHostEnv.DataSource = hostEnvDS;
            this._dvHostEnv.DataBind();
        }
        else
        {
            this._lnkHostEnv.Enabled = false;
            this._lblHostEnv.Visible = false;
            this._dvHostEnv.Visible = false;
        }
    }

    private void LoadProcessInfo(string id)
    {
        // Get the process info for the exception
        string queryString =
            string.Format("SELECT * FROM [ProcessInfo] " +
                "WHERE [id]='{0}'", id);

        DataSet procInfoDS = GetData(queryString);
        string innerId = "";
        if (procInfoDS.Tables.Count > 0 && procInfoDS.Tables[0].Rows.Count > 0)
        {
            this._dvProcessInfo.DataSource = procInfoDS;
            this._dvProcessInfo.DataBind();

            innerId = ((Guid)procInfoDS.Tables[0].Rows[0]["startInfoId"]).ToString();
            if (!string.IsNullOrEmpty(innerId))
            {
                LoadStartInfo(innerId);
            }
            else
            {
                this._lnkStartInfo.Enabled = false;
                this._lblStartInfo.Visible = false;
                this._dvStartInfo.Visible = false;
            }

            innerId = ((Guid)procInfoDS.Tables[0].Rows[0]["processEnvironmentId"]).ToString();
            if (!string.IsNullOrEmpty(innerId))
            {
                LoadEnvVar(innerId, this._gvProcessEnvVar, this._lblProcEnvVar, this._lnkProcessEnvVar);
            }
            else
            {
                this._gvProcessEnvVar.Enabled = false;
                this._lblProcEnvVar.Visible = false;
                this._lnkProcessEnvVar.Visible = false;
            }
        }
        else
        {
            this._lnkProcessInfo.Enabled = false;
            this._lblProcessInfo.Visible = false;
            this._dvProcessInfo.Visible = false;
        }
    }

    private void LoadStartInfo(string id)
    {
        // Get the start info for the exception
        string queryString =
            string.Format("SELECT * FROM [StartInfo] " +
                "WHERE [id]='{0}'", id);

        DataSet startInfoDS = GetData(queryString);
        string innerId = "";
        if (startInfoDS.Tables.Count > 0 && startInfoDS.Tables[0].Rows.Count > 0)
        {
            this._dvStartInfo.DataSource = startInfoDS;
            this._dvStartInfo.DataBind();

            innerId = ((Guid)startInfoDS.Tables[0].Rows[0]["startInfoEnvironmentId"]).ToString();
            if (!string.IsNullOrEmpty(innerId))
            {
                LoadEnvVar(innerId, this._gvStartInfoEnvVar, this._lblStartInfoEnvVar, this._lnkStartInfoEnvVar);
            }
            else
            {
                this._gvStartInfoEnvVar.Enabled = false;
                this._lblStartInfoEnvVar.Visible = false;
                this._lnkStartInfoEnvVar.Visible = false;           
            }

            innerId = ((Guid)startInfoDS.Tables[0].Rows[0]["verbsId"]).ToString();
            if (!string.IsNullOrEmpty(innerId))
            {
                LoadVerbs(innerId);
            }
            else
            {
                _lnkVerbs.Enabled = false;
                _lblVerbs.Visible = false;
                _dlVerbs.Visible = false;
            }
        }
        else
        {
            this._lnkStartInfo.Enabled = false;
            this._lblStartInfo.Visible = false;
            this._dvStartInfo.Visible = false;
        }
    }

    private void LoadEnvVar(string id, GridView gv, Label lbl, HyperLink lnk)
    {
        // Get the specific environment variables for the exception
        string queryString =
            string.Format("SELECT * FROM [EnvironmentVariables] " +
                "WHERE [id]='{0}'", id);

        DataSet procInfoEnvVarDS = GetData(queryString);
        if (procInfoEnvVarDS.Tables.Count > 0 && procInfoEnvVarDS.Tables[0].Rows.Count > 0)
        {
            gv.DataSource = procInfoEnvVarDS;
            gv.DataBind();
        }
        else
        {
            lnk.Enabled = false;
            lbl.Visible = false;
            gv.Visible = false;
        }
    }
    
    private void LoadVerbs(string id)
    {
        // Get the specific environment variables for the exception
        string queryString =
            string.Format("SELECT * FROM [Verbs] " +
                "WHERE [id]='{0}'", id);

        DataSet verbsDS = GetData(queryString);
        if (verbsDS.Tables.Count > 0 && verbsDS.Tables[0].Rows.Count > 0)
        {
            _dlVerbs.DataSource = verbsDS;
            _dlVerbs.DataBind();
        }
        else
        {
            _lnkVerbs.Enabled = false;
            _lblVerbs.Visible = false;
            _dlVerbs.Visible = false;
        }
    }

    private void LoadExceptionProperties()
    {
        // Get the additional data for the exception
        string queryString =
            string.Format("SELECT [propertyName],[propertyValue] FROM [Exception],[ExceptionProperties] " +
                "WHERE [Exception].[propertiesId]=[ExceptionProperties].[id] AND " +
                "[Exception].[id]='{0}'",
                _exceptionId);

        DataSet propertiesDS = GetData(queryString);
        if (propertiesDS.Tables.Count > 0 && propertiesDS.Tables[0].Rows.Count > 0)
        {
            this._gvExceptionProperties.DataSource = propertiesDS;
            this._gvExceptionProperties.DataBind();
        }
        else
        {
            _lnkExceptionProperties.Enabled = false;
            _lblExceptionProperties.Visible = false;
            _gvExceptionProperties.Visible = false;
        }
    }

    private void LoadExceptionFields()
    {
        // Get the additional data for the exception
        string queryString =
            string.Format("SELECT [fieldName],[fieldValue] FROM [Exception],[ExceptionFields] " +
                "WHERE [Exception].[fieldsId]=[ExceptionFields].[id] AND " +
                "[Exception].[id]='{0}'",
                _exceptionId);

        DataSet fieldsDS = GetData(queryString);
        if (fieldsDS.Tables.Count > 0 && fieldsDS.Tables[0].Rows.Count > 0)
        {
            this._gvExceptionFields.DataSource = fieldsDS;
            this._gvExceptionFields.DataBind();
        }
        else
        {
            _lnkExceptionFields.Enabled = false;
            _lblExceptionFields.Visible = false;
            _gvExceptionFields.Visible = false;
        }
    }

    DataSet GetData(String queryString)
    {
        // Retrieve the connection string stored in the Web.config file.
        String connectionString = ConfigurationManager.ConnectionStrings["CriticalErrorConnectionString"].ConnectionString;
        DataSet ds = new DataSet();

        // Connect to the database and run the query.
        SqlConnection connection = new SqlConnection(connectionString);
        SqlDataAdapter adapter = new SqlDataAdapter(queryString, connection);

        // Fill the DataSet.
        adapter.Fill(ds);
        return ds;
    }

    protected string GenerateTimeSpanString(object dataItem, int timeSpanId)
    {
        string [] fieldNames;
        switch(timeSpanId)
        {
            case 0:  fieldNames = _totalProcessorFieldNames;
                     break;
            case 1:  fieldNames = _userProcessorFieldNames;
                     break;
            default: return "";
                     break;
        }
        int days = (int)DataBinder.Eval(dataItem, fieldNames[0]);
        int hours = (int)DataBinder.Eval(dataItem, fieldNames[1]);
        int mins = (int)DataBinder.Eval(dataItem, fieldNames[2]);
        int secs = (int)DataBinder.Eval(dataItem, fieldNames[3]);
        int fraction = (int)DataBinder.Eval(dataItem, fieldNames[4]);
        TimeSpan ts = new TimeSpan(days, hours, mins, secs, fraction);
        return ts.ToString();
    }
}

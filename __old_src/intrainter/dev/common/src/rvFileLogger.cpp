#include "rvXPComIds.h"

CFileLogger* g_logger = nsnull;

CFileLogger::CFileLogger()
{
	g_logger = nsnull;
	m_indent = 0;
	m_file_name = MozStr("");
	m_log_to_console = PR_TRUE;
}

CFileLogger::~CFileLogger()
{
	g_logger = nsnull;
}

CFileLogger* CFileLogger::CreateInstance()
{
	if (g_logger == nsnull)
		g_logger = new CFileLogger();

	return g_logger;
}

CFileLogger& CFileLogger::GetInstance()
{
	return *g_logger;
}

void CFileLogger::GenerateLogFileName(nsAutoString p_prefix)
{
	// get current time
	time_t t1;
	time(&t1);
	tm *t = localtime(&t1);

	char buf[12];
	sprintf(buf,"%d-%d-%d-%d", t->tm_mday,t->tm_hour,t->tm_min,t->tm_sec);

	m_file_name.Append(PWW_DATA_ROOT);
	m_file_name.Append(PWW_LOG_DIR);
	m_file_name.Append(NS_LITERAL_STRING("\\"));

	if (p_prefix == MozStr(""))
		m_file_name.Append(PWW_LOG_FILE_PREFIX);
	else
		m_file_name.Append(p_prefix);

	m_file_name.AppendWithConversion(buf);
	m_file_name.Append(NS_LITERAL_STRING(".log"));
}

void CFileLogger::CreateLogFile(nsAutoString p_prefix) 
{
	g_logger->GenerateLogFileName(p_prefix);
	char name[1024];
	g_logger->m_file_name.ToCString(name,1024);
	g_logger->m_file_handle = CreateFile(name, GENERIC_READ|GENERIC_WRITE, FILE_SHARE_READ|FILE_SHARE_WRITE, NULL,CREATE_ALWAYS,0,NULL);
}

void CFileLogger::CloseLogFile()
{
	if (m_file_handle != NULL)
		CloseHandle(m_file_handle);
}

void CFileLogger::Destroy()
{
	if (g_logger == nsnull)
		return;

	g_logger->CloseLogFile();
	g_logger->m_indent = 0;
	g_logger->m_file_name = MozStr("");
	delete g_logger;
	g_logger = nsnull;
}

void CFileLogger::LogToConsole(PRBool yes)
{
	m_log_to_console = yes;
}

// ===== THE WRITING TO LOG FILE/STDOUT =====================
void CFileLogger::WriteToTargets(II_LogLevel p_level)
{
	if (!this)
		return;

	if (p_level == IILL_Debug)
	{
		m_buffer=MozStr("");
		return;
	}

	// this will hold th whole message, data/time/thread/level/message string
	nsAutoString msg;

	// time
	time_t t1;
	time(&t1);
	tm *t = localtime(&t1);
	char tbuf[14];
	sprintf(tbuf,"[%2d:%2d:%2d]", t->tm_hour,t->tm_min,t->tm_sec);
	msg.AppendWithConversion(tbuf);

	// thread
	long id = GetCurrentThreadId();
	char threadbuf[8];
	sprintf(threadbuf, "[%d]", id);
	msg.AppendWithConversion(threadbuf);

	// level
	nsAutoString level;
	switch (p_level)
	{
		case IILL_Fatal:
			msg.Append(NS_LITERAL_STRING("[FTL]"));
			break;
		case IILL_Error:
			msg.Append(NS_LITERAL_STRING("[ERR]"));
			break;
		case IILL_Exception:
			msg.Append(NS_LITERAL_STRING("[EXC]"));
			break;
		case IILL_Info:
			msg.Append(NS_LITERAL_STRING("[INF]"));
			break;
		case IILL_Debug:
			msg.Append(NS_LITERAL_STRING("[DBG]"));
			break;
	}

	// indent stirng
	nsAutoString non_indent_msg;
	non_indent_msg.Append(msg);
	non_indent_msg.Append(NS_LITERAL_STRING(" "));
	msg.Append(m_indent_string);

	// message data
	msg.Append(m_buffer);
	non_indent_msg.Append(m_buffer);
	msg.Append(NS_LITERAL_STRING("\r\n"));	
	non_indent_msg.Append(NS_LITERAL_STRING("\r\n"));	

	// TODO: escaping text that printf will not like
	non_indent_msg.ReplaceChar('%', '-');
	//msg.ReplaceChar('%', '-');

	// convert the whole message to char*
	char msgbuf[1024];
	non_indent_msg.ToCString(msgbuf, 1024);

	// display to stdout without indent
	if (m_log_to_console)
		printf(msgbuf);

	// display with indent for file
	msg.ToCString(msgbuf, 1024);

	// unset buffers for next message
	non_indent_msg = MozStr("");
	m_buffer = MozStr("");

	// write to file
	if (m_file_handle != NULL)
	{
			unsigned long written;
			WriteFile(m_file_handle, msgbuf, strlen(msgbuf), &written, NULL);
	}
}

void CFileLogger::AppendBuffer(nsAutoString p_msg)
{
	if (!this)
		return;
	
	m_buffer.Append(p_msg);
}

void CFileLogger::WriteLog(nsAutoString logdata) 
{
	AppendBuffer(logdata);
}

void CFileLogger::WriteLog(const char* logdata) 
{
	nsAutoString data;
	CopyASCIItoUTF16(logdata, data);
	WriteLog(data);
}

void CFileLogger::WriteLog(nsCAutoString logdata)
{
	nsAutoString data;
	CopyASCIItoUTF16(logdata, data);
	WriteLog(data);
}

void CFileLogger::WriteLog(nsCString logdata)
{
	nsAutoString data;
	CopyASCIItoUTF16(logdata, data);
	WriteLog(data);
}

void CFileLogger::WriteLog(nsString logdata)
{
	nsAutoString data;
	//CopyASCIItoUTF16(logdata, data);
	WriteLog(data);
}

void CFileLogger::WriteLog(PRFloat64 fdata) 
{
	nsAutoString data;
	data.AppendFloat(fdata);
	WriteLog(data);
}

void CFileLogger::WriteLog(PRInt32 logdata)
{
	nsAutoString data;
	data.AppendInt(logdata);
	WriteLog(data);
}

void CFileLogger::WriteLog(PRUint32 logdata)
{
	nsAutoString data;
	data.AppendInt(logdata);
	WriteLog(data);
}

void CFileLogger::WriteLog(II_LogLevel p_level)
{
	WriteToTargets(p_level);	
}

CFileLogger& CFileLogger::operator << (char* logdata)
{
	WriteLog(logdata);
	return *this;
}

CFileLogger& CFileLogger::operator << (nsAutoString logdata)
{
	WriteLog(logdata);
	return *this;
}

CFileLogger& CFileLogger::operator << (nsCAutoString logdata)
{
	WriteLog(logdata);
	return *this;
}

CFileLogger& CFileLogger::operator << (nsCString logdata)
{
	WriteLog(logdata);
	return *this;
}

CFileLogger& CFileLogger::operator << (nsString logdata)
{
	WriteLog(logdata);
	return *this;
}

CFileLogger& CFileLogger::operator << (PRInt32 logdata)
{
	WriteLog(logdata);
	return *this;
}

CFileLogger& CFileLogger::operator << (PRUint32 logdata)
{
	WriteLog(logdata);
	return *this;
}

CFileLogger& CFileLogger::operator << (PRFloat64 logdata)
{
	WriteLog(logdata);
	return *this;
}

void CFileLogger::operator << (II_LogLevel p_log_level)
{
	WriteLog(p_log_level);
}

void CFileLogger::operator ++()
{
	if (!this)
		return;

	m_indent_string = MozStr("");
	m_indent++;
	if (m_indent < 1)
		return;

	for (PRInt32 idx=0;idx<m_indent;idx++)
		m_indent_string.Append(NS_LITERAL_STRING("   |"));

	m_indent_string.Append(NS_LITERAL_STRING("---"));
}

void CFileLogger::operator --()
{
	if (!this)
		return;

	m_indent_string = MozStr("");
	m_indent--;
	if (m_indent < 1)
		return;

	for (PRInt32 idx=0;idx<m_indent;idx++)
		m_indent_string.Append(NS_LITERAL_STRING("   |"));

	m_indent_string.Append(NS_LITERAL_STRING("---"));
}

#ifndef __FILE_LOGGER_H
#define __FILE_LOGGER_H

#include "rvXPComIds.h"

enum II_LogLevel
{
	IILL_Fatal = 0,
	IILL_Error = 1,
	IILL_Exception = 2,
	IILL_Info = 3,
	IILL_Debug = 4
};

class CFileLogger
{
private:
	HANDLE m_file_handle;
	PRInt32 m_indent;
	nsAutoString m_indent_string;
	nsAutoString m_file_name;
	nsAutoString m_buffer;

private:
	CFileLogger();
	~CFileLogger();

public:
	static CFileLogger* CreateInstance();
	static void CreateLogFile(nsAutoString p_prefix);
	static CFileLogger& GetInstance();
	static void Destroy();

	void GenerateLogFileName(nsAutoString p_prefix);
	void WriteToTargets(II_LogLevel p_level);
	void AppendBuffer(nsAutoString logdata);

	void WriteLog(const char* logdata); 
	void WriteLog(nsAutoString logdata);
	void WriteLog(nsCAutoString logdata);
	void WriteLog(nsCString logdata);
	void WriteLog(nsString logdata);
	void WriteLog(PRInt32 logdata);
	void WriteLog(PRUint32 logdata);
	void WriteLog(PRFloat64 fdata);
	void WriteLog(II_LogLevel p_level);

	CFileLogger& operator << (char* logdata);
	CFileLogger& operator << (nsAutoString logdata);
	CFileLogger& operator << (nsCAutoString logdata);
	CFileLogger& operator << (nsCString logdata);
	CFileLogger& operator << (nsString logdata);
	CFileLogger& operator << (PRInt32 logdata);
	CFileLogger& operator << (PRUint32 logdata);
	CFileLogger& operator << (PRFloat64 logdata);
	void operator << (II_LogLevel p_log_level);

	void operator ++();
	void operator --();
	void CloseLogFile();
};

#endif

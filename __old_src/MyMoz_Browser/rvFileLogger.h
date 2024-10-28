#ifndef __FILE_LOGGER_H
#define __FILE_LOGGER_H

#include "rvXPComIds.h"
#include <time.h>
#include <windows.h>
class CFileLogger
{
private:
	HANDLE fileHandle;
	
public:
	CFileLogger()
	{
	}

	nsCString fileName;

public:
	void CreateLogFileName()
	{
		// get current time
		time_t t1;
		time(&t1);
		tm *t = localtime(&t1);

		char buf[12];
		sprintf(buf,"%d_%d_%d_%d", t->tm_mday,t->tm_hour,t->tm_min,t->tm_sec);
		fileName.Append("C:\\MyMozFiles\\LogDir\\");
		fileName.Append("MyMozLogFile_");
		fileName.Append(buf);
			
		fileName.Append(".log");
	}

	void CreateLogFile() 
	{
		CreateLogFileName();
		const char* name  = fileName.Data();
		fileHandle = CreateFile(name, GENERIC_READ|GENERIC_WRITE, FILE_SHARE_READ|FILE_SHARE_WRITE, NULL,CREATE_ALWAYS,0,NULL);
	}

	void WriteLog(const char* level, const char* logdata) 
	{
		time_t t1;
		time(&t1);
		tm *t = localtime(&t1);
		char tbuf[12];
		sprintf(tbuf,"%d:%d:%d", t->tm_hour,t->tm_min,t->tm_sec);

		long id = GetCurrentThreadId();
		char threadbuf[4];
		sprintf(threadbuf, "%d", id);

		printf("[");
		printf(tbuf);
		printf("]");

		printf("[");
		printf(threadbuf);
		printf("]");

		printf("[");
		printf(level);
		printf("]");

		printf(logdata);
		printf("\n");

		if (fileHandle != NULL)
		{
				unsigned long written;
				WriteFile(fileHandle, "[", 1, &written, NULL);
				WriteFile(fileHandle, tbuf, strlen(tbuf), &written, NULL);
				WriteFile(fileHandle, "]", 1, &written, NULL);

				WriteFile(fileHandle, "[", 1, &written, NULL);
				WriteFile(fileHandle, threadbuf, strlen(threadbuf), &written, NULL);
				WriteFile(fileHandle, "]", 1, &written, NULL);

				WriteFile(fileHandle, "[", 1, &written, NULL);
				WriteFile(fileHandle, level, strlen(level), &written, NULL);
				WriteFile(fileHandle, "]", 1, &written, NULL);

				WriteFile(fileHandle, logdata, strlen(logdata), &written, NULL);

				WriteFile(fileHandle, "\r\n", 2, &written, NULL);
		}
	}
	
	void WriteLog(char* level, nsAutoString logdata) 
	{
		long len = logdata.Length();
		char* tempbuf = new char[len+1];
		logdata.ToCString(tempbuf, len+1);

		WriteLog(level, tempbuf);
		delete tempbuf;
	}

	void WriteLog(char* level, nsString logdata) 
	{
		long len = logdata.Length();
		char* tempbuf = new char[len+1];
		logdata.ToCString(tempbuf, len+1);

		WriteLog(level, tempbuf);
		delete tempbuf;
	}
	
	void WriteLog(char* level, PRFloat64 fdata) 
	{
		nsAutoString logdata;
		logdata.AppendFloat(fdata);

		long len = logdata.Length();
		char* tempbuf = new char[len+1];
		logdata.ToCString(tempbuf, len+1);

		WriteLog(level, tempbuf);
		delete tempbuf;
	}

	void CloseLogFile()
	{
		if (fileHandle != NULL)
			CloseHandle(fileHandle);
	}
};

#endif

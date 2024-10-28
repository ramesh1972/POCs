#pragma warning(disable:4786)

#ifndef __MESSAGES_H
#define __MESSAGES_H

#include "rvXPCOMIDs.h"

class CTextMessages
{
private:
	std::map<long, std::string> m_msgs;

private:
	CTextMessages();
	~CTextMessages();

public:
	static CTextMessages* CreateInstance();
	static void LoadMessages();
	static CTextMessages& GetInstance();
	static void Destroy();

	void AddMessage(long p_code, const char* p_error_str);
	char* GetMessage(long p_code);
	void SortMessages();

};

#endif

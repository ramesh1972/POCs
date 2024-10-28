#pragma warning(disable:4786)

#include "rvXPCOMIDs.h"
#include "rvMessageList.h"

// singletop global 
CTextMessages* g_msgs = nsnull;

CTextMessages::CTextMessages()
{
	g_msgs = nsnull;
}

CTextMessages::~CTextMessages()
{
	g_msgs = nsnull;
}

CTextMessages* CTextMessages::CreateInstance()
{
	if (g_msgs == nsnull)
		g_msgs = new CTextMessages();

	return g_msgs;
}

CTextMessages& CTextMessages::GetInstance()
{
	return *g_msgs;
}

void CTextMessages::LoadMessages()
{
	LoadGlobalMessages();
}

void CTextMessages::AddMessage(long p_code, const char* p_error_str)
{
	if (p_error_str == nsnull)
		return;

	// check if the message already exists
	std::string existing = m_msgs[p_code];
	if (!existing.empty())
		return;

	// create a copy
	m_msgs[p_code] = p_error_str;
}

char* CTextMessages::GetMessage(long p_code)
{
	return (char*) m_msgs[p_code].c_str();
}

bool key_compare_func(std::pair<long, std::string> one, std::pair<long, std::string> one_after)
{
	if (one.first >= one_after.first)
		return true;
	else
		return false;
}

void CTextMessages::SortMessages()
{
	//std::sort(m_msgs.begin(), m_msgs.end(), key_compare_func);
}

void CTextMessages::Destroy()
{
	delete g_msgs;
	g_msgs = nsnull;
}


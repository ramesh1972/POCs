#include "rvXPCOMIds.h"
#include "rvDB.h"


rvDB::rvDB()
{
	m_cnn = NULL;
}

rvDB::~rvDB()
{
	disconnect();
}

bool rvDB::connect_to_db()
{
		return connect_to_db(II_HOST, II_DATABASE, II_USER, II_PASSWORD);
}

bool rvDB::connect_to_db(char* server, char* db, char* user, char* pwd)
{
	try
	{
		disconnect();
		m_cnn= new Connection(use_exceptions);
		m_cnn->real_connect (II_DATABASE,II_HOST,II_USER,II_PASSWORD,3306,(int)0,60,NULL);

		return true;
	}
	catch(...)
	{
		return false;
	}
}

void rvDB::disconnect()
{
	if (m_cnn)
	{
			m_cnn->close();
			delete m_cnn;
			m_cnn = NULL;
	}
}

bool rvDB::is_connected()
{
	if (m_cnn)
			return m_cnn->connected();

	return false;
}

bool rvDB::select_db(char* db)
{
	if (m_cnn)
		return m_cnn->select_db(db);

	return false;
}

void rvDB::query(string qry, rvDBResult &res)
{
	if (qry.empty())
			return;

	connect_to_db();
	rvDBQuery q = m_cnn->query();

	q << qry.c_str();

	res = q.store();
}

string rvDB::error()
{
	return m_cnn->error();
}

bool is_quoted_field(int field_type)
{
	if (field_type == FIELD_TYPE_DECIMAL ||
			field_type == FIELD_TYPE_TINY ||
			field_type == FIELD_TYPE_SHORT ||
			field_type == FIELD_TYPE_LONG ||
			field_type == FIELD_TYPE_FLOAT ||
			field_type == FIELD_TYPE_DOUBLE ||
			field_type == FIELD_TYPE_INT24 ||
			field_type == FIELD_TYPE_LONGLONG)
			return false;

	return true;
}


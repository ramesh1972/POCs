#ifndef __RV_DB_
#define __RV_DB_

#include <mysql++>

#define rvDBQuery Query
#define rvDBResult Result

#define II_HOST     "localhost"
#define II_DATABASE	"test"
#define II_USER     "root"
#define II_PASSWORD "root"

bool is_quoted_field(int field_type);

class rvDB
{
public:
	Connection* m_cnn;

public:
	rvDB();
	~rvDB();

	bool connect_to_db();
	bool connect_to_db(char* server, char* db, char* user, char* pwd);
	void disconnect();

	bool is_connected();

	bool select_db(char* db);

	void query(string qry, rvDBResult& res);

	string error();
};

#endif
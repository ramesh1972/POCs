#ifndef _DB_TO_XML__
#define _DB_TO_XML__

#include "rvXPCOMIds.h"
#include "rvXMLDocument.h"
#include "rvDB.h"
#include <string>
#include <set>

// column header struct
struct jsdb_column
{
	string m_col_name;
	bool m_is_part_of_table;
	bool m_is_primary_key;
	bool m_is_identity;
	bool m_is_timestamp;

	enum_field_types m_col_type;
	bool m_need_quotes;

	nsIDOMElement* m_table_head_in_data_doc;
};

struct jsdb_column_data
{
	string m_col_value;
	int dirty_flag;
	int substitute_flag; // 0- no sub, 1-identity, 2-external

	nsIDOMElement* m_data_col_in_data_doc;
}

struct jsdb_row
{
	string m_sql;
	int sql_type; // 0-select, 1-insert, 2-update, 3-delete

	map<int, jsdb_column_data> m_data_cols;
	nsIDOMElement* m_sql_row_in_data_doc;
};

// table header struct
struct jsdb_table
{
	string m_name;
	long m_cnn_id;

	std::map<int, jsdb_column> m_cols_info;
	std::map<int, jsdb_row> m_rows;

	nsIDOMElement* m_table_in_data_doc;
};

typedef std::map<int, jsdb_table> jsdb_tables;

class jsdb_s
{
	private:
		rvXmlDocument* m_client_db_doc;
		jsdb_tables m_tables;
		map<string, string> m_substitutions; // xpath to column data and the value got from the database
		
		void create_db_doc(string xml);
		bool remove_row(nsIDOMNode* row);

		nsIDOMElement* check_if_table_exists(nsIDOMElement* table);
		nsIDOMElement* check_if_row_exists(nsIDOMElement* data, nsIDOMElement* row);
		void add_table(nsIDOMElement* table);
		void set_clean_row(nsIDOMElement* row);

	public:
		jsdb_s();
		~jsdb_s();

		string get_client_db_data(); // returns the xml of m_data_out, mainly to send it to the browser
		void set_client_db_data(string xml);

		nsIDOMNodeList* get_client_table(string table, string cnn_id) {}
		nsIDOMNodeList* get_client_db_rows(string table, string cnn_id, string columns_string, string cond_string) {}

		bool xml2db() {} // all data in this doc
		bool xml2db(string xml);
		bool xml2db(int tblid) {}
		bool xml2db(nsIDOMNodeList* rows) {}
		bool xml2db(nsIDOMNode* row) {}

		bool db2xml(int cnn_id, string table, string query);
};

string get_section(long root_id, bool deep);
#endif

// NOTES: 
// change jsdb to memdb, remove _s
// use nsIDOMNode* instead of nsIDOMElement* in the public interface always.

/*
// public
bool xml2db(); // the whole thing
bool db2xml(int cnn, string table, string sql_query);

string get_jsdb_string(); // returns the xml of m_data_out, mainly to send it to the browser
bool set_jsdb_string(string jsdb_xml); // jsdb xml starting with <JSDB><Cnn><Table>Rows..<Table>..<Connection>... 

void clean_jsdb();
void clean_connection(nsIDOMNode* cnn);
void clean_table(nsIDOMNode* table);
void clean_row(nsIDOMNode* row);
void clean_rows(nsIDOMNode* rows);

// cons/dest
jsdb_s();
~jsdb_s();

// table
bool xml2db(int cnn, string table);
bool xml2db(nsIDOMNode* cnn, string table);
bool xml2db(nsIDOMNode* table);
nsIDOMNode* get_cnn(int cnn);
nsIDOMNode* get_table(int cnn, string table);
nsIDOMNode* get_table(nsIDOMNode* cnn string table);

// col info
nsIDOMNode* get_col_info(int cnn, string table, int index);
nsIDOMNode* get_col_info(nsIDOMNode* cnn, string table, int index);
nsIDOMNode* get_col_info(nsIDOMNode* table, int index);
bool db2xml_col_info(int cnn, string table);
bool db2xml_col_info(nsIDOMNode* table);
bool db2xml_col_info(nsIDOMNode* cnn, string table);

// rows
bool xml2db(nsIDOMNodeList* rows);
nsIDOMNodeList* get_rows(int cnn, string table);
nsIDOMNodeList* get_rows(nsIDOMNode* cnn, string table);
nsIDOMNodeList* get_rows(nsIDOMNode* table);
bool db2xml(nsIDOMNode* table, string sql_query);
bool db2xml(nsIDOMNode* cnn, string table, string sql_query);

// row
bool xml2db_row(nsIDOMNode* row);
nsIDOMNode* get_row(int cnn, string table, list<string> cols, multimap<int, string> conditions); // conditions-int is the col number. 
																																			// conditions are like c++ cond type. first 2 chars are the condition.

nsIDOMNode* get_row(nsIDOMNodeList* rows, list<string> cols, multimap<int, string> conditions); // conditions-int is the col number. 

nsIDOMNode* new_row(nsIDOMNode* table);
nsIDOMNode* update_row(nsIDOMNode* row_node);
nsIDOMNode* insert_row(nsIDOMNode* table, nsIDOMNode* row_node);
nsIDOMNode* delete_row(nsIDOMNode* table, nsIDOMNode* row_node);

// col is <C>value</C> node
bool xml2db_col(nsIDOMNode* row, int col);
void get_col_value(nsIDOMNode* col, string &val);
void get_col_value(nsIDOMNode* col, int &val);
void get_col_value(nsIDOMNode* col, bool &val);
void get_col_value(nsIDOMNode* col, double &val);
void get_col_value(nsIDOMNode* col, long &val);

void set_col_value(nsIDOMNode* col, string val);
void set_col_value(nsIDOMNode* col, int val);
void set_col_value(nsIDOMNode* col, bool val);
void set_col_value(nsIDOMNode* col, double val);
void set_col_value(nsIDOMNode* col, long val);

// attributes
int get_dirty_flag(nsIDOMNode* db_node);
void set_dirty_flag(nsIDOMNode* db_node, int flag);
void set_col_dirty(nsIDOMNode* col_node, int flag);

int get_int_attribute_value(nsIDOMNode* db_node, string attr, string val);
bool get_bool_attribute_value(nsIDOMNode* db_node, string attr, int val);
string get_string_attribute_value(nsIDOMNode* db_node, string attr, long val);
long get_long_attribute_value(nsIDOMNode* db_node, string attr, double val);

int set_attribute_value(nsIDOMNode* db_node, string attr, string val);
int set_attribute_value(nsIDOMNode* db_node, string attr, int val);
int set_attribute_value(nsIDOMNode* db_node, string attr, long val);
int set_attribute_value(nsIDOMNode* db_node, string attr, double val);

// checks
nsIDOMElement* check_if_table_exists(nsIDOMElement* table);
nsIDOMElement* check_if_row_exists(nsIDOMElement* data, nsIDOMElement* row);

// query related

// utils
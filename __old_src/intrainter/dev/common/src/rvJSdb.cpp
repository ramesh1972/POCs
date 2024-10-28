#include "rvXPCOMIds.h"
#include "rvXmlDocument.h"
#include "rvJSDB.h"	
#include "rvDB.h"
#include "utils.h"

using namespace std;
jsdb_s::jsdb_s()
{
	m_client_db_doc = NULL;
}

jsdb_s::~jsdb_s()
{
	if (m_client_db_doc != NULL)
	{
		m_client_db_doc->Destroy();
		m_client_db_doc = NULL;
	}
}

// public functions
bool jsdb_s::db2xml(int cnn_id, string table, string query)
{
	if (query.empty())
		return false;

	// execute query and fetch result row
	rvDB db;
	rvDBResult res;

	try
	{
		db.query(query, res);

		// convert this result to xml
		string xml;

		//	create a table tag with server, database attributes
		string cnn_attr = " cnn_id='" + utils::stlstr(cnn_id) + string("'");
		xml = "<" + table + cnn_attr + ">";

		// create a head tag with column names
		xml += "<Head>";
		int nfields = res.num_fields();
		FieldNames flds = res.field_names();
		Fields fs(&res);
		for (int idx=0; idx<nfields; idx++)
		{
			Field f = fs[idx];

			int field_type = f.type;
			unsigned int is_key = IS_PRI_KEY(f.flags);
			bool is_part_of_table = strcmp(table.c_str(), f.table)?0:1;
			unsigned int is_identity = f.flags & AUTO_INCREMENT_FLAG;
			unsigned int is_ts = f.flags & TIMESTAMP_FLAG;

			string attr = "";
			if (is_part_of_table)
				attr+= " is_field='1' ";

			if (is_key)
				attr+= " is_key='1' ";

			if (is_identity)
				attr+= " is_identity='1' ";

			if (is_ts)
				attr+= " is_timestamp='1' ";

			char* tmp = "";
			attr+= " field_type='" + utils::stlstr(field_type) + string("' ");
			xml += "<F " + attr + ">" + flds[idx] + "</F>";
		}

		xml += "</Head>";

		// put the rows 
		xml += "<Data>";
		Result::iterator i = res.begin();

		while (i != res.end())
		{
			xml += "<R>";
			for (idx=0; idx<nfields;idx++)
				xml += "<C>" + string((*i)[idx]) + "</C>";
		
			xml += "</R>";
			i++;
		}

		xml += "</Data>";
		xml += "</" + table + ">";
		
		db.disconnect();

		// set the client data
		ILOG << "About to insert db2xml records" << IINF;
		set_client_db_data(xml);
		return true;
	}
	catch(...)
	{
		string err = db.error();
		ILOG << (char*) err.c_str() << IINF;

		return false;
	}
}

// this function has to be called only once by an instance of the cgi application
bool jsdb_s::xml2db(string xml)
{
	// xml = "<JSDB><stock cnn_id=\"0\"><Head><F is_field=\"1\" is_key=\"1\" is_identity=\"1\" field_type=\"3\">idstock</F>
	// <F is_field=\"1\" field_type=\"253\">name</F><F is_field=\"1\" field_type=\"3\">price</F></Head><Data><R><C>1</C>
	// <C>AXG</C><C>10</C></R><R><C>2</C><C>Ramesh</C><C>14</C></R></Data></stock></JSDB>";
	if (xml.empty())
			return false;

	// <- create XML Document ->
	if (m_client_db_doc == NULL)
		set_client_db_data(xml);

	if 	(m_client_db_doc == NULL)
		return false;
	
	// <- iterate through list of tables
	nsIDOMNodeList* tables_list;
	nsIDOMElement* root = m_client_db_doc->GetDocumentElement();
	root->GetChildNodes(&tables_list);
	PRUint32 num_tables = 0;
	tables_list->GetLength(&num_tables);

	for (int idxt = 0; idxt<num_tables; idxt++)
	{
		// get the dom pointer to the table
		nsIDOMNode* table_node;
		tables_list->Item(idxt, &table_node);
		
		// <- get the table name ->
		jsdb_table tbl;
		tbl.m_name = utils::stlstr(m_client_db_doc->GetNodeName((nsIDOMElement*) table_node));
		tbl.m_cnn_id = utils::toint(m_client_db_doc->GetNodeAttributeValue((nsIDOMElement*) table_node, MozStr("cnn_id")));

		// <- get the head and all column info
		nsIDOMElement* head = m_client_db_doc->GetChildNode((nsIDOMElement*) table_node, MozStr("Head"));
		if (head == NULL)
			return false;

		nsIDOMNodeList* fields_list;
		head->GetChildNodes(&fields_list);
		PRUint32 num_fields = 0;
		fields_list->GetLength(&num_fields);
		
		for (PRUint32 idxf = 0; idxf < num_fields; idxf++)
		{
			nsIDOMNode* field_node;
			fields_list->Item(idxf, &field_node);
			
			jsdb_column col;
			string field_name = utils::stlstr(m_client_db_doc->GetNodeValue((nsIDOMElement*) field_node));
			int is_field = utils::toint(m_client_db_doc->GetNodeAttributeValue((nsIDOMElement*) field_node, MozStr("is_field")));
			int is_pk = utils::toint(m_client_db_doc->GetNodeAttributeValue((nsIDOMElement*) field_node, MozStr("is_key")));
			int type = utils::toint(m_client_db_doc->GetNodeAttributeValue((nsIDOMElement*) field_node, MozStr("field_type")));
			int is_identity = utils::toint(m_client_db_doc->GetNodeAttributeValue((nsIDOMElement*) field_node, MozStr("is_identity")));
			int is_timestamp = utils::toint(m_client_db_doc->GetNodeAttributeValue((nsIDOMElement*) field_node, MozStr("is_timestamp")));
			
			col.m_col_name = field_name;
			col.m_col_type = (enum_field_types) type;
			col.m_is_part_of_table = is_field;
			col.m_is_primary_key = is_pk;
			col.m_is_identity = is_identity;
			col.m_is_timestamp = is_timestamp;
			col.m_need_quotes = is_quoted_field(type);
			
			tbl.m_cols[idxf] = col;

			NS_RELEASE(field_node);
		} // end getting of head ->

		NS_RELEASE(head);
		NS_RELEASE(fields_list);

		// <- process the data rows
		// get list of sqls
		// iterate through rows, look for dirty flag 
		nsIDOMElement* data = m_client_db_doc->GetChildNode((nsIDOMElement*) table_node, MozStr("Data"));
		nsIDOMNodeList* rows;
		data->GetChildNodes(&rows);
		PRUint32 num_rows = 0;
		rows->GetLength(&num_rows);

		//	loop through children (rows) and create sql strings
		ILOG << "About to create SQLs" << IINF;
		PRInt32 idxs = 0;
		for (PRUint32 idxr = 0; idxr < num_rows; idxr++)
		{
			nsIDOMNode* row;
			rows->Item(idxr, &row);

			string sql = "";

			// 1 - insert, 2 update, 3 delete
			bool valid_flag = true;
			int dirty_row = utils::toint(m_client_db_doc->GetNodeAttributeValue((nsIDOMElement*) row, MozStr("dirty")));
			if (dirty_row == 2) // create the update sql
				sql = "update " + tbl.m_name + string(" set");
			else if (dirty_row == 3) // create the delete sql
				sql = "delete from " + tbl.m_name;
			else if (dirty_row == 1) // create the delete sql
				sql = "insert into " + tbl.m_name;
			else
				valid_flag = false;

			if (valid_flag)
			{
				ILOG << "dirty row " << dirty_row << IINF;

				// get the fields data
				nsIDOMNodeList* cols;
				row->GetChildNodes(&cols);
				PRUint32 num_cols = 0;
				cols->GetLength(&num_cols);

				//	loop through children (columns) and create update string
				string insert_cols_phrase = "";
				string insert_vals_phrase = "";
				string set_phrase = "";
				string where_clause = "where";
				for (PRUint32 idx2 = 0; idx2 < num_cols; idx2++)
				{
					nsIDOMNode* col;
					cols->Item(idx2, &col);

					ILOG << "checking col " << idx2 << IINF;

					// if this field is a pk, then it will go to the where clause
					string field_value = utils::stlstr(m_client_db_doc->GetNodeValue((nsIDOMElement*) col));
					if (tbl.m_cols[idx2].m_need_quotes)
						field_value = "\"" + field_value + "\"";

					// primary key goes into the where clause
					if (dirty_row != 1 && tbl.m_cols[idx2].m_is_primary_key)
					{
						if (where_clause != "where")
							where_clause+= " and";
						where_clause+= " " + tbl.m_cols[idx2].m_col_name + string("=") + field_value;

						continue;
					}

					if (dirty_row == 3) // if delete then no need to iterate through non pk cols.
						continue;

					// identity/timestamp fields are not updated
					if (tbl.m_cols[idx2].m_is_identity || tbl.m_cols[idx2].m_is_timestamp)
						continue;

					// other columns which need to be updated
					int dirty_col= utils::toint(m_client_db_doc->GetNodeAttributeValue((nsIDOMElement*) col, MozStr("dirty")));
					if (dirty_row == 2 && dirty_col == 2) // if update
					{
							if (set_phrase != "")
								set_phrase += string(", ");

							set_phrase += tbl.m_cols[idx2].m_col_name + string("=") + field_value;
					}
					else if (dirty_row == 1 && dirty_col == 1) // if update
					{
							if (insert_cols_phrase != "")
								insert_cols_phrase += string(", ");

							insert_cols_phrase += tbl.m_cols[idx2].m_col_name;

							if (insert_vals_phrase != "")
								insert_vals_phrase  += string(", ");

							insert_vals_phrase  += field_value;
					
					}

					NS_RELEASE(col);
				}

				NS_RELEASE(cols);

				if (dirty_row == 1) // create the update sql
					sql += " (" + insert_cols_phrase + ") values (" + insert_vals_phrase + ")";
				else if (dirty_row == 2) // create the update sql
					sql += " " + set_phrase + " " + where_clause;
				else if (dirty_row == 3) // create the delete sql
					sql += " " + where_clause;

				ILOG << "formed sql " << (char*) sql.c_str() << IINF;

				// * create the sql object and add it to the sql list for the table
				jsdb_sql sql1;
				sql1.sql_type = dirty_row;
				sql1.m_sql = sql;
				sql1.m_sql_row_in_data_doc = (nsIDOMElement*) row;
				tbl.m_sqls[idxs++] = sql1; 
			}
			else // remove the row
			{
				ILOG << "removing row..." << IINF;
				bool table_removed = remove_row(row);
				idxr = (idxr == num_rows - 1)?idxr:idxr-1;
				num_rows--;
				if (table_removed)
				{
					idxt = (idxt == num_tables - 1)?idxt:idxt-1;
					num_tables--;
				}

				ILOG << "done removing row." << IINF;
			}
		
			NS_RELEASE(row);
		} // end processing rows and generating sqls ->
	
		NS_RELEASE(rows);
		NS_RELEASE(data);

		// add this table to the list
		m_tables[idxt] = tbl;

		NS_RELEASE(table_node);
	} // end iteration of tables ->

	NS_RELEASE(tables_list);

	ILOG << "about to execute sqls.." << IINF;

	// now execute all the sqls
	string return_xml = "";
	rvDB db;
	jsdb_tables::iterator it = m_tables.begin();

	ILOG << "about to execute sqls.." << IINF;
	// <- iterate through tables
	while (it != m_tables.end())
	{
		jsdb_table tbl = (jsdb_table) it->second;
	
		map<int, jsdb_sql>::iterator its = tbl.m_sqls.begin();

		// <- iterate through list of sqls
		while (its != tbl.m_sqls.end())
		{
			jsdb_sql _sql = (jsdb_sql) its->second;
			string sql = _sql.m_sql;
			
			rvDBResult res;
			db.query(sql, res);

			ILOG << "Executed sql " << (char*) sql.c_str() << IINF;

			// on success set dirty attribute value to 99
			if (db.m_cnn->success())
			{
				if (_sql.sql_type == 1 || _sql.sql_type == 3)
					remove_row(_sql.m_sql_row_in_data_doc);
				else
					// Special if the temp row had a dirty attribute 99, then set the same
					set_clean_row(_sql.m_sql_row_in_data_doc);

				//m_client_db_doc->SetNodeAttributeValue((nsIDOMElement*) _sql.m_sql_row_in_data_doc, MozStr("dirty"), MozStr("99"));
			}
			its++;
		} // done processing all sqls ->

		it++;
	} // done processing all tables -->

	// at this point
	//	1) the data xml via cgi stdin, has been processed
	//	2) all the sqls are executed
	//	3) the modify sqls set the dirty=99 (clean) flag on the data xml
	//	4) new select sqls append tables (in xml) to the data xml.
	//	5) the data xml is ready to be sent back to the browser (ofcourse after the cgi app is done adding all other data required for the current cgi call)

	ILOG << "after xml2db" << IINF;
	rvXmlDocument::DumpNodeDeep(m_client_db_doc->GetDocumentElement());
	return true;
}

void jsdb_s::set_client_db_data(string xml)
{
	// if no data doc exists, then this is the first xml, simply create and return
	if (m_client_db_doc == NULL)
	{
		ILOG << "null doc" << IINF;
		create_db_doc(xml);
		ILOG << "created " << IINF;
		return; // any way
	}

	// already a data doc exists and hence only append the incoming xml
	rvXmlDocument temp_doc;
	nsAutoString xml1;
	xml1.AssignWithConversion(xml.c_str());

	if (!temp_doc.LoadFromString(xml1))
		return;

	nsAutoString rname;
	temp_doc.GetDocumentElement()->GetNodeName(rname);
	if (rname.Equals(MozStr("JSDB")))
	{
		nsIDOMNodeList* tables_list;
		temp_doc.GetDocumentElement()->GetChildNodes(&tables_list);
		PRUint32 num_tables = 0;
		tables_list->GetLength(&num_tables);

		for (int idxt=0; idxt<num_tables; idxt++)
		{
			// get the dom pointer to the table
			nsIDOMNode* temp_table;
			tables_list->Item(idxt, &temp_table);

			NS_RELEASE(temp_table);
		} // end iteration of tables 

		NS_RELEASE(tables_list);
	}
	else
		add_table((nsIDOMElement*) (temp_doc.GetDocumentElement()));

		ILOG << "Completed set_client_db_data" << IINF;
}

string jsdb_s::get_client_db_data()
{
	if (m_client_db_doc == NULL)
		return "<JSDB/>";

	nsAutoString xml = m_client_db_doc->SerializeNode(m_client_db_doc->GetDocumentElement());
	string xmls = utils::stlstr(xml);

	return xmls;
}

// private / protected
void jsdb_s::create_db_doc(string xml)
{
	if (m_client_db_doc != NULL)
		return;

	m_client_db_doc = new rvXmlDocument();
	m_client_db_doc->CreateEmptyDocument(MozStr("JSDB"));

	if (xml.empty())
		return;

	rvXmlDocument temp;
	nsAutoString xml1;
	xml1.AssignWithConversion(xml.c_str());
	if (!temp.LoadFromString(xml1))
		return;

	nsIDOMElement* doc_elem = temp.GetDocumentElement();
	nsAutoString name;
	doc_elem->GetNodeName(name);
	if (name.Equals(MozStr("JSDB")))
	{
		// iterate through the children and then update
		nsIDOMNodeList* tables;
		doc_elem->GetChildNodes(&tables);
		PRUint32 num_tables= 0;
		tables->GetLength(&num_tables);

		for (int idxt = 0;idxt < num_tables; idxt++)
		{
			nsIDOMNode* temp_table;
			tables->Item(idxt, &temp_table);

			nsIDOMNode* table_clone;
			temp_table->CloneNode(PR_TRUE, &table_clone);
			nsIDOMNode* ret;
			m_client_db_doc->GetDocumentElement()->AppendChild(table_clone, &ret);
			
			NS_RELEASE(table_clone);
			NS_RELEASE(temp_table);
		}
	}
	else
	{
		nsIDOMNode* doc_elem_clone;	
		doc_elem->CloneNode(PR_TRUE, &doc_elem_clone);
		nsIDOMNode* ret;
		m_client_db_doc->GetDocumentElement()->AppendChild(doc_elem_clone, &ret);

		NS_RELEASE(ret);
		NS_RELEASE(doc_elem_clone);
	}

	NS_RELEASE(doc_elem);
	temp.Destroy();
}

nsIDOMElement* jsdb_s::check_if_table_exists(nsIDOMElement* table)
{
	if (m_client_db_doc == NULL)
		return NULL;

	nsAutoString tname; ((nsIDOMNode*) table)->GetNodeName(tname);
	nsAutoString tcnn_id = m_client_db_doc->GetNodeAttributeValue((nsIDOMElement*) table, MozStr("cnn_id"));
	
	ILOG << "tname " << tname << IINF;
	ILOG << "tcnn_id " << tcnn_id << IINF;

	// find the table tag in the m_client_db_doc
	nsIDOMNodeList* tables_list;
	nsIDOMElement* root = m_client_db_doc->GetDocumentElement();
	root->GetChildNodes(&tables_list);
	PRUint32 num_tables = 0;
	tables_list->GetLength(&num_tables);

	for (int idxt = 0; idxt<num_tables; idxt++)
	{
		// get the dom pointer to the table
		nsIDOMNode* table_node;
		tables_list->Item(idxt, &table_node);
		
		// <- get the table name ->
		nsAutoString dtname = m_client_db_doc->GetNodeName((nsIDOMElement*) table_node);
		nsAutoString  dtcnn_id = m_client_db_doc->GetNodeAttributeValue((nsIDOMElement*) table_node, MozStr("cnn_id"));
		
	ILOG << "dtname " << dtname << IINF;
	ILOG << "dtcnn_id " << dtcnn_id << IINF;

		if (tname.Equals(dtname) && tcnn_id.Equals(dtcnn_id))
		{
			NS_RELEASE(tables_list);
			return (nsIDOMElement*) table_node;
		}

		NS_RELEASE(table_node);
	}

	NS_RELEASE(tables_list);
	return NULL;
}

nsIDOMElement* jsdb_s::check_if_row_exists(nsIDOMElement* ddata, nsIDOMElement* row)
{
	// basically check if the columns match
		nsIDOMNodeList* drows;
		ddata->GetChildNodes(&drows);
		PRUint32 num_drows = 0;
		drows->GetLength(&num_drows);

		// get the fields data
		nsIDOMNodeList* cols;
		row->GetChildNodes(&cols);
		PRUint32 num_cols = 0;
		cols->GetLength(&num_cols);

		//	loop through children (rows) and create sql strings
		PRInt32 idxs = 0;
		for (PRUint32 idxr = 0; idxr < num_drows; idxr++)
		{
			nsIDOMNode* ddata_row;
			drows->Item(idxr, &ddata_row);

			// get the fields data
			nsIDOMNodeList* drow_cols;
			ddata_row->GetChildNodes(&drow_cols);
			PRUint32 num_drow_cols = 0;
			drow_cols->GetLength(&num_drow_cols);

			if (num_drow_cols != num_cols)
				continue;

			PRBool row_matched = PR_TRUE;
			for (PRUint32 idxc=0; idxc<num_drow_cols;idxc++)
			{
				nsIDOMNode* dcol;
				nsIDOMNode* col;
				drow_cols->Item(idxc, &dcol);
				cols->Item(idxc, &col);

				nsAutoString dval = m_client_db_doc->GetNodeValue((nsIDOMElement*) dcol) ;
				nsAutoString val = m_client_db_doc->GetNodeValue((nsIDOMElement*) col);

				if (!dval.Equals(val))
				{
					row_matched = PR_FALSE;
					break;
				}

				NS_RELEASE(col);
				NS_RELEASE(dcol);
			}

			NS_RELEASE(drow_cols);
			if (row_matched)
			{
				NS_RELEASE(cols);
				NS_RELEASE(drows);
				return (nsIDOMElement*) ddata_row;
			}

			NS_RELEASE(ddata_row);
		}

		NS_RELEASE(cols);
		NS_RELEASE(drows);
		return NULL;
}

void jsdb_s::add_table(nsIDOMElement* temp_table)
{
	// check if the table already exists in m_client_db_doc
	ILOG << "checking if table exists" <<IINF;
	rvXmlDocument::DumpNodeDeep((nsIDOMElement*) temp_table);
	nsIDOMElement* table = check_if_table_exists((nsIDOMElement*) temp_table);
	if (table != NULL)
	{
		ILOG << "table exists" << IINF;

		// check if each row exists or not
		nsIDOMElement* data = m_client_db_doc->GetChildNode((nsIDOMElement*) table, MozStr("Data"));
		rvXmlDocument::DumpNodeDeep((nsIDOMElement*) data);

		nsIDOMElement* temp_data = m_client_db_doc->GetChildNode((nsIDOMElement*) temp_table, MozStr("Data"));

		nsIDOMNodeList* rows;
		temp_data->GetChildNodes(&rows);
		PRUint32 num_rows = 0;
		rows->GetLength(&num_rows);

		//	loop through children (rows) and check if the row exists in the table in the m_client_db_doc
		PRInt32 idxs = 0;
		for (PRUint32 idxr = 0; idxr < num_rows; idxr++)
		{
			ILOG  << "checking row" << IINF;
			nsIDOMNode* temp_row;
			rows->Item(idxr, &temp_row);
			
			nsIDOMElement* row = check_if_row_exists(data, (nsIDOMElement*) temp_row); 

			nsIDOMNode* row_clone;
			temp_row->CloneNode(PR_TRUE, &row_clone);

			nsIDOMNode* ret;
			if (row != NULL) // replace child
			{
				ILOG << "row exists" << IINF;
				rvXmlDocument::DumpNodeDeep((nsIDOMElement*) row_clone);

				nsIDOMNodeList* cols;
				row->GetChildNodes(&cols);
				PRUint32 num_cols = 0;
				cols->GetLength(&num_cols);

				nsIDOMNodeList* temp_cols;
				row_clone->GetChildNodes(&temp_cols);

				for (int idxc=0;idxc<num_cols;idxc++)
				{
					nsIDOMNode* col;
					nsIDOMNode* temp_col;

					cols->Item(idxc, &col);					
					temp_cols->Item(idxc, &temp_col);

					nsAutoString val;col->GetNodeValue(val);
					temp_col->SetNodeValue(val);

					NS_RELEASE(col);
					NS_RELEASE(temp_col);
				}

				NS_RELEASE(row);
			}
			else // append the child
			{
				ILOG << "row does not exist" << IINF;
				rvXmlDocument::DumpNodeDeep((nsIDOMElement*) row_clone);

				data->AppendChild(row_clone, &ret);
			}

			ILOG << "Set dirty flag" << IINF;
			//NS_RELEASE(ret);
			//NS_RELEASE(temp_row);
			
		} // end iteration of rows

		NS_RELEASE(rows);
		NS_RELEASE(data);
	}
	else // append the whole table
	{
		nsIDOMNode* table_clone;
		temp_table->CloneNode(PR_TRUE, &table_clone);

		nsIDOMNode* ret;
		m_client_db_doc->GetDocumentElement()->AppendChild(table_clone, &ret);
		NS_RELEASE(ret);
		NS_RELEASE(table_clone);
	}

	ILOG << "done adding table" << IINF;
}

bool jsdb_s::remove_row(nsIDOMNode* row)
{
	nsIDOMNode* data;
	row->GetParentNode(&data);

	nsIDOMNode* ret1;
	data->RemoveChild(row, &ret1); 
	NS_RELEASE(ret1);

	PRBool hasc;
	data->HasChildNodes(&hasc);
	if (!hasc)
	{
		nsIDOMNode* table;
		data->GetParentNode(&table);

		nsIDOMNode* doc_elem = (nsIDOMNode*) m_client_db_doc->GetDocumentElement();

		nsIDOMNode* ret;
		doc_elem->RemoveChild(table, &ret);
		
		NS_RELEASE(data);
		NS_RELEASE(ret);
		
		return true;
	}

	NS_RELEASE(data);
	return false;
}

void jsdb_s::set_clean_row(nsIDOMElement* row)
{
	nsAutoString dirty99 = m_client_db_doc->GetNodeAttributeValue((nsIDOMElement*) row, MozStr("dirty")); 
	if (!dirty99.Equals(MozStr("")))
		m_client_db_doc->SetOrCreateNodeAttributeValue((nsIDOMElement*) row, MozStr("dirty"), MozStr("99"));

	nsIDOMNodeList* cols;
	row->GetChildNodes(&cols);
	PRUint32 num_cols = 0;
	cols->GetLength(&num_cols);

	for (PRUint32 idxc=0; idxc<num_cols;idxc++)
	{
		nsIDOMNode* col;
		cols->Item(idxc, &col);

		ILOG << "setting dirty flag on col" << m_client_db_doc->GetNodeValue((nsIDOMElement*) col) << IINF;
		ILOG << " value of dirty =" << m_client_db_doc->GetNodeAttributeValue((nsIDOMElement*) col, MozStr("dirty")) << IINF;
		m_client_db_doc->SetNodeAttributeValue((nsIDOMElement*) col, MozStr("dirty"), MozStr("99"));
		NS_RELEASE(col);
	}

	NS_RELEASE(cols);
}	


string get_section(long root_id, bool deep)
{
	// This function will create n table sections, the first table will contain
	// for a given root id
	//	get all sections that are children of the root section
	//	- so find immediate children
	//		get the section, check if there is inheritance, then get the base section, recursively
	//		get the children of the section, if nothing exists, then get the children of the base section.
	//			- if the base does not have any children, then get the children of its base, recursively
	//		add those children 
	return "";
}

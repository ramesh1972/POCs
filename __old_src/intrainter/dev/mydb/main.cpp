#include <iostream>
#include <iomanip>
#include <mysql++>

#define MY_DATABASE	"test"
#define MY_TABLE	"stock"
#define MY_HOST     "localhost"
#define MY_USER     "root"
#define MY_PASSWORD "root"
#define MY_FIELD    "*" // BLOB field
#define MY_KEY      "datet"  // PRIMARY KEY


int main() {
  // The full format for the Connection constructor is
  // Connection(cchar *db, cchar *host="", 
  //            cchar *user="", cchar *passwd="") 
  // You may need to specify some of them if the database is not on
  // the local machine or you database username is not the same as your
  // login name, etc..
  try {
		Connection con(use_exceptions);
		con.real_connect (MY_DATABASE,MY_HOST,MY_USER,MY_PASSWORD,3306,(int)0,60,NULL);
		Query query = con.query();
		// This creates a query object that is bound to con.

		query << "select * from stock";
		// You can write to the query object like you would any other ostrem

		Result res = query.store();
		// Query::store() executes the query and returns the results

		cout << "Query: " << query.preview() << endl;
		// Query::preview() simply returns a string with the current query
		// string in it.

		cout << "Records Found: " << res.size() << endl << endl;
  
		Row row;
		cout.setf(ios::left);
		cout << setw(17) << "Item" 
			<< setw(4)  << "Name"
			<< setw(7)  << "Price" 
			<< endl;
  
		Result::iterator i;
		// The Result class has a read-only Random Access Iterator
		for (i = res.begin(); i != res.end(); i++) {
			row = *i;
			cout << setw(17) << row[0] 
				<< setw(4)  << row[1] 
				<< setw(7)  << row["price"]
				<< endl;
		}
  } catch (BadQuery er){ // handle any connection 
                         // or query errors that may come up
    cerr << "Error: " << er.error <<  endl;
    return -1;

  } catch (BadConversion er) {
    // we still need to cache bad conversions incase something goes 
    // wrong when the data is converted into stock
    cerr << "Error: Tried to convert \"" << er.data << "\" to a \""
	 << er.type_name << "\"." << endl;
    return -1;
  }
	return 0;
}

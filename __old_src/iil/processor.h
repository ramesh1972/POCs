#ifndef __def_language_processor_included__
#define __def_language_processor_included__

// =======================================================================
#include "native.h"
using namespace iil::l_ntv;

#include "defs.h"
using namespace iil::l_cns;

// processor namespace ===================================================
namespace iil  {
	namespace l_prc {

// class processor =======================================================
/* an application can be lauched 
	- with the link/method name and arguments 
	- with a file name while the links/constructs exist
	- xml input
		- from io
		- from file
	- db connection params/db constructs */
class processor
{
private:	
// calling a global method or displaying a variable etc..
	processor();

	// singleton instance of the language construct processor, 
	// with the dispatcher and memory
	static processor* __proc;

	// the main routines of the language/lib processor
	dispatcher* __disp; 
	linker* __linker;
	memory* __memory;

	nvd boot();
	nvd shutdown();
	nvd mount();
	nvd unmount();
	nvd run();

	// ======================================================================
	// S T A R T     H E R E     F O R    A L L    T Y P E S  OF  PROCESSORS
	// - Call from main() the following function
	static nint create_processor();
	// ======================================================================

	// user interface related
	map<string, processor_language*> _languages; // a collection of languages (Singletons) using which
	// code can be written and processed. Also in the collection is native language.

	map<string, user_code_sections*> _sections;	// a collection of sections within code pages which 
																		// hold code in different languages, 
																		// for different processes and users.
public:
	~processor();

public:
	static processor* processor::p();
	static dispatcher* processor::d();
	static memory* processor::m();
	static linker* processor::l();

	nvd registerc();	
	nvd init();		
	construct* process();
	construct* process(construct* instrctn);
	nvd clean();
};
}}
#endif
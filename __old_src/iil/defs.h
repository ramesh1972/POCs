#ifndef __def_language_common_defs_included__
#define __def_language_common_defs_included__

// =======================================================================
#include "native.h"
using namespace iil::l_ntv;

// =======================================================================
namespace iil {
	namespace l_prc {

// VERY USEFUL MACROS ====================================================
#define $PI_PROC iil::l_prc::processor::p()
#define $PI_DISP iil::l_prc::processor::d()
#define $PI_MEM  iil::l_prc::processor::m()
#define $PI_LNK  iil::l_prc::processor::l()

// helper macros =====================================================
#define $PI_MEM_P $MEM->_proc_m
#define $PI_MEM_C(Rc, Rct) (iil::l_prc::l_ins::pi_get_root_mem_section(#Rc, #Rct))
#define $PI_MEM_DMPC(C) C->dump_construct_data();
#define $PI_MEM_DMPT(C) C->dump_construct_data(true);
#define $PI_MEM_DMP iil::l_prc::l_ins::pi_dump_memory();

// forward declarations
class dispatcher;
// interfaces with everything in the code, but main focus is on variables, methods, data, requests

class linker;
namespace l_lnk {class linker_object;} // THE MOST IMPORTANT CLASS IN THIS WHOLE LIB.
	// WE COULD DO AWAY WITH REST OF THE CODE and HAVE JUST THIS ONE REALLY.
	
class memory;
class construct_object; // This is used by the memory. It is a wrapper to the construct objects. This is
// useful in case if the constructs info are coming from outside of the process. In that case for
// such requests/processess, the memory shifts its memory from the native os, to that of the request,
// for e.g. xml...So there is no need to create all that information both in counstruct objects and
// xml..In this case, the construct objects will be empty, instead the memory will point to the constructs
// in the user context, which could be say ms xml document, or xeresc etc...

class instructor;
class interpreter; // contains an instance of the processor_language and language constructs derived classes objects..
									 // which convert code in a certain processor_language into instructions. These instructions can be real
									 // objects or text based...These are sent to the instructor via the dispatcher. The instructor creates the appropriate 
									 //	instruction link and dispatches the same. This call will go through all the constructs processing, memory handling 
									 // and native linking, etc...and return with the result of the instruction...back to the code page...
									 // Even further, the whole processing logic can be derived...and can be created in a new nativ env using the base native.

class processor;
extern processor* proc;

class interrupt_handler; 

class processor_language; // initially a set of methods that accomplish things...
// once a language becomes fully developed, then we have a language that can be put in 
// a standard format of a programming langauge. And hence the language class will be collapsed and
// will be a language supported by the processor in the standard way. That is using the language construct...
// constructs...

class section_handlers; // A class having a collection of pairs of processor language and section native code (format) intepreter)
class user_code_sections; // collection of refs to user code_libs..(Which actually is the root of users namespaces and code (iil) existing in iil memory)

// something to make the code_pages ready for running..
class compiler; // parses and builds code pages and libs and generates binaries...makefile basically. input could be as simple as a cpp file or complex as a muli code page section language text..or file
}

// forward declarations from the constructs namespace ====================
namespace l_cns 	{

// Low Level constructs
class construct;
class collection_construct;
class rel_construct;
class rels_construct;

class data_construct;
class construct_type;
class link;

class variable;
class method;
class event;

class context;
class object_construct;
class class_construct;

class condition_construct;
class iteration_construct;
class interrupt_construct;

// High Level constructs
// language_consturct is a core class that accomplishes the task of understanding code page or constructions from different 
// platform like xml. A
// language consists of key words, statements, expressions, etc...and 
 // so is the generic processor language has all these. 
// A lanuage name is itself a language construct.
// While the language construct can accomplish basic thiings of a language syntax analyser, 
// the code page has a collection of languages and sections and instructions...which exist in the
// languages supported by the processor...so once a language is set, all that is following are that
// particular language constructs.
// This way in the future, even say we can create a copy of the perl's constructs..and
// actually be able to code in perl, but not exactly perl, but may be the code behind is 
// c++. This will lead to automatic translations of languages from one to the other...or integrating
// code with the system and hence rest of the world.
// So several existing language constructs or new constructs can be added and used by the
// newly developed language. This will invole basically steretyping a language and creating
// a class derived from language_construct.
class language_construct; // NOTE language construct does not make much use until code pages are developed.
// To develop code pages...you need to build the maker..real time maker...as well for xml based coding.

	class instruction_construct;
	class statement_construct;
	class expression_construct;
	class keyword_construct;
	class alias_construct;
	
	class compiler_construct;
	class linker_construct;
	
	class section_construct;
	class code_construct; // represents text in certain language..
	class codepage_construct;

	// all the constructs in any language are stored in code_pages (in stack.heap) and
	// and the code pages are in a lib..Again once this class becomes useful, lib_construct, codepage_construct, 
	// section, etc can be created, which structures the language and coding in a common way.
	// IN ESSENCE ONE DAY A CODE LIB becomes a component, an exe or a dll and hence all the
	// logic available in the processor {} , the entire thing, should be available within the code_lib.
	// at runtime SOMEDAY...
	class lib_construct;
}}
#endif


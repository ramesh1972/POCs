#ifndef <DEF_CLASS_NAME_HeaderIncluded>
#define <DEF_CLASS_NAME_HeaderIncluded>

// include system, 3rd party headers
#include <stdio.h>	 // system headers
#include <mysqlpp.h> // 3rd party headers

// namespace headers
#include "ii_ns_headers.h" 
#include "ii_ns_macros.h" 
#include "ii_ns_types.h" 

// or include headers from this namespace

// include headers from other namespaces

// forward declarations


// class declaration

// for each access level (private, public, protected) create the class in the following way,
// logical inner namespace 
// 	tasks
//	methods
//	properties
//	data
//	events

// under each access level for every type of declaration for a inner namespace
// declare the following type of methods.
//	globals
//		global variables declarations
//		global method declarations
//  service tasks
//	init/unint methods
//	server methods
//	component methods
//	main methods
//	property methods
//	common methods

// declare the logical inner namespace declarations in the following 
// order of object relationships.
//	inherited
//		runtime derivatations
//	compositions
//		containment
//		refs
//			links
//		collections
//			recurise collections
//			recurise self collections

// namespace - 
// parent		 -
namespace <Name1> 
{
	namespace <Name2> 
	{
		class <ClassName1> : public NS1::NS2::ClassName or II::Service or  II::Component) 
		{
			public: // public methods, properties, members
				// methods
				<ClassName1>();
				~<ClassName1>();

			private: // private methods, properties, members
				// properties
				// data
				// methods

			protected:	// protected methods, properties, members
				// properties
				// data
				// methods
		};
	}
}

#endif

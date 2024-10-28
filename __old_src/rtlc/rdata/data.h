#ifndef __def_rlibs_data_included__
#define __def_rlibs_data_included__

// things:#include "build_info.h"
//	#ifdef RLIBS_USING_CPP
//	#ifdef RLIBS_USING_WIN32

namespace rlibs
{
	namespace data
	{
		class rvoid_p;
		class rstr;
		class rint;
		class rtype;
		class data
		{
		private:
			rvoid_p _buffer;
			rint _size;
			rstr _type_name;
			rtype* _type_ref;

		public:
			data(rstr _type_name, rvoid_p value, rint size) {} // things

			rvoid_p operator()() {return _buffer;}
			data* operator(rstr type) { return NULL}; //things}
			data* operator(rtype* rt) { return NULL}; //things}
			void set_buffer(void_p buf, rint size) {_buffer = buf;_size=size;}
		};

		class rint : public data
		{
		public:
			rint(rvoid_p value, rint size) : data(rstr("rint"),value, size) {} // things
		}
	}
}

#endif 


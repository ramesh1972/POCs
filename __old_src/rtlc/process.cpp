#include "process.h"

// ========= These are callbacks for a default process.
// The main code (in any of the pl languages or native c++ language or mixed)
nvd register_constructs()
{
}

nvd user_init()
{
	printf("user init method is called\n");
}

nvd user_clean()
{
	printf("user clean method is called\n");
}

nvd user_process()
{
	// declare a variable
//	variable* var1 = __language::__processor::__instructions::register_variable("age", "", NULL, (nvp) 10, "dint");
//	int age = (int) __language::__processor::__instructions::get_vvalue_native(var1);
	printf("user process method is called\n");
}


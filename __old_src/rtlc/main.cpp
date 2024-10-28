#include "processor.h"

// =======================================================================
// Entry for PL implementation. Do not change this function.
nint g_argc;
nchrp** g_argv;

int main(int argc, char* argv[])
{
	// init
	g_argc = argc;
	g_argv = (nchrp**) argv;
	
	// start
	printf("Starting Global Processor!\n");
	nint exit_code = __language::__processor::processor::create_processor();
	printf("Processor Has ShutDown with exit_code:%i\n", exit_code);

	return exit_code;
}


#ifndef __def_language_process_sample_included__
#define __def_language_process_sample_included__

// =======================================================================
// This is the default template for all console based exes in c++ on windows.
#include "native.h"
#include "processor_linker.h"
#include "processor_instructions.h"

// =======================================================================
// These methods are called in order.
nvd register_constructs();
nvd user_init();
nvd user_process();
nvd user_clean();

#endif
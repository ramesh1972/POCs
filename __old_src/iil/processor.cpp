#include "processor.h"
#include "processor_instructions.h"

#include "construct.h"
#include "construct_core.h"
#include "constructs_instructions.h"

#include "constructs_linker.h"
using namespace iil::l_cns::l_lnk;

// =======================================================================
namespace iil {
	namespace l_prc {

// =======================================================================
processor* processor::__proc = NULL;

// generic static accessors ==============================================
processor* processor::p() { return __proc; }
dispatcher* processor::d() 
{ 
	if (p() != NULL) 
		return p()->__disp; 

	return NULL;
}

memory* processor::m() 
{ 
	if (p() != NULL)
		return p()->__memory; 
	
	return NULL;
}

linker* processor::l() 
{ 
	if (p() != NULL)
		return p()->__linker; 
	
	return NULL;
}

// =======================================================================
// S T A R T     H E R E     F O R    A L L    T Y P E S  OF  PROCESSORS
// - Called from main() the following function
nint processor::create_processor()
{
	// create the global processor object (singleton) and boot
	if (__proc == NULL)
		__proc = new processor(); // boot() is automatically called.

	// start the processor......
	__proc->mount();
	__proc->run();
	__proc->unmount();

	// =========================================
	// STOP. THIS IS THE   F I N A L   SHUT DOWN
	delete __proc;

	return 1;
}
// =======================================================================

// boot sequence =========================================================
processor::processor() {boot();}
processor::~processor() {shutdown();}

nvd processor::boot()
{
	// return control to main
	printf("done startup\n");
	return;
}

nvd processor::shutdown()
{
	if (__proc == NULL)
		return;
	
	__proc->unmount();

	printf("done shutdown\n");
}

nvd processor::mount()
{
	__disp = new dispatcher(this);
	__disp->mount();

	__memory = new memory(this);
	__memory->mount();

	__linker= new linker(this);
	__linker->mount();
}

nvd processor::unmount()
{
	if (__proc == NULL)
		return;

	__disp->unmount();
	__memory->unmount();
	__linker->unmount();
	
	delete __disp;
	delete __memory;
	delete __linker;

	__disp = NULL;;
	__memory = NULL;
	__linker = NULL;

	__proc = NULL;
	printf("done stop\n");
}

// =======================================================================
nvd processor::run()
{
	construct* exit_code = __disp->dispatcher_start();
	__disp->dispatcher_stop(exit_code);
}

nvd processor::registerc()
{
	// register __disp and memory contructs for this instance of the processor.h first..
	$PI_MEM->registerc();
	$PI_LNK->registerc();
	$PI_DISP->registerc();
	
	// IMPORTANT::
	// at this point all registrations of constructs available should be done.
	// good point to take a dump of the memory.
	$PI_MEM_DMP
}

nvd processor::init() 	
{
	__disp->init();
	__memory->init(); 
	__linker->init();
}

construct* processor::process(construct* instrctn) {return NULL;}
construct* processor::process() {return NULL;}

nvd processor::clean() 	
{
	__disp->clean();
	__memory->clean();
	__linker->clean();
}
}}
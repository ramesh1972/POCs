#ifndef __RV_UTILS_
#define __RV_UTILS_

#include "rvXPCOMIds.h"
#include <string>

namespace utils
{
	string stlstr(nsAutoString str);
	string stlstr(int);
	int toint(nsAutoString str);

	void display(nsAutoString str, char* msg);
}

#endif
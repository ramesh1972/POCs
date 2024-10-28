#include "utils.h"

namespace utils
{
string stlstr(nsAutoString str)
{
	char* s = ToNewCString(str);
	return string(s);
}

string stlstr(int i)
{
	char tmp[4];
	char* res = itoa(i, tmp, 10);

	return string(tmp);
}

int toint(nsAutoString str)
{
	int e;
	int i = str.ToInteger(&e);
	return i;
}

void display(nsAutoString str, char* msg)
{
	char *s = ToNewCString(str); 	
	printf("%s%s", msg, s);
}
}
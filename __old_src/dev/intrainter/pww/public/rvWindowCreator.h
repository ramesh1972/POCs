#ifndef __rvWindowCreator
#define __rvWindowCreator

#include "rvXPCOMIds.h"

class rvMyMozApp;

class rvWindowCreator : 
	public nsIWindowCreator
{
public:
  rvWindowCreator(rvMyMozApp *aApp);
  virtual ~rvWindowCreator();

  NS_DECL_ISUPPORTS
  NS_DECL_NSIWINDOWCREATOR

private:
  rvMyMozApp *mApp;
};

#endif

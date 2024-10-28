#ifndef _RV_OPEN_URL_H_
#define _RV_OPEN_URL_H_

#include "rvXPCOMIDs.h"
#include "rvFormWindow.h"

// Event Handlers
void URLTextBox_Change(nsIDOMElement* aMouseEvent, CHTMLFormWindow*);
void GoButton_Click(nsIDOMElement* aMouseEvent, CHTMLFormWindow*);

class COpenURLWindow : public CHTMLFormWindow
{
public:
  COpenURLWindow();
  virtual ~COpenURLWindow();

  virtual void InitializeListeners();
	virtual void UninitializeListeners();
  
	virtual void DoOpen();
	virtual void DoClose();

	// data
	nsAutoString m_url;
};

#endif 

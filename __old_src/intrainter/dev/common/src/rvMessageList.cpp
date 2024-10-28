#include "rvMessages.h"
#include "rvMessageList.h"

extern CTextMessages* g_msgs;

// message text
BEGIN_MESSAGES
	II_MSG_ADD(IIR_EXCEPTION, "Caught Exception. ");
	II_MSG_ADD(IIR_FAILED, "Failure. ");
	II_MSG_ADD(IIR_SUCCESS, "Success. ");
	II_MSG_ADD(IIR_CREATED_INSTANCE, "Successfully created instance. ");
	II_MSG_ADD(IIR_CREATE_INSTANCE_FAILED, "Failed to created instance. ");
	II_MSG_ADD(IIR_LOADED_FROM_FILE, "Successfully loaded from file. ");
	II_MSG_ADD(IIR_FAILED_TO_LOAD_FROM_FILE, "Failed to load from file. ");
	II_MSG_ADD(IIR_NULL_POINTER, "Null Pointer. ");
	II_MSG_ADD(IIR_APPEND_DOM_FAILED, "Failed to Append DOM Element. ");
	II_MSG_ADD(IIR_FAILED_TO_GET_DOC_ELEMENT, "Failed to Get DocumentElement. ");
	II_MSG_ADD(IIR_CREATE_DOM_FAILED, "Failed to Create DOM Element. ");
	II_MSG_ADD(IIR_CREATED_DOM_NODE, "Successfully created DOM Element. ");
	II_MSG_ADD(IIR_APPENDED_DOM, "Successfully Appended DOM Element. ");
	II_MSG_ADD(IIR_INSERTED_DOM, "Successfully Inserted DOM Element. ");
END_MESSAGES

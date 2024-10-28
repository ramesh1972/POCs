// IIComponentType.h: interface for the IIComponentType class.
//
//////////////////////////////////////////////////////////////////////

#if !defined(AFX_IICOMPONENTTYPE_H__DAAB3311_7169_4A5C_9D0B_039E07AF2561__INCLUDED_)
#define AFX_IICOMPONENTTYPE_H__DAAB3311_7169_4A5C_9D0B_039E07AF2561__INCLUDED_

#if _MSC_VER > 1000
#pragma once
#endif // _MSC_VER > 1000

// Every class that is derived from IIComponent essentially is a type. 
// But a hard coded type can have its variations, 
//	for e.g. in derivations, when version changes, or by state at runtime.
// These are soft types and logical types. 
// The IIComponentType class, maintains typeinfo of the component and 
// also its variations. 
// At sometime this class has to be upgraded to support versioning.
// For most hard coded types like enums, classes etc..
//		type = name and hence the IIComponent.Name = IIComponent.Type
//	but when type changes, the version changes, but the name of the 
//  component could remain the same.
// The other main job of the class is to maintain type descriptor. 
// 0This forms the basis of the config for each component type
class IIComponentType  : public IIService
{
public:
	IIComponentType();
	virtual ~IIComponentType();

};

#endif // !defined(AFX_IICOMPONENTTYPE_H__DAAB3311_7169_4A5C_9D0B_039E07AF2561__INCLUDED_)

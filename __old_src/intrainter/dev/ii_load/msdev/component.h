#if !defined(_COMMON_COMPONENT_HEADER_INCLUDED_)
#define _COMMON_COMPONENT_HEADER_INCLUDED_

// A System in essential is made of components and the components provide services to users.
// These components are different for different contexts, for e.g say a business classes for price calc, or gui
// Generally for a system there are certain core components that provide more technical services, while others
// exist in the business part of the system. for e.g. thread management component providing sync services,
// or a socket interface component that hides all the net transport specific code rather than it being repeated,
// in all components.
// So there are 2 namespaces, core and business. Both of these exist in the component namespace.
// all the classes created in these namespaces have to be derived from a class called Component.
//
// Most components of a system like data, transport, user interface, io, business etc...all essentially
// provide certain services, public functions. These are essentially services. And in business sense this kind
// of service oriented architecture, is simply mapping client actions (events) to server side components.
// So the other global concept is that of a service. The service layer encapsulates,
//	- service directory methods
//	- registering with the dispatcher
//	- implementation of the service methods


// The components essentially have services and these services are invoked via a dispatch menchanism.
// A dispatch mechanism which opertates on a standard dispatch data and calls the appropriate component handler.
// It also stores the returned data and invokes the next dispatch action.
// A standard format for all types of "linkage" should be developed (in xml).
// Hence the dispatcher should support io methods between c++ linkings, threads and 
// as well as remote components, via sockets, named pipes, mem files, text files, db. 
// 
// every process has a single dispatcher component and this instance should be accessible via #define macros,
//  like DISP.AddService
//
// so 3 core classes that exist all over are these.	
// component (component type inherited, system component directory collection), 
// service components (methods) --> component
// dispatcher component (io of services), component classes, --> component
// These components appear in the namespace component.
// So the namespace/classes tree is
// component ns
//	CComponent
//		CService
//		CDispatcher
//		CTaskTemplate
//	dispatcher ns
//		CDispatchConfig
//		CDispatchMessageClass
//		CDispatchMechanism
//		CDispatchFP
//	service ns
//  system ns
//		CSystem
//			CProcess
//			CThread
//			CSharedOject
//	core ns
//		common ns
//		logical namespace
//	business ns
//		common ns
//		logical namespace

// CService is itself a component and hence is derived from CComponent. So all classes that provide
// a service (a function id <--> public function call), should be derived from the CService class.
// These classes fall in both the core and the business namespace and hence should be declared in the 
// appropriate namespace. for e.g web io request service will be in the core, CTradeReport in the business.
// 
// all components derviced from service class, will have a process_service() function overidden.
// the process_service launches the appropriate task..

// a task can be as simple as executing a function or can be a function that is run on a thread waiting on a socket.
// A task essentially has a init, run, uninit. The arguments to the task are provided by the service class, which it gets from the dispatcher.
// so task essentially is a template class derived from Component. A service can implement several task classes and register them with the dispatcher.
// So a service is a list of tasks (objects) that implement init, run, uninit, exception, error etc..
// And the services are registered with the dispatcher (a singleton class for a system component like process
// The dispatcher invokes the service, service invokes the appropriate task. THe service, tasks use the dispatcher to
// dispatch events.
// Every component essentially has a dispatch configuration that tells the service and the actions the component provides
// In that transport data and object data is also stored. 

// Also a concept of having a tree of dispatches is possible, which essentially means automating function calls essentially,
// or rather performing a set of tasks..automatically if the tree exists in the config..

// LIkewise a compoment like CProcess can recieve a dispatch message in the tree form and the dipatcher should call these in order..

// A service class essentially is a collection of Task classes. It creates these task classes and register the tasks with the,
// dispatcher. 
// Any component can invoke a task essentially using the dispatcher via the service interface
// The dipatcher takes care of the io, networking, threading..

// every component has a main function. for e.g a c++ process main should create the dispatcher component and call its main.
// the dispatcher main checks the argsv array, stdin, querystring etc..and creates the appropriate starter service and passes on control to that service.
// 
// The core classes are essentially request, webrequest, xml, db, jsdb, thread, io, socket, namedpipe, section, data, table, tree, list, etc...
// Essentially these are derived from service and are available to all the components...

// the business classes actually use the dipatch mechanism more than the fps.
// ofcourse there are lot of components that do bl independent of the component-service arch...that fall under its own logical namespace..in the business ns.
//
// a special handler call the system handler creates logical description of system, with services, and in turn tasks. So at the least in the database config,
// there is a notion of a tree of component that make up the tree. This essentially is the directory service provided by the CComponent .
// and there is also a type to the component, like root, system, service, task, and a logical name for them, for many core components is is the same as the class name.
// however for higher components, the same component can be used (configured) differently for  diff scenarios.
// So the type name is kind of extended though it is the same component. 
// THis gives the notion of a system. A system is a collection of components, service and task components. 
// And the name, type of the component can be set for that context. Thus giving a composed view of the system and in
// system snative language, component type and names. This standard will enable linkage between various systems uniform,
// since any system or compoennt can access any other system or component, via systemname.servicename.taskname essentially.
// this will be completely tabularized and hierarchy relations will be stored in the table.
// So CSystem is essentially a dierctory service. It creates/loads service components and with the help of dispatcher,
// initiates the service and task. 
//	- directory service. Every component (tree) 
// has a list of its own child components that it contains. Actually the services, tasks are registered with the CSystem component, which is a singleton for the running process/page.
//
// 


class Component  
{
public:
	Component();
	virtual ~Component();

};

#endif // _COMMON_COMPONENT_HEADER_INCLUDED_

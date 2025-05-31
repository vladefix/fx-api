This simple logging library is designed to provide clear and contextual log output with minimal hassle. It exposes five methods:

LogError(message)

LogWarn(message)

LogInfo(message)

LogDebug(message)

LogTrace(message)

Each method prints the provided message to the console only if the severity level meets or exceeds the current threshold set by a global variable logLevel. This means you control the verbosity of your application's logs by adjusting logLevel.

What sets this library apart is its built-in context awareness: every log message is automatically prefixed with the source file name, the exact line number, and the function from which the call originated. This provides pinpoint accuracy when tracking down issues and simplifies the debugging process.

By combining tidy output control with detailed contextual information, this library is an ideal tool for developers who need to quickly identify and resolve issues while keeping their code clean and maintainable.

Here is an example of use 

	// Include the logging API header
	#include <vladefix/fx-api/logging.mqh>

	//-------------------------------------------------------
	// Initialization function (OnInit)
	//-------------------------------------------------------
	int OnInit()
	{
		/* 
		  Set the global log level using one of the predefined log levels:
		  
		  LOGLEVEL_OFF     -> No logging at all 
		  LOGLEVEL_ERROR   -> Only error messages
		  LOGLEVEL_WARNING -> Errors and warnings
		  LOGLEVEL_INFO    -> Information messages and above
		  LOGLEVEL_DEBUG   -> Debug messages (and above)
		  LOGLEVEL_TRACE   -> All logging messages
		*/
		
		SetLogLevel(LOGLEVEL_INFO);  // For this example, we log info and above.
		return INIT_SUCCEEDED;
	}

	//-------------------------------------------------------
	// Main tick event handler
	//-------------------------------------------------------
	void OnTick()
	{
		// Log an informational message on each tick.
		LogInfo("OnTick event triggered.");
	}

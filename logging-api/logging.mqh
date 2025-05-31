//+------------------------------------------------------------------+
//|                                                       export.mqh |
//|                                          Copyright 2025, Vladeix |
//|                                         https://www.vladefix.biz |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, Vladeix"
#property link      "https://www.vladefix.biz"
#property strict

#define LOGLEVEL_OFF 0
#define LOGLEVEL_ERROR 1
#define L1M "ERROR"
#define LOGLEVEL_WARNING 2
#define L2M "WARN"
#define LOGLEVEL_INFO 3
#define L3M "INFO"
#define LOGLEVEL_DEBUG 4
#define L4M "DEBUG"
#define LOGLEVEL_TRACE 5
#define L5M "TRACE"

#define __f __FILE__
#define __l __LINE__
#define __t __FUNCTION__

#define LogError(message) Logger(__f, __l, __t, LOGLEVEL_ERROR, message)
#define LogWarn(message) Logger(__f, __l, __t, LOGLEVEL_WARNING, message)
#define LogInfo(message) Logger(__f, __l, __t, LOGLEVEL_INFO, message)
#define LogDebug(message) Logger(__f, __l, __t, LOGLEVEL_DEBUG, message)
#define LogTrace(message) Logger(__f, __l, __t, LOGLEVEL_TRACE, message)

int logLevel = LOGLEVEL_DEBUG;

void SetLogLevel(int _logLevel){
   logLevel = _logLevel;
}

void Logger(string fileName, int lineNum, string functionName, int level, string message){
   
   if(level <= logLevel){
   
      string levelStr = "";

      switch(level){
         case 5: levelStr = L5M; break; 
         case 4: levelStr = L4M; break; 
         case 3: levelStr = L3M; break; 
         case 2: levelStr = L2M; break;
         case 1: levelStr = L1M; break;
      }

      PrintFormat("%s:%d:%s [%s] %s", fileName, lineNum, functionName, levelStr, message);
   }
}

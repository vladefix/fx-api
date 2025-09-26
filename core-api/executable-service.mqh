//+------------------------------------------------------------------+
//|                                           executable-service.mqh |
//|                                Copyright 2025, Vladefix Software |
//|                                         https://www.vladefix.biz |
//+------------------------------------------------------------------+
//+                                                                  |
//+ This file is part of Vladefix's fx-api framework                 |
//+                                                                  |
//+ fx-api framework is free software: you can redistribute it and/or|
//+ modify it under the terms of the GNU General Public License as   |
//+ published by the Free Software Foundation, either version 3 of   |
//+ the License, or (at your option) any later version.              |
//+                                                                  |
//+ This program is distributed in the hope that it will be useful,  |
//+ but WITHOUT ANY WARRANTY; without even the implied warranty of   |
//+ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.             |
//+                                                                  |
//+ See the full license at:                                         |
//+ https://github.com/vladefix/fx-api/blob/main/LICENSE             |
//+                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, Vladefix Software"
#property link      "https://www.vladefix.biz"
#property version   "1.00"

#include "service.mqh"
//+------------------------------------------------------------------+
//+ Specialized type of service implementing the Command Pattern.    |
//+  Useful for:                                                     |
//+    - Hooks and callbacks.                                        |
//+    - Triggerable actions inside a program.                       |
//+    - Encapsulating logic that must be executed on demand.        |
//+------------------------------------------------------------------+

template <typename R, typename P>
class ExecutableService : public Service {

private:

public:
   ExecutableService() : Service() {};
   ~ExecutableService() {};
   
   virtual string getName() = NULL;
      
   virtual R call(P* &param) = 0;
};
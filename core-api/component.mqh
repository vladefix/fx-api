//+------------------------------------------------------------------+
//|                                                    component.mqh |
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

#define FX_LIB_COMPONENT_NAME "vladefix-fx-lib-cmp-%s"

//+------------------------------------------------------------------+
//+ This is the very base class for all entities in the framework;   |
//+  every object in the system is considered a Component.           |
//+                                                                  |
//+ Provides a common foundation for extension and integration.      |
//+------------------------------------------------------------------+
class Component {

private:

#define same 0
#define empty NULL

protected:

public:
   Component(){};

   ~Component(){};

   virtual string getName() = NULL;
};
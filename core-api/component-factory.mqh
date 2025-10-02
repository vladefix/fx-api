//+------------------------------------------------------------------+
//|                                            component-factory.mqh |
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
#property strict

//+------------------------------------------------------------------+
//+ Responsible for creation and destruction of Service and          |
//+  ExecutableService instances.                                    |
//+ Ensures that services are singletons within the container.       |
//+ Maintains an internal registry of all active services.           |
//+ Provides centralized lifecycle management and dependency         |
//+ resolution.                                                      |
//+------------------------------------------------------------------+
template <typename C>
class ComponentFactory {

private:

public:
   ComponentFactory();
   ~ComponentFactory();
   
   virtual C* get() = 0;
};
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
template <typename C>
ComponentFactory::ComponentFactory() {

}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
template <typename C>
ComponentFactory::~ComponentFactory() {

}
//+------------------------------------------------------------------+

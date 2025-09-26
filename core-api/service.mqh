//+------------------------------------------------------------------+
//|                                                      service.mqh |
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

#include "component.mqh"

//+------------------------------------------------------------------+
//+ Represents a component that exposes logic to other components;   |
//+                                                                  |
//+ Encourages modular, reusable, and discoverable functionality;    |
//+  it comes with a lifecycle with standardized phases:             |
//+     - Initialization: at service ititialization,                 |
//+     - Refresh: whenever settings are updated,                    |
//+     - Destroy: gracefully shutdown at the end of lifecycle.      |
//+------------------------------------------------------------------+
class Service : public Component{

private:

public:
   Service(){
      initialize();
   };
   ~Service(){
      destroy();
   };
   
   virtual string getPid();
   
   virtual string getName() = NULL;
   
   virtual void refresh();
   
   virtual void initialize();
   
   virtual void destroy();
};

string Service::getPid(){
   return StringFormat(FX_LIB_COMPONENT_NAME, getName());
}

void Service::refresh(){
   destroy();
   initialize();
}

void Service::initialize(){
   
}
   
void Service::destroy(){

}
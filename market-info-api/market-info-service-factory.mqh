//+------------------------------------------------------------------+
//|                                  market-info-service-factory.mqh |
//|                                          Copyright 2025, Vladeix |
//|                                         https://www.vladefix.biz |
//+------------------------------------------------------------------+
//|                                                                  |
//| This file is part of Vladefix's fx-api framework                 |
//|                                                                  |
//| fx-api framework is free software: you can redistribute it and/or|
//| modify it under the terms of the GNU General Public License as   |
//| published by the Free Software Foundation, either version 3 of   |
//| the License, or (at your option) any later version.              |
//|                                                                  |
//| This program is distributed in the hope that it will be useful,  |
//| but WITHOUT ANY WARRANTY; without even the implied warranty of   |
//| MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.             |
//|                                                                  |
//| See the full license at:                                         |
//| https://github.com/vladefix/fx-api/blob/main/LICENSE             |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, Vladeix"
#property link      "https://www.vladefix.biz"
#property version   "1.00"
#property strict

#include <vladefix/fx-api/core-api/component-factory.mqh>

#ifdef __MQL5__
   #include <vladefix/fx-api/market-info-api/platform/mt5-market-info-service.mqh>
#else
   #ifdef __MQL4__
      #include <vladefix/fx-api/market-info-api/platform/mt4-market-info-service.mqh>
   #endif
#endif


class MarketInfoServiceFactory  : public ComponentFactory<MarketInfoService> {

private:

   static MarketInfoService* marketInfoServiceInstance;

public:
   MarketInfoServiceFactory();
    ~MarketInfoServiceFactory();
    
    static MarketInfoService* get();

};
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
MarketInfoServiceFactory::MarketInfoServiceFactory()  : ComponentFactory() {

}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
MarketInfoServiceFactory::~MarketInfoServiceFactory() {
   delete marketInfoServiceInstance;
}
//+------------------------------------------------------------------+
MarketInfoService* MarketInfoServiceFactory::marketInfoServiceInstance = NULL; 
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
MarketInfoService* MarketInfoServiceFactory::get(){

   if(marketInfoServiceInstance == NULL || CheckPointer(marketInfoServiceInstance))
      marketInfoServiceInstance = new PaltformMarketInfoService();
      
   return marketInfoServiceInstance;
}

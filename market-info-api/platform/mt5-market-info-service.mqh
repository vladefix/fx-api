//+------------------------------------------------------------------+
//|                                          market-info-service.mqh |
//|                                          Copyright 2025, Vladeix |
//|                                         https://www.vladefix.biz |
//+------------------------------------------------------------------+
//|                                                                  |
//| This file is part of Vladefix's fx-api framework                 |
//|                                                                  |
//|fx-api framework is free software: you can redistribute it and/or |
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

#include <vladefix/fx-api/market-info-api/market-info-service.mqh>

class PaltformMarketInfoService : public MarketInfoService {

private:

   int atrHandler;

   double getFromIndicator(int handle, int mode=0, int shift=0) {
   	
   	static double buffer[1];
   
   	if (handle < 0) {
   		Print("Error: Indicator not handled. (handle=",handle," | error code=",GetLastError(),")");
   		return 0;
   	}
   
   	int tryouts = 0;
   
   	while (true) {
         if (BarsCalculated(handle) > 0) {
            break;
         
   		}else{
   			tryouts++;
   
   			if (isTestingMode()) {
   				Sleep(10);
   			}else{
   				if (tryouts > 10){
   					Print("Error: Custom indicator could not load (handle=",handle," | error code=",GetLastError(),")");
   					break;
   				}
   
   				Sleep(50);
   			}
   		}
   	}
   
   	int success = CopyBuffer(handle,mode,shift,1,buffer);
   
   	if (success < 0){
   		Print("Error: Cannot get value from a custom indicator. (handle=",handle," | error code=",GetLastError(),")");
   		return 0;
   	}
   
   	return buffer[0];
   }

public:
   PaltformMarketInfoService();
   ~PaltformMarketInfoService();
   
   //+---------------------------------------------------------------+
   virtual string getSymbol();
   
   //+---------------------------------------------------------------+
   virtual double getAskPrice();
   
   //+---------------------------------------------------------------+
   virtual double getBidPrice();
   
   //+---------------------------------------------------------------+
   virtual double getClose(int, ENUM_TIMEFRAMES);
   
   //+---------------------------------------------------------------+
   virtual double getOpen(int, ENUM_TIMEFRAMES);
   
   //+---------------------------------------------------------------+
   virtual double getHigh(int, ENUM_TIMEFRAMES);
   
   //+---------------------------------------------------------------+
   virtual double getLow(int, ENUM_TIMEFRAMES);
   
   //+---------------------------------------------------------------+
   virtual double getSpread();
   
   //+---------------------------------------------------------------+
   virtual double getMinVolToPlay();
   
   //+---------------------------------------------------------------+
   virtual double getMaxVolToPlay();
   
   //+---------------------------------------------------------------+
   virtual double getCurrencyLotSize();
   
   //+---------------------------------------------------------------+
   virtual double getCurrencyLotStep();
   
   //+---------------------------------------------------------------+
   virtual double getAccountBalance();

   //+---------------------------------------------------------------+
   virtual double getMinStopLevel();
   
   //+---------------------------------------------------------------+
   virtual double getFreezeLevel();
   
   //+---------------------------------------------------------------+
   virtual datetime getTime(int, ENUM_TIMEFRAMES);

   //+---------------------------------------------------------------+
   virtual int getHour();
   
   //+---------------------------------------------------------------+
   virtual int getHour(datetime);

   //+---------------------------------------------------------------+
   virtual int getMinute();

   //+---------------------------------------------------------------+
   virtual int getMinute(datetime);

   //+---------------------------------------------------------------+
   virtual double getFreeMarginAfterCheck(double, int, double);

   //+---------------------------------------------------------------+
   virtual bool isTestingMode();  
};
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
PaltformMarketInfoService::PaltformMarketInfoService() {

   defaultTimeframe = PERIOD_CURRENT;
   
   digits = (int) NormalizeDouble( SymbolInfoInteger(NULL,SYMBOL_DIGITS), 0 );
         
   point = SymbolInfoDouble(NULL, SYMBOL_POINT);
   
   if(digits == 5 || digits == 3 || digits == 2 || digits == 1)
      pipeVal = 10;
   else 
      pipeVal = 1;
      
   atrHandler = -1;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
PaltformMarketInfoService::~PaltformMarketInfoService() {

}
//+---------------------------------------------------------------+
string PaltformMarketInfoService::getSymbol(){
   return Symbol();
}

//+---------------------------------------------------------------+
double PaltformMarketInfoService::getAskPrice(){

   MqlTick last_tick;
   SymbolInfoTick(_Symbol,last_tick);
   return last_tick.ask;
}

//+---------------------------------------------------------------+
double PaltformMarketInfoService::getBidPrice(){

   MqlTick last_tick;
   SymbolInfoTick(_Symbol,last_tick);
   return last_tick.bid;
}

//+---------------------------------------------------------------+
double PaltformMarketInfoService::getClose(int shift = 0, ENUM_TIMEFRAMES timeframe = PERIOD_CURRENT){
   return iClose(NULL,  timeframe, shift);
}

//+---------------------------------------------------------------+
double PaltformMarketInfoService::getOpen(int shift = 0, ENUM_TIMEFRAMES timeframe = PERIOD_CURRENT){
   return iOpen(NULL, timeframe, shift);
}

//+---------------------------------------------------------------+
double PaltformMarketInfoService::getHigh(int shift = 0, ENUM_TIMEFRAMES timeframe = PERIOD_CURRENT){
   return iHigh(NULL, timeframe, shift);
}

//+---------------------------------------------------------------+
double PaltformMarketInfoService::getLow(int shift = 0, ENUM_TIMEFRAMES timeframe = PERIOD_CURRENT){
   return iLow(NULL, timeframe, shift);
}

//+---------------------------------------------------------------+
double PaltformMarketInfoService::getSpread(){
   return SymbolInfoInteger(NULL, SYMBOL_SPREAD) * point;
}

//+---------------------------------------------------------------+
double PaltformMarketInfoService::getMinVolToPlay(){
   return SymbolInfoDouble(NULL, SYMBOL_VOLUME_MIN);
}

//+---------------------------------------------------------------+
double PaltformMarketInfoService::getMaxVolToPlay(){
   return SymbolInfoDouble(NULL, SYMBOL_VOLUME_MAX);
}

//+---------------------------------------------------------------+
double PaltformMarketInfoService::getCurrencyLotSize(){
   return SymbolInfoDouble(Symbol(),SYMBOL_TRADE_CONTRACT_SIZE);
}

//+---------------------------------------------------------------+
double PaltformMarketInfoService::getCurrencyLotStep(){
   return SymbolInfoDouble(Symbol(),SYMBOL_VOLUME_STEP);
}
//+---------------------------------------------------------------+
double PaltformMarketInfoService::getAccountBalance(){
   return AccountInfoDouble(ACCOUNT_BALANCE); 
}

//+---------------------------------------------------------------+
double PaltformMarketInfoService::getMinStopLevel(){
   return (double)SymbolInfoInteger(NULL, SYMBOL_TRADE_STOPS_LEVEL);
}
//+---------------------------------------------------------------+
double PaltformMarketInfoService::getFreezeLevel(){
   return (double)SymbolInfoInteger(NULL, SYMBOL_TRADE_FREEZE_LEVEL);
}
//+---------------------------------------------------------------+
datetime PaltformMarketInfoService::getTime(int shift = 0, ENUM_TIMEFRAMES timeframe = PERIOD_CURRENT){
   MqlRates r[];
   ArraySetAsSeries(r,true);
   int c= CopyRates(Symbol(), timeframe, 0, 10, r); // Copied all datas
   datetime l = r[shift].time ;
   
   ArrayFree(r);
   return l;
}
//+---------------------------------------------------------------+
int PaltformMarketInfoService::getHour(){
   MqlDateTime tm;
   TimeCurrent(tm);
   return(tm.hour);
}
//+---------------------------------------------------------------+
int PaltformMarketInfoService::getHour(datetime time){
   MqlDateTime tm;
   TimeToStruct(time, tm);
   return(tm.hour);
}
//+---------------------------------------------------------------+
int PaltformMarketInfoService::getMinute(){
   MqlDateTime tm;
   TimeCurrent(tm);
   return(tm.min);
}
//+---------------------------------------------------------------+
int PaltformMarketInfoService::getMinute(datetime time){
   MqlDateTime tm;
   TimeToStruct(time, tm);
   return(tm.min);
}
//+---------------------------------------------------------------+
double PaltformMarketInfoService::getFreeMarginAfterCheck(double volume, int opType, double price = 0.0){

   double margin = EMPTY_VALUE;
//---

   ENUM_ORDER_TYPE trade_operation = ORDER_TYPE_BUY; 
   
   if(opType == 1)
      trade_operation = ORDER_TYPE_SELL;
   
   if(!OrderCalcMargin(trade_operation,Symbol(), volume, price, margin))
      return(EMPTY_VALUE);
//---
   return(margin);
}
//+---------------------------------------------------------------+
bool PaltformMarketInfoService::isTestingMode(){
   return (bool) MQLInfoInteger(MQL_TESTER);
}
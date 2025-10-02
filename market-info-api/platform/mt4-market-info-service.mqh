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

protected:

   virtual double getVolatility(int period, ENUM_TIMEFRAMES);

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
   
   digits = (int) NormalizeDouble( MarketInfo(NULL, MODE_DIGITS), 0 );
         
   point = MarketInfo(NULL, MODE_POINT);
   
   if(digits == 5 || digits == 3 || digits == 2 || digits == 1)
      pipeVal = 10;
   else 
      pipeVal = 1;
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
PaltformMarketInfoService::~PaltformMarketInfoService() {

}
//+---------------------------------------------------------------+
double PaltformMarketInfoService::getVolatility(int period, ENUM_TIMEFRAMES timeframe = PERIOD_CURRENT){
   return iATR(NULL, timeframe, period, 1);   
}
//+---------------------------------------------------------------+
string PaltformMarketInfoService::getSymbol(){
   return Symbol();;
}

//+---------------------------------------------------------------+
double PaltformMarketInfoService::getAskPrice(){
   return Ask;
}

//+---------------------------------------------------------------+
double PaltformMarketInfoService::getBidPrice(){
   return Bid;
}

//+---------------------------------------------------------------+
double PaltformMarketInfoService::getClose(int shift = 0, ENUM_TIMEFRAMES timeframe = PERIOD_CURRENT){
   return iClose(NULL, timeframe, shift);
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
   return MarketInfo(NULL, MODE_SPREAD) * point;
}

//+---------------------------------------------------------------+
double PaltformMarketInfoService::getMinVolToPlay(){
   return MarketInfo(NULL, MODE_MINLOT);
}

//+---------------------------------------------------------------+
double PaltformMarketInfoService::getMaxVolToPlay(){
   return MarketInfo(NULL, MODE_MAXLOT);
}

//+---------------------------------------------------------------+
double PaltformMarketInfoService::getCurrencyLotSize(){
   return MarketInfo(Symbol(),MODE_LOTSIZE);
}

//+---------------------------------------------------------------+
double PaltformMarketInfoService::getCurrencyLotStep(){
   return MarketInfo(NULL, MODE_LOTSTEP);
}

//+---------------------------------------------------------------+
double PaltformMarketInfoService::getAccountBalance(){
   return AccountBalance();;
}

//+---------------------------------------------------------------+
double PaltformMarketInfoService::getMinStopLevel(){
   return MarketInfo(NULL, MODE_STOPLEVEL);
}
//+---------------------------------------------------------------+
double PaltformMarketInfoService::getFreezeLevel(){
   return MarketInfo(NULL, MODE_FREEZELEVEL);
}
//+---------------------------------------------------------------+
datetime PaltformMarketInfoService::getTime(int shift = 0, ENUM_TIMEFRAMES timeframe = PERIOD_CURRENT){
   return iTime(NULL, timeframe, shift);
}

//+---------------------------------------------------------------+
int PaltformMarketInfoService::getHour(){
   return Hour();
}

//+---------------------------------------------------------------+
int PaltformMarketInfoService::getHour(datetime time){
   return TimeHour(time);
}

//+---------------------------------------------------------------+
int PaltformMarketInfoService::getMinute(){
   return Minute();
}

//+---------------------------------------------------------------+
int PaltformMarketInfoService::getMinute(datetime time){
   return TimeMinute(time);
}

//+---------------------------------------------------------------+
double PaltformMarketInfoService::getFreeMarginAfterCheck(double volume, int opType, double price = 0.0){
   return AccountFreeMarginCheck(NULL, opType, volume);
}

//+---------------------------------------------------------------+
bool PaltformMarketInfoService::isTestingMode(){
   return false;
}
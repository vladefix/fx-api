//+------------------------------------------------------------------+
//|                                          market-info-service.mqh |
//|                                         Copyright 2025, Vladefix |
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

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class MarketInfoService {

private:

protected: 

   ENUM_TIMEFRAMES defaultTimeframe; 

   int pipeVal;
   int digits;
   double point;
   
   virtual double getVolatility(int period, ENUM_TIMEFRAMES) = 0;

   double internalNormalizeVolume(double volume){
   
      double minLotVolume = getMinVolToPlay();
      double volumeStep   = getCurrencyLotStep();
   
      int vp = (int) MathRound(volume * 100.0);
      int vs = (int) MathRound(volumeStep * 100.0);
      
      double delta = vp % vs;
      double normalizedVolume = vp - delta;
      
      if(normalizedVolume > 0)
         normalizedVolume = normalizedVolume / 100;
      
      // verify if lot has correct size 
      if(normalizedVolume > 0){
         if(normalizedVolume >= minLotVolume)
            return normalizedVolume;
            
         if(delta != 0){
            return (vp + delta) / 100;
         }
      }
      
      normalizedVolume = vp / 100;
      
      return normalizedVolume;
   }

public:
   MarketInfoService();
   ~MarketInfoService();
   
   //+---------------------------------------------------------------+
   //| The name of the current chart symbol                          |
   //+---------------------------------------------------------------+
   virtual string getSymbol() = 0;
   
   //+---------------------------------------------------------------+
   //| The latest known seller's price (ask price)                   |
   //| for the current symbol                                        |
   //+---------------------------------------------------------------+
   virtual double getAskPrice() = 0;
   
   //+---------------------------------------------------------------+
   //| The latest known buyer's price (offer price, bid price)       |
   //| for the current symbol                                        |
   //+---------------------------------------------------------------+
   virtual double getBidPrice() = 0;
   
   //+---------------------------------------------------------------+
   //| Returns Close price value for the bar of specified symbol     |
   //| with shift and timeframe.                                     |
   //+---------------------------------------------------------------+
   virtual double getClose(int, ENUM_TIMEFRAMES) = 0;
   
   //+---------------------------------------------------------------+
   //| Returns Open price value for the bar of specified symbol      |
   //| with shift and timeframe.                                     |
   //+---------------------------------------------------------------+
   virtual double getOpen(int, ENUM_TIMEFRAMES) = 0;
   
   //+---------------------------------------------------------------+
   //| Returns High price value for the bar of specified symbol      |
   //| with shift and timeframe.                                     |
   //+---------------------------------------------------------------+
   virtual double getHigh(int, ENUM_TIMEFRAMES) = 0;
   
   //+---------------------------------------------------------------+
   //| Returns Low price value for the bar of indicated symbol       |
   //| with shift and timeframe.                                     |
   //+---------------------------------------------------------------+
   virtual double getLow(int, ENUM_TIMEFRAMES) = 0;
   
   //+---------------------------------------------------------------+
   //| Returns spread value in points                                |
   //+---------------------------------------------------------------+
   virtual double getSpread() = 0;
   
   //+---------------------------------------------------------------+
   //| Returns minimum permitted amount of a lot                     |
   //+---------------------------------------------------------------+
   virtual double getMinVolToPlay() = 0;
   
   //+---------------------------------------------------------------+
   //| Returns maximum permitted amount of a lot                     |
   //+---------------------------------------------------------------+
   virtual double getMaxVolToPlay() = 0;
   
   //+---------------------------------------------------------------+
   //| Lot size in the base currency                                 |
   //+---------------------------------------------------------------+
   virtual double getCurrencyLotSize() = 0;
   
   //+---------------------------------------------------------------+
   //| Step for changing lots                                        |
   //+---------------------------------------------------------------+
   virtual double getCurrencyLotStep() = 0;
   
   //+---------------------------------------------------------------+
   //| Returns normalized amount of volume to play                   |
   //| (not greather than max amount not lower of min amount and     |
   //| with 0.00 format)                                             |
   //+---------------------------------------------------------------+
   virtual double normalizeVolume(double);
   
   //+---------------------------------------------------------------+
   //| Returns balance value of the current account                  |
   //| (the amount of money on the account).                         |
   //+---------------------------------------------------------------+
   virtual double getAccountBalance() = 0;
   
   //+---------------------------------------------------------------+
   //| Stop level in points.                                         |
   //+---------------------------------------------------------------+
   virtual double getMinStopLevel() = 0;
   
   //+---------------------------------------------------------------+
   //| Order freeze level in points.                                 |
   //| If the execution price lies within the range defined by the   |
   //| freeze level, the order cannot be modified, cancelled or      |
   //| closed                                                        |
   //+---------------------------------------------------------------+
   virtual double getFreezeLevel() = 0;
   
   //+---------------------------------------------------------------+
   //| Normalize a double according to value of point and pip value  |
   //| of the current currency                                       |
   //+---------------------------------------------------------------+
   virtual double adaptToCurrency(double);
   
   //+---------------------------------------------------------------+
   //| Multiply a double for the value of the volatility for the     |
   //| specified period (returned by iATR indicator)                 |
   //+---------------------------------------------------------------+
   virtual double getVolatility(int, double, ENUM_TIMEFRAMES);
   
   //+---------------------------------------------------------------+
   //| Count of digits after decimal point in the symbol prices      |
   //+---------------------------------------------------------------+
   virtual int getCurrencyDigits();
   
   //+---------------------------------------------------------------+
   //| Set a custom value of digits after decimal point              |
   //+---------------------------------------------------------------+
   virtual void setCurrencyDigits(int);
   
   //+---------------------------------------------------------------+
   //| Point size in the quote currency.                             |
   //+---------------------------------------------------------------+
   virtual double getCurrencyPoint();
   
   //+---------------------------------------------------------------+
   //| Pip value for the currency                                    |
   //+---------------------------------------------------------------+
   virtual int getCurrencyPipeVal();
   
   //+---------------------------------------------------------------+
   //| Returns Time value for the bar of specified symbol            |
   //| with shift and timeframe                                      |
   //+---------------------------------------------------------------+
   virtual datetime getTime(int, ENUM_TIMEFRAMES) = 0;
   
   //+---------------------------------------------------------------+
   //| Returns the hour of the last known server time                |
   //+---------------------------------------------------------------+
   virtual int getHour() = 0;
   
   //+---------------------------------------------------------------+
   //| Returns the hour of the specified time.                       |
   //+---------------------------------------------------------------+
   virtual int getHour(datetime) = 0;
      
   //+---------------------------------------------------------------+
   //| Returns the minute of the last known server time              |
   //+---------------------------------------------------------------+
   virtual int getMinute() = 0;
   
   //+---------------------------------------------------------------+
   //| Returns the minute of the specified time.                     |
   //+---------------------------------------------------------------+
   virtual int getMinute(datetime) = 0;
   
   //+---------------------------------------------------------------+
   //| Returns free margin that remains after the specified order    |
   //| has been opened at the current price on the current account.  |
   //+---------------------------------------------------------------+
   virtual double getFreeMarginAfterCheck(double, int, double) = 0;
   
   //+---------------------------------------------------------------+
   //| Format a double according to the currency format              |
   //+---------------------------------------------------------------+   
   virtual string doubleToCurrencyString(double);
   
   //+---------------------------------------------------------------+
   //| returns true if program is run in stratefy tester             |
   //+---------------------------------------------------------------+
   virtual bool isTestingMode() = 0;  
};
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
MarketInfoService::MarketInfoService() {

}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
MarketInfoService::~MarketInfoService() {

}
//+------------------------------------------------------------------+
double MarketInfoService::adaptToCurrency(double subject){
   return subject * point * pipeVal;
}
//+------------------------------------------------------------------+
double MarketInfoService::normalizeVolume(double volume){

   double minLotVolume = getMinVolToPlay();
   double maxLotVolume = getMaxVolToPlay();
   double volumeStep   = getCurrencyLotStep();
   
   double normalizedVolume = internalNormalizeVolume(volume);

   if(normalizedVolume < minLotVolume){

      return minLotVolume; 
   }
   
   if(normalizedVolume > maxLotVolume)
      return maxLotVolume;
      
   return normalizedVolume;
}
//+------------------------------------------------------------------+
double MarketInfoService::getVolatility(int period, double multiplier, ENUM_TIMEFRAMES timeframe = PERIOD_CURRENT){

   double atr =  getVolatility(period, timeframe);
   
   double volatility = 0.0;

   if(digits == 5){
      
      volatility = (atr * 10000) * multiplier;
   
   }else if(digits == 3) {
   
      volatility = (atr * 100) * multiplier;
      
   }else if(digits == 2) {
   
      volatility = (atr * 10) * multiplier;
   
   }else if (digits == 1){
   
      volatility = (atr * 1) * multiplier;
   }

   return volatility;
   return 0.0;
}
//+------------------------------------------------------------------+
int MarketInfoService::getCurrencyDigits(){
   return digits;
}

//+------------------------------------------------------------------+
void MarketInfoService::setCurrencyDigits(int customDigits){
   
   digits = customDigits;

   if(digits == 5 || digits == 3 || digits == 2 || digits == 1)
      pipeVal = 10;
   else 
      pipeVal = 1;
}

//+------------------------------------------------------------------+
double MarketInfoService::getCurrencyPoint(){
   return point;
}

//+------------------------------------------------------------------+
int MarketInfoService::getCurrencyPipeVal(){
   return pipeVal;
}
//+------------------------------------------------------------------+   
string MarketInfoService::doubleToCurrencyString(double subject){

   static string digitsStr = IntegerToString(getCurrencyDigits());
   
   return StringFormat("%." + digitsStr + "f", subject);
}
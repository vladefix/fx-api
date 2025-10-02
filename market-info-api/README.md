# MarketInfoService

The `MarketInfoService` class provides a **generic API layer** to access market information and account data in both **MetaTrader 4 (MT4)** and **MetaTrader 5 (MT5)** platforms.  
By abstracting platform-specific differences, this class allows developers to write trading logic that can run seamlessly on either platform without modification.

---

## ✨ Features

- Unified interface for **symbol information** (bid, ask, spread, digits, lot size, etc.)
- Access to **OHLC prices** (open, high, low, close) for any symbol and timeframe
- Account-related queries such as **balance, free margin, stop levels, freeze levels**
- Utility methods for **normalizing volumes, adapting values to currency precision, volatility calculations**
- Time utilities for **bar timestamps, server time, hours, and minutes**
- Support for **strategy tester detection**

---

## 📦 Class Overview

```
class MarketInfoService {
public:
    MarketInfoService();
    ~MarketInfoService();

    // Symbol & Price
    virtual string getSymbol();
    virtual double getAskPrice();
    virtual double getBidPrice();
    virtual double getSpread();

    // OHLC Data
    virtual double getClose(int shift, ENUM_TIMEFRAMES tf);
    virtual double getOpen(int shift, ENUM_TIMEFRAMES tf);
    virtual double getHigh(int shift, ENUM_TIMEFRAMES tf);
    virtual double getLow(int shift, ENUM_TIMEFRAMES tf);

    // Volume & Lot
    virtual double getMinVolToPlay();
    virtual double getMaxVolToPlay();
    virtual double getCurrencyLotSize();
    virtual double getCurrencyLotStep();
    virtual double normalizeVolume(double volume);

    // Account
    virtual double getAccountBalance();
    virtual double getFreeMarginAfterCheck(double price, int type, double volume);

    // Trading Constraints
    virtual double getMinStopLevel();
    virtual double getFreezeLevel();

    // Currency Precision
    virtual int getCurrencyDigits();
    virtual void setCurrencyDigits(int digits);
    virtual double getCurrencyPoint();
    virtual int getCurrencyPipeVal();
    virtual string doubleToCurrencyString(double value);

    // Time
    virtual datetime getTime(int shift, ENUM_TIMEFRAMES tf);
    virtual int getHour();
    virtual int getHour(datetime t);
    virtual int getMinute();
    virtual int getMinute(datetime t);

    // Volatility
    virtual double getVolatility(int period, double multiplier, ENUM_TIMEFRAMES tf);

    // Environment
    virtual bool isTestingMode();
};
```

## Usage 

```
// Example usage
MarketInfoService* market = MarketInfoServiceFactory::get();

// Get current symbol and prices
string symbol = market.getSymbol();
double ask    = market.getAskPrice();
double bid    = market.getBidPrice();

// Get OHLC data
double lastClose = market.>getClose(1, PERIOD_H1);

// Normalize volume before sending an order
double vol = market.normalizeVolume(0.15);

// Check account balance
double balance = market.getAccountBalance();

// Clean up
delete market;

```
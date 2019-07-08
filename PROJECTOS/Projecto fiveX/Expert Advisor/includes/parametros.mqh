//+------------------------------------------------------------------+
//|                                                   Parametros.mqh |
//|                                    Copyright 2019, Daniel Albino |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, Daniel Albino"
#property link      ""
#property strict

// External variables ------------------------------------------------
input string    txt         = "-- MAGIC NUMBER--";    
input int       MAGICNUMBER = 1001;     // magic number

input string    txt2        = "-- Moving Average--";
input int       timeframe   = 15;       // time frame
input int       period      = 100;      // period

input string    txt3        = "-- TrailingStop --";
input int       Trail       = 100;      // TrailingStop size

input string    txt4        = "-- Money Management --";
input double    minlote     = 0.01;     // minimum lot
input double    lotsize     = 1;        // lot size
input int       lotdigist   = 3;        // lot digits
input double    risk        = 2.0;      // risk percentage
input int       stoploss    = 300;      // stoploss 
input double    winpercent  = 1;        // win percentage per trade

input string    txt5        = "-- Partial close --";
input int       valor_fecho = 2;        // partial close


input int string   txt6      = "-- Percentual Close --";
input int double   percent   = 5.0;     // percentage

input int string   txt6      = "-- TIME TO H/L --";
input int        TIMEFRAME   = 60;
input int       NBackCandles = 7;
input string EndofOpeningPeriod = "08:00:";



// internal variables ------------------------------------------------
double  BuyPercentage, SellPercentage;
double  AcountMoney = AccountBalance();
double  sellprofit, buyprofit;

   
string CURRENTTIME = TimeToStr(TimeLocal(), TIME_SECONDS);
int EndofOpeningPeriodFound = StringFind(CURRENTTIME,EndofOpeningPeriod,0);
int HighestCandle =  iHighest(_Symbol,TIMEFRAME,MODE_HIGH,NBackCandles,1);
int LowestCandle =  iLowest(_Symbol,TIMEFRAME,MODE_LOW,NBackCandles,1);


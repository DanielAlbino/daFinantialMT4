//+------------------------------------------------------------------+
//|                                                       Five-X.mq4 |
//|                                        Copyright 2019, Daniel A. |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, Daniel A."
#property link      
#property version   "1.00"
#property strict

#include "includes/includes.mqh"

void OnTick(){
    HIGHLOWDAILY();
    PARAMS(); 
}

void HIGHLOWDAILY(){
    EndofOpeningPeriodFound = StringFind(CURRENTTIME,EndofOpeningPeriod,0);

    if(EndofOpeningPeriodFound != -1){
        HighestCandle =  High[iHighest(_Symbol,TIMEFRAME,MODE_HIGH,7,1)];
        LowestCandle =  Low[iLowest(_Symbol,TIMEFRAME,MODE_LOW,7,1)];
        totalHL = fabs(HighestCandle-LowestCandle);
    }    
}

void PARAMS(){
    sma = SMA(timeframe, period);
    SellPercentage = SELLGAINPERCENTAGE(MAGICNUMBER);
    BuyPercentage = BUYGAINPERCENTAGE(MAGICNUMBER);
    lots = lotsoptimized(risk, stoploss, lotsize, minlote, lotdigist);
}
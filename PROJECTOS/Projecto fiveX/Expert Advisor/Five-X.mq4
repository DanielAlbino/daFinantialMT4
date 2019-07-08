//+------------------------------------------------------------------+
//|                                                       Five-X.mq4 |
//|                                        Copyright 2019, Daniel A. |
//+------------------------------------------------------------------+
#property copyright "Copyright 2017, Tor"
#property link      
#property version   "1.00"
#property strict

#include "includes/includes.mqh"



void OnTick(){
    HIGHLOWDAILY();
}

void HIGHLOWDAILY(){

    EndofOpeningPeriodFound = StringFind(CURRENTTIME,EndofOpeningPeriod,0);

    if(EndofOpeningPeriodFound != -1){
        HighestCandle =  High[iHighest(_Symbol,TIMEFRAME,MODE_HIGH,7,1)];
        LowestCandle =  Low[iLowest(_Symbol,TIMEFRAME,MODE_LOW,7,1)];
    }    
}
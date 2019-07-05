//+------------------------------------------------------------------+
//|                                                         OCHL.mq4 |
//|                                    Copyright 2019, Daniel Albino |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, Daniel Albino"
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

int TIMEFRAME = 15;
double O[11];
double C[11];
double H[11];
double L[11];
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
     for(int i = 10; i > 0; i--)
   {
      O[i] = iOpen(Symbol(),TIMEFRAME,i);
      H[i] = iHigh(Symbol(),TIMEFRAME,i);
      L[i] = iLow(Symbol(),TIMEFRAME,i);
      C[i] = iClose(Symbol(),TIMEFRAME,i);
      
      printf("OPEN: "+DoubleToStr(O[i]));
      printf("CLOSE: "+DoubleToStr(C[i]));
      printf("HIGH: "+DoubleToStr(H[i]));
      printf("LOW: "+DoubleToStr(L[i]));
   } 
      
  }
//+------------------------------------------------------------------+

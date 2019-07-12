//+------------------------------------------------------------------+
//|                                    Copyright 2019, Daniel Albino |
//+------------------------------------------------------------------+

#property strict

input string    txt1        = "-- MagicNumber--";
input int       magic       = 1001;

input int       timeframe   = 60;


//define o fim do periodo de abertura
string EndofOpeningPeriod = "08:00:";
string CURRENTTIME = TimeToStr(iTime(_Symbol,timeframe,0), TIME_SECONDS);
int EndofOpeningPeriodFound = StringFind(CURRENTTIME,EndofOpeningPeriod,0);
int HighestCandle =  iHighest(_Symbol,TIMEFRAME,MODE_HIGH,8,1);
int LowestCandle =  iLowest(_Symbol,TIMEFRAME,MODE_LOW,8,1);


void OnTick()
  {
      for(var i = Bars(); i > 0; i--){
          CURRENTTIME = TimeToStr(iTime(_Symbol,timeframe,i), TIME_SECONDS);
          EndofOpeningPeriodFound = StringFind(CURRENTTIME,EndofOpeningPeriod,0); 
          if(EndofOpeningPeriodFound != -1  && timeframe == Period()){
          HighestCandle =  iHighest(_Symbol,TIMEFRAME,MODE_HIGH,9,1);
          LowestCandle =  iLowest(_Symbol,TIMEFRAME,MODE_LOW,9,1);
          //delete the object if exists
          ObjectDelete("Rectangle");
          //create object
          ObjectCreate(0,"Rectangle",OBJ_RECTANGLE,0,Time[1],High[HighestCandle],Time[8],Low[LowestCandle]);
        }   
      }
       
  }

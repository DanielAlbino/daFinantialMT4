//+------------------------------------------------------------------+
//|                                    Copyright 2019, Daniel Albino |
//+------------------------------------------------------------------+

#property strict

input string    txt1        = "-- MagicNumber--";
input int       magic       = 1001; // magic number

input string    txt2        = "-- TIME --";
input int       timeframe   = 60; // chart timeframe
input int       timecheck   = 3; // every x Hours


//define o fim do periodo de abertura
string EndofOpeningPeriod = "0"timecheck":00:";
string CURRENTTIME = TimeToStr(iTime(_Symbol,timeframe,0), TIME_SECONDS);
int EndofOpeningPeriodFound = StringFind(CURRENTTIME,EndofOpeningPeriod,0);
int HighestCandle =  iHighest(_Symbol,TIMEFRAME,MODE_HIGH,3,1);
int LowestCandle =  iLowest(_Symbol,TIMEFRAME,MODE_LOW,3,1);


void OnTick()
  {
      EndofOpeningPeriod = "0"timecheck":00:";
      for(var i = Bars(); i > 0; i--){
          CURRENTTIME = TimeToStr(iTime(_Symbol,timeframe,i), TIME_SECONDS);
          EndofOpeningPeriodFound = StringFind(CURRENTTIME,EndofOpeningPeriod,0); 
          if(EndofOpeningPeriodFound != -1  && timeframe == Period()){
          HighestCandle =  iHighest(_Symbol,TIMEFRAME,MODE_HIGH,3,1);
          LowestCandle =  iLowest(_Symbol,TIMEFRAME,MODE_LOW,3,1);
          //delete the object if exists
          ObjectDelete("Rectangle");
          //create object
          ObjectCreate(0,"Rectangle",OBJ_RECTANGLE,0,Time[1],High[HighestCandle],Time[3],Low[LowestCandle]);
          timecheck += 3;
          if(timecheck == 24){timecheck = 0;}
        }   
      }
       
  }

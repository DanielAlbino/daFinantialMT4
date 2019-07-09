//+------------------------------------------------------------------+
//|                                                      SUP-RES.mq4 |
//|                                    Copyright 2019, Daniel Albino |
//+------------------------------------------------------------------+

int TIMEFRAME = 60;
    
//define o fim do periodo de abertura
string EndofOpeningPeriod = "08:00:";

string CURRENTTIME = TimeToStr(TimeLocal(), TIME_SECONDS);

int EndofOpeningPeriodFound = StringFind(CURRENTTIME,EndofOpeningPeriod,0);

int HighestCandle =  iHighest(_Symbol,TIMEFRAME,MODE_HIGH,8,1);
int LowestCandle =  iLowest(_Symbol,TIMEFRAME,MODE_LOW,8,1);

int OnInit()
  {
   return(INIT_SUCCEEDED);
  }

void OnDeinit(const int reason){}

void OnTick(){
    HLCHECK();
    PUTARROW();
}

void HLCHECK(){
    CURRENTTIME = TimeToStr(TimeLocal(), TIME_SECONDS);
    EndofOpeningPeriodFound = StringFind(CURRENTTIME,EndofOpeningPeriod,0);

    if(EndofOpeningPeriodFound != -1 ){
        HighestCandle =  iHighest(_Symbol,TIMEFRAME,MODE_HIGH,7,1);
        LowestCandle =  iLowest(_Symbol,TIMEFRAME,MODE_LOW,7,1);
        HH = High[HighestCandle];
        LL = Low[LowestCandle];
        totalHL = fabs(HH-LL);
    }
}

void PUTARROW(){
    if(Open[1] < HH && Open[1] > LL+(fabs(HH-LL)/2) && Close[1] > HH && Bid > HH && CURRENTTIME > "08:00" && CURRENTTIME < "23:00" && TIMEFRAME = Period()){
        DrawArrowUp("uparrow",Open[1]-20*Point,clrGreen);    
    }

    if(Open[1] > LL && Open[1] < HH-(fabs(HH-LL)/2) && Close[1] < LL && Bid < LL && CURRENTTIME > "08:00" && CURRENTTIME < "23:00" && TIMEFRAME = Period()){
        DrawArrowDown("downarrow",Open[1]+20*Point,clrRed);
    }
  }




void DrawArrowUp(string ArrowName,double LinePrice,color LineColor)
{
    ObjectCreate(ArrowName, OBJ_ARROW, 0, Time[0], LinePrice); //draw an up arrow
    ObjectSet(ArrowName, OBJPROP_STYLE, STYLE_SOLID);
    ObjectSet(ArrowName, OBJPROP_ARROWCODE, SYMBOL_ARROWUP);
    ObjectSet(ArrowName, OBJPROP_COLOR,LineColor);
}

void DrawArrowDown(string ArrowName,double LinePrice,color LineColor)
{
    ObjectCreate(ArrowName, OBJ_ARROW, 0, Time[0], LinePrice); //draw an up arrow
    ObjectSet(ArrowName, OBJPROP_STYLE, STYLE_SOLID);
    ObjectSet(ArrowName, OBJPROP_ARROWCODE, SYMBOL_ARROWDOWN);
    ObjectSet(ArrowName, OBJPROP_COLOR,LineColor);
}
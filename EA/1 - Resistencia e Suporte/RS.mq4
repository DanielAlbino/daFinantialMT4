    int TIMEFRAME = 60;
    //define o fim do periodo de abertura
    string EndofOpeningPeriod = "08:00:";

    string CURRENTTIME = TimeToStr(TimeLocal(), TIME_SECONDS);

    int EndofOpeningPeriodFound = StringFind(CURRENTTIME,EndofOpeningPeriod,0);

    int HighestCandle =  iHighest(_Symbol,TIMEFRAME,MODE_HIGH,7,1);
    int LowestCandle =  iLowest(_Symbol,TIMEFRAME,MODE_LOW,7,1);



void OnTick(){
    createObject();
}



void createObject(){
     //output the current time
    Comment("Current Time: ", CURRENTTIME);
    HighestCandle =  iHighest(_Symbol,TIMEFRAME,MODE_HIGH,7,1);
    LowestCandle =  iLowest(_Symbol,TIMEFRAME,MODE_LOW,7,1);

    if(EndofOpeningPeriodFound != -1){
         //delete the object if exists
         ObjectDelete("Rectangle");
         //create object
         ObjectCreate("Rectangle",OBJ_ECTANGLE,0,Time[1],High[HighestCandle],Time[7],Low[LowestCandle]);
    }
}
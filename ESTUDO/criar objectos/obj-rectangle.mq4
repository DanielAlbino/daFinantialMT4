void OnTick(){
    int TIMEFRAME = 60;
    //define o fim do periodo de abertura
    string EndofOpeningPeriod = "08:00:";

    string CURRENTTIME = TimeToStr(TimeLocal(), TIME_SECONDS);

    int EndofOpeningPeriodFound = StringFind(CURRENTTIME,EndofOpeningPeriod,0);

    int HighestCandle =  iHighest(_Symbol,TIMEFRAME,MODE_HIGH,7,1);
    int LowestCandle =  iLowest(_Symbol,TIMEFRAME,MODE_LOW,7,1);

    //output the current time
    Comment("Current Time: ", CURRENTTIME);

<<<<<<< HEAD
    if(EndofOpeningPeriodFound != -1 ){

        //delete the object if exists
        ObjectDelete("Rectangle");

        //create object
        ObjectCreate("Rectangle",OBJ_RECTANGLE,0,Time[1],High[HighestCandle],Time[8],Low[LowestCandle]);

=======
    if(EndofOpeningPeriodFound != -1){

        switch(Period())
        {
            case 15: 
                 //delete the object if exists
                ObjectDelete("Rectangle");
                //create object
                ObjectCreate("Rectangle",OBJ_ECTANGLE,0,Time[1],High[HighestCandle],Time[28],Low[LowestCandle]);
                break;
                
            case 60: 
                 //delete the object if exists
                ObjectDelete("Rectangle");
                //create object
                ObjectCreate("Rectangle",OBJ_ECTANGLE,0,Time[1],High[HighestCandle],Time[7],Low[LowestCandle]);
                break;

            case 240: 
                 //delete the object if exists
                ObjectDelete("Rectangle");
                //create object
                ObjectCreate("Rectangle",OBJ_ECTANGLE,0,Time[1],High[HighestCandle],Time[3],Low[LowestCandle]);
                break;

            default: 0;
        }
>>>>>>> b4bcd2cf2263b794ce267b89b886fdb4c45494c9
    }
}
//+------------------------------------------------------------------+
//|                                                      RS-TEST.mq4 |
//|                                    Copyright 2019, Daniel Albino |
//+------------------------------------------------------------------+
#property strict
input string    txt1        = "-- MagicNumber--";
input int       magic       = 1001;

input string    txt4        = "-- Money Management --";
input double    minlote     = 2;     // minimum lot
input double    lotsize     = 1;        // lot size
input int       lotdigist   = 3;        // lot digits
input double    risk        = 2.0;      // risk percentage
input int       stoploss    = 20;      // stoploss 
input int       profit      = 15;
input int       trail       = 15;
input int      time         = 15;
    int TIMEFRAME = 60;
    
    //define o fim do periodo de abertura
    string EndofOpeningPeriod = "08:00:";

    string CURRENTTIME = TimeToStr(TimeLocal(), TIME_SECONDS);

    int EndofOpeningPeriodFound = StringFind(CURRENTTIME,EndofOpeningPeriod,0);

    int HighestCandle =  iHighest(_Symbol,TIMEFRAME,MODE_HIGH,8,1);
    int LowestCandle =  iLowest(_Symbol,TIMEFRAME,MODE_LOW,8,1);
    
    double HH = 0;i 0!
    double LL = 999;
    double totalHL = 0.0;
  int nbuy = 0,nsell = 0;
  
  //problemas a resolver:
  /*
  
   quando a vela está abaixo e faz um spike a passar a resistencia não pode abrir trade
   
 */
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
//---
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
      CURRENTTIME = TimeToStr(TimeLocal(), TIME_SECONDS);
      EndofOpeningPeriodFound = StringFind(CURRENTTIME,EndofOpeningPeriod,0);
      
     printf(EndofOpeningPeriodFound);
     printf(CURRENTTIME);
     
      if(EndofOpeningPeriodFound != -1 ){
          HighestCandle =  iHighest(_Symbol,TIMEFRAME,MODE_HIGH,7,1);
          LowestCandle =  iLowest(_Symbol,TIMEFRAME,MODE_LOW,7,1);
          HH = High[HighestCandle];
          LL = Low[LowestCandle];
          if(fabs(HH-LL) >= 100*Points){
              totalHL = 50*Points;
          } else {
               totalHL = fabs(HH-LL);
          }
         
        //delete the object if exists
        ObjectDelete("Rectangle");

        //create object
        ObjectCreate(0,"Rectangle",OBJ_RECTANGLE,0,Time[1],High[HighestCandle],Time[8],Low[LowestCandle]);

    }
      BUY(minlote,1,300,"Buy ",magic,clrGreen);
      SELL(minlote,1,300,"Sell ",magic,clrRed);
      
      nbuy =  ORDERBUY(magic);
      nsell = ORDERSELL(magic);
  }
//+------------------------------------------------------------------+


void BUY(double lot, int slippage, int stoploss1, string comment, int magicnumber, color scolor){
   if( Open[0] >= LL+fabs(totalHL/2) && Open[0] < HH && Close[0] > HH && nbuy < 1 && CURRENTTIME > "08:00" && CURRENTTIME < "17:00"){
       double order;
       order = OrderSend(Symbol(), OP_BUY,lot,Ask,slippage,LL,Bid+trail*Point,comment, magicnumber,0, scolor);
   }
   
}

void SELL(double lot, int slippage, int stoploss1, string comment, int magicnumber, color scolor){
   if( Open[0] <= HH-fabs(totalHL/2) && Open[0] > LL && Close[0] < LL && nsell < 1  && CURRENTTIME > "08:00" && CURRENTTIME < "17:00"){
       double order;
       order = OrderSend(Symbol(), OP_SELL,lot,Ask,slippage,HH,Ask-trail*Point,comment, magicnumber,0, scolor);
   }
}



void TrailingAlls(int magic, int trail)
  {
         double PointValue;
         double ordem;
         for (int i = 0; i < OrdersTotal(); i++)
         {
            ordem = OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
            PointValue = MarketInfo(OrderSymbol(), MODE_POINT);
            //Normalize trailing stop value to the point value
            double TSTP = trail * PointValue;
            if (OrderType() == OP_BUY && OrderMagicNumber() == magic)
               { if ((Bid - OrderOpenPrice()) > TSTP)
                  { if (OrderStopLoss() < (Bid - TSTP))
                     {
                        ordem = OrderModify(OrderTicket(), OrderOpenPrice(), Bid - TSTP, OrderTakeProfit(), Red);
                     }
                  }
               }
			   
            else 
			
			if (OrderType() == OP_SELL && OrderMagicNumber() == magic)
               { if ((OrderOpenPrice() - Ask) > trail * PointValue)
                  { if ((OrderStopLoss() > (Ask + trail * PointValue)) || (OrderStopLoss() == 0))
                     {
                        ordem = OrderModify(OrderTicket(), OrderOpenPrice(), Ask + TSTP, OrderTakeProfit(), Red);
                     }
                  }
               }
         }
}

int ORDERBUY(int magic){
    int buys = 0;
    double ord;
     for( int i = 0 ; i < OrdersTotal() ; i++ ) {
     ord =  OrderSelect( i, SELECT_BY_POS, MODE_TRADES );
      if( OrderMagicNumber() == magic ){
          if(OrderType() == OP_BUY){
              buys++;
          }
      }
   }

   return buys;
}

int  ORDERSELL(int magic){
    int sells = 0;
    double ord;
     for( int i = 0 ; i < OrdersTotal() ; i++ ) {
     ord = OrderSelect( i, SELECT_BY_POS, MODE_TRADES );
      if( OrderMagicNumber() == magic){
          if(OrderType() == OP_SELL){
            sells++;
          }
      }
   }
   return sells;
}

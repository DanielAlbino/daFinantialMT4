//+------------------------------------------------------------------+
//|                                            PercentagemProfit.mqh |
//|                                    Copyright 2019, Daniel Albino |
//+------------------------------------------------------------------+

#include "includes.mqh"

double  BuyPercentage, SellPercentage;
double  AcountMoney = AccountBalance();
double  sellprofit, buyprofit;

void BUYTRADESPROFITLOSS(){
    buyprofit = BUYGAINPERCENTAGE(MAGICNUMBER);
    BuyPercentage = (buyprofit*100)/AcountMoney;

    PrintText2("buy", "% BUY: ", BuyPercentage,200,10,clrGreen);
}

void SELLTRADESPROFITLOSS(){
    sellprofit = SELLGAINPERCENTAGE(MAGICNUMBER);
    SellPercentage = (sellprofit*100)/AcountMoney;
    
     PrintText2("sell", "% SELL: ", SellPercentage,300,10,clrRed);
}


double SELLGAINPERCENTAGE(int magic)
{
    int sellspercent = 0;
     for( int i = 0 ; i < OrdersTotal() ; i++ ) {
      OrderSelect( i, SELECT_BY_POS, MODE_TRADES );
      if( OrderMagicNumber() == magic ){
          if(OrderType == OP_SELL){
            sellspercent = OrderProfit();
          }
      }
   }
   return sellspercent;
}

double BUYGAINPERCENTAGE(int magic)
{
    int sellspercent = 0;
     for( int i = 0 ; i < OrdersTotal() ; i++ ) {
      OrderSelect( i, SELECT_BY_POS, MODE_TRADES );
      if( OrderMagicNumber() == magic ){
          if(OrderType == OP_BUY){
            sellspercent = OrderProfit();
          }
      }
   }
   return sellspercent;
}


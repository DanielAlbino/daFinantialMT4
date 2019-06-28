//+------------------------------------------------------------------+
//|                                            PercentagemProfit.mqh |
//|                                    Copyright 2019, Daniel Albino |
//+------------------------------------------------------------------+

#include "parametros.mqh"

int     BuyPercentage, SellPercentage;
double  AcountMoney = AccountBalance();
double sellprofit, buyprofit;

void BUYTRADESPROFITLOSS(){
    buyprofit = BUYGAINPERCENTAGE(MAGICNUMBER);
}

void SELLTRADESPROFITLOSS(){
    sellprofit = SELLGAINPERCENTAGE(MAGICNUMBER);
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
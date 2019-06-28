//+------------------------------------------------------------------+
//|                                                 PartialPrice.mqh |
//|                                    Copyright 2019, Daniel Albino |
//+------------------------------------------------------------------+

#include "parametros.mqh"

int PartialClose(int magicnumber)
{
   datetime temp = 0;
   int lastTicketNumber;
   for(int i=1; i<=OrdersTotal(); i++)
      {
         if ( OrderSelect(i-1,SELECT_BY_POS,MODE_TRADES) == true )
         {   
            if ( OrderOpenTime() > temp && magicnumber == OrderMagicNumber() )  
            {
               temp = OrderOpenTime();
               lastTicketNumber = OrderTicket();
            }
         }
      }
      OrderClose(lastTicketNumber,(OrderLots()/valor_fecho),Bid,0,Pink);
   return(lastTicketNumber);
}

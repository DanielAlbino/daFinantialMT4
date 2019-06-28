//+------------------------------------------------------------------+
//|                                                 PartialPrice.mqh |
//|                                    Copyright 2019, Daniel Albino |
//+------------------------------------------------------------------+

#include "parametros.mqh"

//função que vai buscar a ultima trade aberta
int PartialClose(int magicnumber)
{
   datetime temp = 0;
   int lastTicketNumber;
   
   //vai procurar em todas as trades qual foi a trade que abriu num determiado preço
   for(int i=1; i<=OrdersTotal(); i++)
      {
         if ( OrderSelect(i-1,SELECT_BY_POS,MODE_TRADES) == true )
         {   
            //OrderOpenTime() serve para verificar quando a ordem foi aberta...
            // e verificamos que o preço que esta ordem tem é ao preço que voi guardado na variavel anterior
            if ( OrderOpenTime() > temp && magicnumber == OrderMagicNumber() )  
            {
               temp = OrderOpenTime();
               lastTicketNumber = OrderTicket();
            }
         }
      }
      //fecha a trade com o ticket x 
      OrderClose(lastTicketNumber,(OrderLots()/valor_fecho),Bid,0,Pink);
   return(lastTicketNumber);
}

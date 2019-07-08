//+------------------------------------------------------------------+
//|                                                  PrintScreen.mqh |
//|                                    Copyright 2019, Daniel Albino |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, Daniel Albino"
#property link      ""
#property strict



void PrintText2(string NOMEOBJECTO, string TEXTO,double valor, int x, int y, color COR)
{
   ObjectCreate(NOMEOBJECTO, OBJ_LABEL, 0, 0, 0);
   ObjectSetText(NOMEOBJECTO, TEXTO + DoubleToString(valor), 7,"Arial", COR);
   ObjectSet(NOMEOBJECTO, OBJPROP_CORNER, 0);
   ObjectSet(NOMEOBJECTO, OBJPROP_XDISTANCE, x);
   ObjectSet(NOMEOBJECTO, OBJPROP_YDISTANCE, y);
}

void PrintText2(string NOMEOBJECTO, string TEXTO,string valor, int x, int y, color COR)
{
   ObjectCreate(NOMEOBJECTO, OBJ_LABEL, 0, 0, 0);
   ObjectSetText(NOMEOBJECTO, TEXTO + valor, 7,"Arial", COR);
   ObjectSet(NOMEOBJECTO, OBJPROP_CORNER, 0);
   ObjectSet(NOMEOBJECTO, OBJPROP_XDISTANCE, x);
   ObjectSet(NOMEOBJECTO, OBJPROP_YDISTANCE, y);
}

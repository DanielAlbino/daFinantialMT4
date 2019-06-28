//+------------------------------------------------------------------+
//|                                                    TrendLine.mqh |
//|                                    Copyright 2019, Daniel Albino |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, Daniel Albino"
#property link      ""
#property strict

#include "includes.mqh"

// VERIFICAR COMO FAZER LINHA DE TENDÊNCIA
// LINHA É TRAÇADA EM 3 HIGHER HIGHS
// ENCONTRAR 3 HIGHER HIGHS E LOWER LOWS
// MOSTRAR A LINHA NO ECRÃ

// ------------------------------------------------------------------------------------------------------
// nota: PODERÁ HAVER POSSIBILIDADE DE MOSTRAR O ANGULO DA TENDENCIA USANDO O OBJ_TRENDBYANGLE
// ------------------------------------------------------------------------------------------------------


void HIGHERHIGH(){

}

void LOWERLOW(){

}

// ObjectCreate(chart_ID,name,OBJ_TREND,sub_window,time1,price1,time2,price2)
void TRENDLINE(string NOME, int initTime, double initValue, double closeTime, double closeValue){
    ObjectCreate(0,NOME,OBJ_TREND,0,initTime,initValue,closeTime,closeValue);
    //--- set line color
   ObjectSetInteger(0,NOME,OBJPROP_COLOR,clrGreen);
    //--- set line display style
   ObjectSetInteger(0,NOME,OBJPROP_STYLE,STYLE_SOLID);
    //--- set line width
   ObjectSetInteger(0,NOME,OBJPROP_WIDTH,1);
}

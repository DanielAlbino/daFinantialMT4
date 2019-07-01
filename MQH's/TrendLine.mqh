//+------------------------------------------------------------------+
//|                                                    TrendLine.mqh |
//|                                    Copyright 2019, Daniel Albino |
//+------------------------------------------------------------------+
#property copyright "Copyright 2019, Daniel Albino"
#property link      ""
#property strict

#include "includes.mqh"

// VERIFICAR COMO FAZER LINHA DE TENDÊNCIA
// LINHA É TRAÇADA EM 1 HIGHER HIGH e 2 HIGHER LOW
// ENCONTRAR 3 HIGHER HIGHS E LOWER LOWS
// MOSTRAR A LINHA NO ECRÃ

// ------------------------------------------------------------------------------------------------------
// nota: PODERÁ HAVER POSSIBILIDADE DE MOSTRAR O ANGULO DA TENDENCIA USANDO O OBJ_TRENDBYANGLE
// ------------------------------------------------------------------------------------------------------


// VARIAVEIS ---------------------------

double HH = 0;
double HH2 = 0;

double LL = 9999999;
double LL2 = 9999999;

datetime htime1, htime2;
datetime ltime1, ltime2;

int NBARS = 24;


void HIGHERHIGH(){

    for (int i = 1; i < NBARS; i++){
        if(High[i] > HH){ HH = High[i]; time1 = TimeCurrent();}
        if((High[i] > HH2) && (HH > HH2) && (LL < HH)){ HH2 = High[i]; time2 = TimeCurrent();} 
    }
    if(HH > 0 && HH2 > 0){
      TRENDLINE("hhTrend", htime1, HH, htime2, HH2, clrGreen); 
    }
}

void LOWERLOW(){

    for (int i = 1; i < NBARS; i++){
        if(Low[i] < LL){ LL = Low[i];} 
        if((Low[i] < LL2) && (LL < LL2){ LL2 = Low[i];}  
    }

    if(LL < 999 && LL2 < 999){
      TRENDLINE("hhTrend", ltime1, LL, ltime2, LL2, clrRed); 
    }
}

// ObjectCreate(chart_ID,name,OBJ_TREND,sub_window,time1,price1,time2,price2)
void TRENDLINE(string NOME, int initTime, double initValue, double closeTime, double closeValue, color cor){
    ObjectCreate(0,NOME,OBJ_TREND,0,initTime,initValue,closeTime,closeValue);
    //--- set line color
   ObjectSetInteger(0,NOME,OBJPROP_COLOR,cor);
    //--- set line display style
   ObjectSetInteger(0,NOME,OBJPROP_STYLE,STYLE_SOLID);
    //--- set line width
   ObjectSetInteger(0,NOME,OBJPROP_WIDTH,1);
}

//+------------------------------------------------------------------+
//|                                              zulufx HHLHLLHL.mq4 |
//|                                                 Copyright © 2015 |
//|                                                                  |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2015, zulufx"
#property link      ""

#property indicator_chart_window
#property indicator_buffers 1
#property indicator_color1 Red
//---- indicator parameters
extern int ExtDepth=12;
extern int ExtDeviation=1;
extern int ExtBackstep=1;
extern color LabelColor1 = Gold;
extern color LabelColor2 = Red;
extern int Labeldistance = 2;
//---- indicator buffers
double ZigzagBuffer[];
double HighMapBuffer[];
double LowMapBuffer[];
int level=3; // recounting's depth 
bool downloadhistory=false;

int PipFactor = 1;
//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int init()
  {
   // Cater for fractional pips
   if (Digits == 3 || Digits == 5)
   {
      PipFactor = 10;
   }
   ObjectsDeleteAll(0,OBJ_TEXT);
   IndicatorBuffers(3);
//---- drawing settings
   SetIndexStyle(0,DRAW_SECTION);
//---- indicator buffers mapping
   SetIndexBuffer(0,ZigzagBuffer);
   SetIndexBuffer(1,HighMapBuffer);
   SetIndexBuffer(2,LowMapBuffer);
   SetIndexEmptyValue(0,0.0);

//---- indicator short name
   IndicatorShortName("ZigZag("+ExtDepth+","+ExtDeviation+","+ExtBackstep+")");
//---- initialization done
   return(0);
  }
  
  int deinit()
  {
    ObjectsDeleteAll(0,OBJ_TEXT);
    return(0);
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int start()
  {
   int i, counted_bars = IndicatorCounted();
   int limit,counterZ,whatlookfor;
   int shift,back,lasthighpos,lastlowpos;
   double val,res;
   double curlow,curhigh,lasthigh,lastlow;

   if (counted_bars==0 && downloadhistory) // history was downloaded
     {
      ArrayInitialize(ZigzagBuffer,0.0);
      ArrayInitialize(HighMapBuffer,0.0);
      ArrayInitialize(LowMapBuffer,0.0);
     }
   if (counted_bars==0) 
     {
      limit=Bars-ExtDepth;
      downloadhistory=true;
     }
   if (counted_bars>0) 
     {
      while (counterZ<level && i<100)
        {
         res=ZigzagBuffer[i];
         if (res!=0) counterZ++;
         i++;
        }
      i--;
      limit=i;
      if (LowMapBuffer[i]!=0) 
        {
         curlow=LowMapBuffer[i];
         whatlookfor=1;
        }
      else
        {
         curhigh=HighMapBuffer[i];
         whatlookfor=-1;
        }
      for (i=limit-1;i>=0;i--)  
        {
         ZigzagBuffer[i]=0.0;  
         LowMapBuffer[i]=0.0;
         HighMapBuffer[i]=0.0;
        }
     }
      
   for(shift=limit; shift>=0; shift--)
     {
      val=Low[iLowest(NULL,0,MODE_LOW,ExtDepth,shift)];
      if(val==lastlow) val=0.0;
      else 
        { 
         lastlow=val; 
         if((Low[shift]-val)>(ExtDeviation*Point)) val=0.0;
         else
           {
            for(back=1; back<=ExtBackstep; back++)
              {
               res=LowMapBuffer[shift+back];
               if((res!=0)&&(res>val)) LowMapBuffer[shift+back]=0.0; 
              }
           }
        } 
      if (Low[shift]==val) LowMapBuffer[shift]=val; else LowMapBuffer[shift]=0.0;
      //--- high
      val=High[iHighest(NULL,0,MODE_HIGH,ExtDepth,shift)];
      if(val==lasthigh) val=0.0;
      else 
        {
         lasthigh=val;
         if((val-High[shift])>(ExtDeviation*Point)) val=0.0;
         else
           {
            for(back=1; back<=ExtBackstep; back++)
              {
               res=HighMapBuffer[shift+back];
               if((res!=0)&&(res<val)) HighMapBuffer[shift+back]=0.0; 
              } 
           }
        }
      if (High[shift]==val) HighMapBuffer[shift]=val; else HighMapBuffer[shift]=0.0;
     }

   // final cutting 
   if (whatlookfor==0)
     {
      lastlow=0;
      lasthigh=0;  
     }
   else
     {
      lastlow=curlow;
      lasthigh=curhigh;
     }
   for (shift=limit;shift>=0;shift--)
     {
      res=0.0;
      switch(whatlookfor)
        {
         case 0: // look for peak or lawn 
            if (lastlow==0 && lasthigh==0)
              {
               if (HighMapBuffer[shift]!=0)
                 {
                  lasthigh=High[shift];
                  lasthighpos=shift;
                  whatlookfor=-1;
                  ZigzagBuffer[shift]=lasthigh;
                  DrawHighLabel(shift);
                  res=1;
                 }
               if (LowMapBuffer[shift]!=0)
                 {
                  lastlow=Low[shift];
                  lastlowpos=shift;
                  whatlookfor=1;
                  ZigzagBuffer[shift]=lastlow;
                  DrawLowLabel(shift);
                  res=1;
                 }
              }
             break;  
         case 1: // look for peak
            if (LowMapBuffer[shift]!=0.0 && LowMapBuffer[shift]<lastlow && HighMapBuffer[shift]==0.0)
              {
               ZigzagBuffer[lastlowpos]=0.0;
               RemoveLabel(lastlowpos);
               lastlowpos=shift;
               lastlow=LowMapBuffer[shift];
               ZigzagBuffer[shift]=lastlow;
               DrawLowLabel(shift);
               res=1;
              }
            if (HighMapBuffer[shift]!=0.0 && LowMapBuffer[shift]==0.0)
              {
               lasthigh=HighMapBuffer[shift];
               lasthighpos=shift;
               ZigzagBuffer[shift]=lasthigh;
               DrawHighLabel(shift);
               whatlookfor=-1;
               res=1;
              }   
            break;               
         case -1: // look for lawn
            if (HighMapBuffer[shift]!=0.0 && HighMapBuffer[shift]>lasthigh && LowMapBuffer[shift]==0.0)
              {
               ZigzagBuffer[lasthighpos]=0.0;
               RemoveLabel(lasthighpos);
               lasthighpos=shift;
               lasthigh=HighMapBuffer[shift];
               ZigzagBuffer[shift]=lasthigh;
               DrawHighLabel(shift);
               res=1;
              }
            if (LowMapBuffer[shift]!=0.0 && HighMapBuffer[shift]==0.0)
              {
               lastlow=LowMapBuffer[shift];
               lastlowpos=shift;
               ZigzagBuffer[shift]=lastlow;
               DrawLowLabel(shift);
               whatlookfor=1;
               res=1;
              }   
            break;               
         default: return(0); 
        }
     }

   return(0);
  }
  
void DrawHighLabel(int shift)
{
   string status = "";
   
   double currentHigh = HighMapBuffer[shift];
   double previousHigh;
   // find the previous high
   for (int i=shift; i<shift+1000; i++)
   {
      if (HighMapBuffer[i] != 0 && ZigzagBuffer[i] != 0)
      {
         previousHigh = HighMapBuffer[i];
         break;
      }
   }
   if (currentHigh > previousHigh)
   {
      status = "HH  ";
  
   
   }
   else
   {
      status = "LH  ";
   }
   double position = HighMapBuffer[shift] + (Labeldistance * Point * PipFactor);
   ObjectCreate( "statusLabel"+Time[shift], OBJ_TEXT, 0, Time[shift], position);
   ObjectSetText("statusLabel"+Time[shift], status, 10, "Arial", LabelColor1);
}

void DrawLowLabel(int shift)
{
    
   string status = "";
   double currentLow = LowMapBuffer[shift];
   double previousLow;
   // find the previous Low
   for (int i=shift; i<shift+1000; i++)
   {
      if (LowMapBuffer[i] != 0 && ZigzagBuffer[i] != 0)
      {
         previousLow = LowMapBuffer[i];
         break;
      }
   }
   if (currentLow > previousLow)
   {
      status = "HL  " ;
   
   
   }
   else
   {
      status = "LL  ";
   }
   double position = LowMapBuffer[shift] - (Labeldistance/2 * Point * PipFactor);
   ObjectCreate( "statusLabel"+Time[shift], OBJ_TEXT, 0, Time[shift], position);
   ObjectSetText("statusLabel"+Time[shift], status, 10, "Arial", LabelColor2);
   
}


void RemoveLabel(int shift)
{
   ObjectDelete("statusLabel"+Time[shift]);
}
//+------------------------------------------------------------------+
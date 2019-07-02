// rectangulo é criado nas primeiras 7 velas
// range é entre a vela mais baixa e a mais alta (hihg e low)
// quando preço passa para baixo ou para cima uma vela indica trade
// linhas horizontais a 24 velas
// para entrada de ordem verificar sempre a 15minutos - se abrir candle fora da zona abre ordem


/*
    inicia nas 17h e termina a 1h da manhã (9horas)
*/
const long            chart_ID=0;       // chart's ID
const string          name="Rectangle";  // rectangle name
const int             sub_window=0;      // subwindow index 
datetime              time1=17;           // first point time
double                price1=0;          // first point price
datetime              time2=1;           // second point time
double                price2=0;          // second point price

int TIMEFRAME = 60;
int candlesrange = 24;
int range      = 9;
double HigherHigh = 0;
double LowerLow = 999;
bool rectangle = false;


void HigherandLow(){
   if(Hour() == 17 && TIMEFRAME = 60 && rectangle == false){
     HigherHigh =  High[iHighest(Symbol(),TIMEFRAME,MODE_HIGH,0,range)];
     LowerLow =  Low[iLowest(Symbol(),TIMEFRAME,MODE_LOW,0,range)];
     createRetangle(0,"rectangle",0,time1,HigherHigh,time2,LowerLow,clrGreen);
     rectangle = true;
   } 

   if(Hour() > 7) {
         rectangle = false;
   }
   
}

void createRetangle(  long           chart_ID,       // chart's ID
                     string          name,            // rectangle name
                     int             sub_window,      // subwindow index 
                     datetime        time1,           // first point time
                     double          price1,          // first point price
                     datetime        time2,           // second point time
                     double          price2,          // second point price
                     color           clr              // rectangle color
                     ){
                           
//------------------------------------------------------------------------------------------

   ObjectCreate(chart_ID,name,OBJ_RECTANGLE,sub_window,time1,price1,time2,price2);
//--- set rectangle color
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
//--- set the style of rectangle lines
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,STYLE_SOLID);
//--- set width of the rectangle lines
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,1);
//--- enable (true) or disable (false) the mode of filling the rectangle
   ObjectSetInteger(chart_ID,name,OBJPROP_FILL,true);
//--- display in the foreground (false) or background (true)
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,true);
//--- successful execution
}

void HorizontalLines(
      long            chart_ID,        // chart's ID
      string          name,      // line name
      int             sub_window,      // subwindow index
      double          price=0,           // line price
      color           clr=clrRed,        // line color
      ENUM_LINE_STYLE style=STYLE_SOLID, // line style
      int             width=1,           // line width
      bool            back=false,        // in the background
      bool            selection=true,    // highlight to move
      bool            hidden=true,       // hidden in the object list
      long            z_order=0         // priority for mouse click */

){

//--------------------------------------------------------------------------------------

    ObjectCreate(chart_ID,name,OBJ_HLINE,sub_window,0,price);
//--- set line color
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
//--- set line display style
   ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style);
//--- set line width
   ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,width);
//--- display in the foreground (false) or background (true)
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
//--- enable (true) or disable (false) the mode of moving the line by mouse
//--- when creating a graphical object using ObjectCreate function, the object cannot be
//--- highlighted and moved by default. Inside this method, selection parameter
//--- is true by default making it possible to highlight and move the object
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
//--- hide (true) or display (false) graphical object name in the object list
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
//--- set the priority for receiving the event of a mouse click in the chart
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
}
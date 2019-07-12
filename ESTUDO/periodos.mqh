 switch (Period()) {
      case 1:
         period = "M1";
         break;
      case 5:
         period = "M5";
         break;
      case 15:
         period = "M15";
         break;
      case 30:
         period = "M30";
         break;      
      case 60:
         period = "H1";
         break;
      case 240:
         period = "H4";
         break;
      case 1440:
         period = "D1";
         break;
      case 10080:
         period = "W1";
         break;
      case 43200:
         period = "MN";
         break;
   }
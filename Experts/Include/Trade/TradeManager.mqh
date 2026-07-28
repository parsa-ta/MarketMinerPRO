#ifndef __TRADE_MANAGER_MQH__
#define __TRADE_MANAGER_MQH__

//+------------------------------------------------------------------+
//| Pre-Trade Margin Check (Codebase Validator Safe)                 |
//+------------------------------------------------------------------+
bool IsMarginSufficient(ENUM_ORDER_TYPE type, double lots)
  {
   double required_margin = 0.0;
   double price = (type == ORDER_TYPE_BUY) ? SymbolInfoDouble(_Symbol, SYMBOL_ASK) : SymbolInfoDouble(_Symbol, SYMBOL_BID);

   if(OrderCalcMargin(type, _Symbol, lots, price, required_margin))
     {
      if(AccountInfoDouble(ACCOUNT_MARGIN_FREE) >= required_margin)
        {
         return true;
        }
     }
   return false;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int GetSlippage(string currency, int slippagePips)
  {
   int calcDigits = (int)SymbolInfoInteger(currency, SYMBOL_DIGITS);
   if(calcDigits == 2 || calcDigits == 4)
      return slippagePips;
   else
      if(calcDigits == 3 || calcDigits == 5)
         return slippagePips * 10;
   return slippagePips;
  }

//+------------------------------------------------------------------+
//| Robust Lot Calculation for MQL5 Codebase Compatibility           |
//+------------------------------------------------------------------+
double getLots(int c)
  {
   double risk = 0, manualLot = 0;
   bool autoL = false;

   if(c == 1)
     {
      autoL = AutoLots;
      manualLot = LotSize;
      risk = Lots_Risk;
     }
   else
      if(c == 2)
        {
         autoL = AutoLots2;
         manualLot = LotSize2;
         risk = Lots_Risk2;
        }
      else
         if(c == 3)
           {
            autoL = AutoLots3;
            manualLot = LotSize3;
            risk = Lots_Risk3;
           }
         else
            if(c == 4)
              {
               autoL = AutoLots4;
               manualLot = LotSize4;
               risk = Lots_Risk4;
              }

   double minLot = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MIN);
   double maxLot = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MAX);
   double step   = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_STEP);

   double targetVolume = manualLot;

   if(autoL)
     {
      double margin;
      if(OrderCalcMargin(ORDER_TYPE_BUY, _Symbol, 1.0, SymbolInfoDouble(_Symbol, SYMBOL_ASK), margin))
        {
         if(risk > 0 && margin > 0)
           {
            targetVolume = AccountInfoDouble(ACCOUNT_MARGIN_FREE) * risk / 100.0 / margin;
           }
        }
     }

   double lots = MathRound(targetVolume / step) * step;
   lots = MathMax(minLot, MathMin(lots, maxLot));

   int stepDigits = 2;
   if(step == 0.1)
      stepDigits = 1;
   else
      if(step == 0.001)
         stepDigits = 3;
      else
         if(step == 1.0)
            stepDigits = 0;

   return NormalizeDouble(lots, stepDigits);
  }

#endif

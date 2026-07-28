#ifndef __POSITION_MANAGER_MQH__
#define __POSITION_MANAGER_MQH__

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double MyAccountProfit_Buy(ulong MagicNumber)
  {
   double profit = 0;
   for(int i = PositionsTotal() - 1; i >= 0; i--)
     {
      if(m_position.SelectByIndex(i))
        {
         if(m_position.Magic() == MagicNumber && m_position.PositionType() == POSITION_TYPE_BUY)
           {
            profit += m_position.Profit() + m_position.Swap();
           }
        }
     }
   return profit;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double MyAccountProfit_Sell(ulong MagicNumber)
  {
   double profit = 0;
   for(int i = PositionsTotal() - 1; i >= 0; i--)
     {
      if(m_position.SelectByIndex(i))
        {
         if(m_position.Magic() == MagicNumber && m_position.PositionType() == POSITION_TYPE_SELL)
           {
            profit += m_position.Profit() + m_position.Swap();
           }
        }
     }
   return profit;
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void ClosePositions(ulong magic, ENUM_POSITION_TYPE type)
  {
   for(int i = PositionsTotal() - 1; i >= 0; i--)
     {
      if(m_position.SelectByIndex(i))
        {
         if(m_position.Magic() == magic && m_position.PositionType() == type)
           {
            trade.PositionClose(m_position.Ticket());
           }
        }
     }
  }

#endif

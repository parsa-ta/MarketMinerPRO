#ifndef __INITIALIZATION_MANAGER_MQH__
#define __INITIALIZATION_MANAGER_MQH__

int InitializeExpert()
  {
   if(!m_symbol.Name(_Symbol))
      return(INIT_FAILED);
   m_symbol.Refresh();
   trade.SetExpertMagicNumber(0);

   UsePoint = m_symbol.Point();
   UseSlippage = GetSlippage(_Symbol, (int)Slippage);

   InitializeIndicators();

   return(INIT_SUCCEEDED);
  }

#endif

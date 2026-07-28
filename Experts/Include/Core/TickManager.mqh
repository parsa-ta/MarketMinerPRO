#ifndef __TICK_MANAGER_MQH__
#define __TICK_MANAGER_MQH__

double Ask;
double Bid;
double Open[];
double Close[];

void ProcessTicks()
  {
   m_symbol.RefreshRates();
   Ask = m_symbol.Ask();
   Bid = m_symbol.Bid();

   ArraySetAsSeries(Open, true);
   ArraySetAsSeries(Close, true);

   if(CopyOpen(_Symbol, PERIOD_CURRENT, 0, 2, Open) < 2)
      return;
   if(CopyClose(_Symbol, PERIOD_CURRENT, 0, 2, Close) < 2)
      return;

   if(cycle1)
      ProcessCycle1();
   if(cycle2)
      ProcessCycle2();
   if(cycle3)
      ProcessCycle3();
   if(cycle4)
      ProcessCycle4();
  }

#endif

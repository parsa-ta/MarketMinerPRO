#ifndef __INDICATOR_MANAGER_MQH__
#define __INDICATOR_MANAGER_MQH__

void InitializeIndicators()
{
   h_ma1 = INVALID_HANDLE;
   h_ma2 = INVALID_HANDLE;
   h_ma3 = INVALID_HANDLE;
   h_rsi = INVALID_HANDLE;
   h_wpr = INVALID_HANDLE;
   h_env2 = INVALID_HANDLE;
   h_env3 = INVALID_HANDLE;
   h_env4 = INVALID_HANDLE;

   if(cycle1)
     {
      if(MA1_Enable)
        {
         h_ma1 = iMA(_Symbol, MA_TimeFrame, MAPeriod, MA_shift, MA_method, MA_appliedprice);
         if(h_ma1 == INVALID_HANDLE)
            Print("Failed to create MA1 indicator handle");
        }
      if(MA2_Enable)
        {
         h_ma2 = iMA(_Symbol, MA2_TimeFrame, MA2Period, MA2_shift, MA2_method, MA2_appliedprice);
         if(h_ma2 == INVALID_HANDLE)
            Print("Failed to create MA2 indicator handle");
        }
      if(MA3_Enable)
        {
         h_ma3 = iMA(_Symbol, MA3_TimeFrame, MA3Period, MA3_shift, MA3_method, MA3_appliedprice);
         if(h_ma3 == INVALID_HANDLE)
            Print("Failed to create MA3 indicator handle");
        }
      if(RSI_Enable)
        {
         h_rsi = iRSI(_Symbol, RSI_TF, RSI_Period, RSI_Price);
         if(h_rsi == INVALID_HANDLE)
            Print("Failed to create RSI indicator handle");
        }
      if(WPR_Enable)
        {
         h_wpr = iWPR(_Symbol, WPR_TF, WPR_Period);
         if(h_wpr == INVALID_HANDLE)
            Print("Failed to create WPR indicator handle");
        }
     }

   if(cycle2)
     {
      h_env2 = iEnvelopes(_Symbol, TimeFrame2, InpMAPeriod2, InpMAShift2, InpMAMethod2, InpAppliedPrice2, c2_InpDeviation);
      if(h_env2 == INVALID_HANDLE)
         Print("Failed to create Cycle2 Envelopes indicator handle");
     }
   if(cycle3)
     {
      h_env3 = iEnvelopes(_Symbol, TimeFrame3, InpMAPeriod3, InpMAShift3, InpMAMethod3, InpAppliedPrice3, c3_InpDeviation);
      if(h_env3 == INVALID_HANDLE)
         Print("Failed to create Cycle3 Envelopes indicator handle");
     }
   if(cycle4)
     {
      h_env4 = iEnvelopes(_Symbol, TimeFrame4, InpMAPeriod4, InpMAShift4, InpMAMethod4, InpAppliedPrice4, c4_InpDeviation);
      if(h_env4 == INVALID_HANDLE)
         Print("Failed to create Cycle4 Envelopes indicator handle");
     }
}

void ReleaseIndicators()
{
   if(h_ma1 != INVALID_HANDLE)
     {
      IndicatorRelease(h_ma1);
      h_ma1 = INVALID_HANDLE;
     }
   if(h_ma2 != INVALID_HANDLE)
     {
      IndicatorRelease(h_ma2);
      h_ma2 = INVALID_HANDLE;
     }
   if(h_ma3 != INVALID_HANDLE)
     {
      IndicatorRelease(h_ma3);
      h_ma3 = INVALID_HANDLE;
     }
   if(h_rsi != INVALID_HANDLE)
     {
      IndicatorRelease(h_rsi);
      h_rsi = INVALID_HANDLE;
     }
   if(h_wpr != INVALID_HANDLE)
     {
      IndicatorRelease(h_wpr);
      h_wpr = INVALID_HANDLE;
     }
   if(h_env2 != INVALID_HANDLE)
     {
      IndicatorRelease(h_env2);
      h_env2 = INVALID_HANDLE;
     }
   if(h_env3 != INVALID_HANDLE)
     {
      IndicatorRelease(h_env3);
      h_env3 = INVALID_HANDLE;
     }
   if(h_env4 != INVALID_HANDLE)
     {
      IndicatorRelease(h_env4);
      h_env4 = INVALID_HANDLE;
     }
}

#endif

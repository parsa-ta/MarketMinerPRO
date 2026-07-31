#property strict

input bool cycle1 = true;
input bool cycle2 = false;
input bool cycle3 = false;
input bool cycle4 = false;

input string C1 = "--- Cycle1 Settings -------------- ";
input int MAPeriod = 3;
input int MA_shift = 0;
input ENUM_MA_METHOD MA_method = MODE_EMA;
input ENUM_APPLIED_PRICE MA_appliedprice = PRICE_HIGH;
input bool MA1_Enable = false;
input ENUM_TIMEFRAMES MA_TimeFrame = PERIOD_CURRENT;

input int MA2Period = 20;
input int MA2_shift = 0;
input ENUM_MA_METHOD MA2_method = MODE_EMA;
input ENUM_APPLIED_PRICE MA2_appliedprice = PRICE_LOW;
input bool MA2_Enable = false;
input ENUM_TIMEFRAMES MA2_TimeFrame = PERIOD_CURRENT;

input int MA3Period = 50;
input int MA3_shift = 0;
input ENUM_MA_METHOD MA3_method = MODE_EMA;
input ENUM_APPLIED_PRICE MA3_appliedprice = PRICE_MEDIAN;
input ENUM_TIMEFRAMES MA3_TimeFrame = PERIOD_CURRENT;
input bool MA3_Enable = false;

input int RSI_Period = 200;
input ENUM_APPLIED_PRICE RSI_Price = PRICE_CLOSE;
input ENUM_TIMEFRAMES RSI_TF = PERIOD_CURRENT;
input int RSI_Buy_Level = 30;
input int RSI_Sell_Level = 70;
input bool RSI_Enable = false;

input int WPR_Period = 200;
input ENUM_TIMEFRAMES WPR_TF = PERIOD_CURRENT;
input int WPR_Buy_Level = -80;
input int WPR_Sell_Level = -20;
input bool WPR_Enable = true;

input double LotSize = 0.01;
input bool AutoLots = false;
input double Lots_Risk = 3;
input double Account_Risk_percent = 99;
input double target_percent = 1.0;
input double target_amount  = 0;

input bool Reverse_Signals = false;
input ulong c1_MagicNumber = 111;

input string C2 = "--- Cycle2 Settings --------------";
input int InpMAPeriod2 = 25;
input int InpMAShift2 = 0;
input ENUM_MA_METHOD InpMAMethod2 = MODE_EMA;
input ENUM_APPLIED_PRICE InpAppliedPrice2 = PRICE_CLOSE;
input double c2_InpDeviation = 0.3;
input double LotSize2 = 0.01;
input bool AutoLots2 = false;
input double Lots_Risk2 = 3;
input double Account_Risk_percent2 = 99;
input double target_percent2 = 1.0;
input double target_amount2  = 0;
input ENUM_TIMEFRAMES TimeFrame2 = PERIOD_CURRENT;
input bool Reverse_Signals2 = false;
input ulong c2_MagicNumber = 333;

input string C3 = "--- Cycle3 Settings --------------";
input int InpMAPeriod3 = 25;
input int InpMAShift3 = 0;
input ENUM_MA_METHOD InpMAMethod3 = MODE_EMA;
input ENUM_APPLIED_PRICE InpAppliedPrice3 = PRICE_CLOSE;
input double c3_InpDeviation = 0.7;
input double LotSize3 = 1.0;
input bool AutoLots3 = false;
input double Lots_Risk3 = 3;
input double Account_Risk_percent3 = 99;
input double target_percent3 = 0.0;
input double target_amount3  = 350;
input ENUM_TIMEFRAMES TimeFrame3 = PERIOD_CURRENT;
input bool Reverse_Signals3 = false;
input ulong c3_MagicNumber = 555;

input string C4 = "--- Cycle4 Settings --------------";
input int InpMAPeriod4 = 99;
input int InpMAShift4 = 0;
input ENUM_MA_METHOD InpMAMethod4 = MODE_EMA;
input ENUM_APPLIED_PRICE InpAppliedPrice4 = PRICE_CLOSE;
input double c4_InpDeviation = 0.7;
input int Distance = 10;
input double LotSize4 = 1.0;
input bool AutoLots4 = false;
input double Lots_Risk4 = 3;
input double Account_Risk_percent4 = 99;
input double target_percent4 = 0.0;
input double target_amount4  = 350;
input ENUM_TIMEFRAMES TimeFrame4 = PERIOD_CURRENT;
input bool Reverse_Signals4 = false;
input ulong c4_MagicNumber = 777;

input string s111 = "--- Basic Settings -------------- ";
input ulong Slippage = 5;


#include <Core/Globals.mqh>
#include <Indicators/IndicatorManager.mqh>
#include <Trade/PositionManager.mqh>
#include <Trade/TradeManager.mqh>
#include <Core/InitializationManager.mqh>
#include <Cycles/Cycle1.mqh>
#include <Cycles/Cycle2.mqh>
#include <Cycles/Cycle3.mqh>
#include <Cycles/Cycle4.mqh>

int OnInit()
{
   return InitializeExpert();
}

void OnDeinit(const int reason)
{
   ReleaseIndicators();
}

void OnDeinit(const int reason)
{
   ReleaseIndicators();
}

void OnDeinit(const int reason)
{
   ReleaseIndicators();
}

void OnTick()
{
   ProcessTicks();
}

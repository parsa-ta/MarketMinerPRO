#ifndef __GLOBALS_MQH__
#define __GLOBALS_MQH__

#include <Core/CycleState.mqh>

#include <Trade\Trade.mqh>
#include <Trade\PositionInfo.mqh>
#include <Trade\SymbolInfo.mqh>

CTrade         trade;
CPositionInfo  m_position;
CSymbolInfo    m_symbol;

// Global Variables and Handles
double UsePoint;
ulong UseSlippage;

int h_ma1, h_ma2, h_ma3, h_rsi, h_wpr;
int h_env2, h_env3, h_env4;

// Cycle Settings Trackers
double c1_account_equity_buy, c1_targetprice_buy, c1_riskprice_buy;
double c1_account_equity_sell, c1_targetprice_sell, c1_riskprice_sell;
bool c1_Buycycle=true, c1_sellcycle=true, c1_check_for_buy_close=false, c1_check_for_sell_close=false;
double c1_open_price;
bool c1_place_order=false;
int c1_Buycount=0, c1_Sellcount=0;

double c2_account_equity_buy, c2_targetprice_buy, c2_riskprice_buy;
double c2_account_equity_sell, c2_targetprice_sell, c2_riskprice_sell;
bool c2_Buycycle=true, c2_sellcycle=true, c2_check_for_buy_close=false, c2_check_for_sell_close=false;
double c2_open_price;
bool c2_place_order=false;
int c2_Buycount=0, c2_Sellcount=0;

double c3_account_equity_buy, c3_targetprice_buy, c3_riskprice_buy;
double c3_account_equity_sell, c3_targetprice_sell, c3_riskprice_sell;
bool c3_Buycycle=true, c3_sellcycle=true, c3_check_for_buy_close=false, c3_check_for_sell_close=false;
double c3_open_price;
bool c3_place_order=false;
int c3_Buycount=0, c3_Sellcount=0;

double c4_account_equity_buy, c4_targetprice_buy, c4_riskprice_buy;
double c4_account_equity_sell, c4_targetprice_sell, c4_riskprice_sell;
bool c4_Buycycle=true, c4_sellcycle=true, c4_check_for_buy_close=false, c4_check_for_sell_close=false;
double c4_open_price;
bool c4_place_order=false;
int c4_Buycount=0, c4_Sellcount=0;


#endif

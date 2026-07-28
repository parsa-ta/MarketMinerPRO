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



#endif

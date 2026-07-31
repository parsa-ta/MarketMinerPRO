#ifndef __CYCLE2_MQH__
#define __CYCLE2_MQH__

void ProcessCycle2()
{
//--- CYCLE 2
   if(cycle2)
     {
      double up_env2[1], dn_env2[1];
      CopyBuffer(h_env2, UPPER_LINE, 0, 1, up_env2);
      CopyBuffer(h_env2, LOWER_LINE, 0, 1, dn_env2);

      int c2_signal = 0;
      if(Close[1] > up_env2[0] && Open[0] > up_env2[0])
         c2_signal = 1;
      else
         if(Close[1] < dn_env2[0] && Open[0] < dn_env2[0])
            c2_signal = 2;

      if(Reverse_Signals2 && c2_signal != 0)
         c2_signal = (c2_signal == 1) ? 2 : 1;

      if(c2_signal == 1 && C2.Buycycle)
        {
         C2.check_for_sell_close = false;
         if(Open[0] != C2.open_price)
           {
            C2.open_price = Open[0];
            C2.place_order = true;
           }
         else
            C2.place_order = false;

         if(C2.Buycount == 0)
           {
            C2.account_equity_buy = AccountInfoDouble(ACCOUNT_EQUITY);
C2.targetprice_buy = target_amount2 != 0
                     ? (C2.account_equity_buy + target_amount2)
                     : (C2.account_equity_buy + ((C2.account_equity_buy * target_percent2) / 100));

C2.riskprice_buy = C2.account_equity_buy -
                   ((C2.account_equity_buy * Account_Risk_percent2) / 100);
           }

         if(C2.place_order)
           {
            double c2_lot = getLots(2);
            if(IsMarginSufficient(ORDER_TYPE_BUY, c2_lot))
              {
               trade.SetExpertMagicNumber(c2_MagicNumber);
               trade.SetDeviationInPoints(UseSlippage);
               if(trade.Buy(c2_lot, _Symbol, Ask))
                 {
                  C2.Sellcycle = true;
               C2.check_for_buy_close = true;
                  C2.Buycount++;
                 }
              }
           }
        }
      else
         if(c2_signal == 2 && C2.Sellcycle)
           {
            C2.check_for_buy_close = false;
            if(Open[0] != C2.open_price)
              {
               C2.open_price = Open[0];
               C2.place_order = true;
              }
            else
               C2.place_order = false;

            if(C2.Sellcount == 0)
              {
               C2.account_equity_sell = AccountInfoDouble(ACCOUNT_EQUITY);
               C2.targetprice_sell = target_amount2 != 0 ? (C2.account_equity_sell + target_amount2) : (C2.account_equity_sell + ((C2.account_equity_sell * target_percent2) / 100));
               C2.riskprice_sell = (C2.account_equity_sell - ((C2.account_equity_sell * Account_Risk_percent2) / 100));
              }

            if(C2.place_order)
              {
               double c2_lot = getLots(2);
               if(IsMarginSufficient(ORDER_TYPE_SELL, c2_lot))
                 {
                  trade.SetExpertMagicNumber(c2_MagicNumber);
                  trade.SetDeviationInPoints(UseSlippage);
                  if(trade.Sell(c2_lot, _Symbol, Bid))
                    {
                     C2.Buycycle = true;
                     C2.check_for_sell_close = true;
                     C2.Sellcount++;
                    }
                 }
              }
           }

      double c2_profit_Buy =  C2.account_equity_buy + MyAccountProfit_Buy(c2_MagicNumber);
      double c2_profit_Sell = C2.account_equity_sell + MyAccountProfit_Sell(c2_MagicNumber);

      if((c2_profit_Sell >= C2.targetprice_sell || c2_profit_Sell <= C2.riskprice_sell))
        {
         ClosePositions(c2_MagicNumber, POSITION_TYPE_SELL);
         if(C2.check_for_sell_close)
            C2.Sellcycle = false;
         C2.Sellcount = 0;
        }
      if((c2_profit_Buy >= C2.targetprice_buy ||   c2_profit_Buy <= C2.riskprice_buy))
        {
         ClosePositions(c2_MagicNumber, POSITION_TYPE_BUY);
         if(C2.check_for_buy_close)
            C2.Buycycle = false;
         C2.Buycount = 0;
        }
     }

}

#endif

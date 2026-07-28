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

      if(c2_signal == 1 && c2_Buycycle)
        {
         c2_check_for_sell_close = false;
         if(Open[0] != c2_open_price)
           {
            c2_open_price = Open[0];
            c2_place_order = true;
           }
         else
            c2_place_order = false;

         if(c2_Buycount == 0)
           {
            c2_account_equity_buy = AccountInfoDouble(ACCOUNT_EQUITY);
            c2_targetprice_buy = target_amount2 != 0 ? (c2_account_equity_buy + target_amount2) : (c2_account_equity_buy + ((c2_account_equity_buy * target_percent2) / 100));
            c2_riskprice_buy = (c2_account_equity_buy - ((c2_account_equity_buy * Account_Risk_percent2) / 100));
           }

         if(c2_place_order)
           {
            double c2_lot = getLots(2);
            if(IsMarginSufficient(ORDER_TYPE_BUY, c2_lot))
              {
               trade.SetExpertMagicNumber(c2_MagicNumber);
               trade.SetDeviationInPoints(UseSlippage);
               if(trade.Buy(c2_lot, _Symbol, Ask))
                 {
                  c2_sellcycle = true;
                  c2_check_for_buy_close = true;
                  c2_Buycount++;
                 }
              }
           }
        }
      else
         if(c2_signal == 2 && c2_sellcycle)
           {
            c2_check_for_buy_close = false;
            if(Open[0] != c2_open_price)
              {
               c2_open_price = Open[0];
               c2_place_order = true;
              }
            else
               c2_place_order = false;

            if(c2_Sellcount == 0)
              {
               c2_account_equity_sell = AccountInfoDouble(ACCOUNT_EQUITY);
               c2_targetprice_sell = target_amount2 != 0 ? (c2_account_equity_sell + target_amount2) : (c2_account_equity_sell + ((c2_account_equity_sell * target_percent2) / 100));
               c2_riskprice_sell = (c2_account_equity_sell - ((c2_account_equity_sell * Account_Risk_percent2) / 100));
              }

            if(c2_place_order)
              {
               double c2_lot = getLots(2);
               if(IsMarginSufficient(ORDER_TYPE_SELL, c2_lot))
                 {
                  trade.SetExpertMagicNumber(c2_MagicNumber);
                  trade.SetDeviationInPoints(UseSlippage);
                  if(trade.Sell(c2_lot, _Symbol, Bid))
                    {
                     c2_Buycycle = true;
                     c2_check_for_sell_close = true;
                     c2_Sellcount++;
                    }
                 }
              }
           }

      double c2_profit_Buy = c2_account_equity_buy + MyAccountProfit_Buy(c2_MagicNumber);
      double c2_profit_Sell = c2_account_equity_sell + MyAccountProfit_Sell(c2_MagicNumber);

      if((c2_profit_Sell >= c2_targetprice_sell || c2_profit_Sell <= c2_riskprice_sell))
        {
         ClosePositions(c2_MagicNumber, POSITION_TYPE_SELL);
         if(c2_check_for_sell_close)
            c2_sellcycle = false;
         c2_Sellcount = 0;
        }
      if((c2_profit_Buy >= c2_targetprice_buy || c2_profit_Buy <= c2_riskprice_buy))
        {
         ClosePositions(c2_MagicNumber, POSITION_TYPE_BUY);
         if(c2_check_for_buy_close)
            c2_Buycycle = false;
         c2_Buycount = 0;
        }
     }

}

#endif

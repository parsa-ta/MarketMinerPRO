#ifndef __CYCLE3_MQH__
#define __CYCLE3_MQH__

void ProcessCycle3()
{
//--- CYCLE 3
   if(cycle3)
     {
      double up_env3[1], dn_env3[1];
      CopyBuffer(h_env3, UPPER_LINE, 0, 1, up_env3);
      CopyBuffer(h_env3, LOWER_LINE, 0, 1, dn_env3);

      int c3_signal = 0;
      if(Close[1] > up_env3[0] && Open[0] > up_env3[0])
         c3_signal = 2;
      else
         if(Close[1] < dn_env3[0] && Open[0] < dn_env3[0])
            c3_signal = 1;

      if(Reverse_Signals3 && c3_signal != 0)
         c3_signal = (c3_signal == 1) ? 2 : 1;

      if(c3_signal == 1 && c3_Buycycle)
        {
         c3_check_for_sell_close = false;
         if(Open[0] != c3_open_price)
           {
            c3_open_price = Open[0];
            c3_place_order = true;
           }
         else
            c3_place_order = false;

         if(c3_Buycount == 0)
           {
            c3_account_equity_buy = AccountInfoDouble(ACCOUNT_EQUITY);
            c3_targetprice_buy = target_amount3 != 0 ? (c3_account_equity_buy + target_amount3) : (c3_account_equity_buy + ((c3_account_equity_buy * target_percent3) / 100));
            c3_riskprice_buy = (c3_account_equity_buy - ((c3_account_equity_buy * Account_Risk_percent3) / 100));
           }

         if(c3_place_order)
           {
            double c3_lot = getLots(3);
            if(IsMarginSufficient(ORDER_TYPE_BUY, c3_lot))
              {
               trade.SetExpertMagicNumber(c3_MagicNumber);
               trade.SetDeviationInPoints(UseSlippage);
               if(trade.Buy(c3_lot, _Symbol, Ask))
                 {
                  c3_sellcycle = true;
                  c3_check_for_buy_close = true;
                  c3_Buycount++;
                 }
              }
           }
        }
      else
         if(c3_signal == 2 && c3_sellcycle)
           {
            c3_check_for_buy_close = false;
            if(Open[0] != c3_open_price)
              {
               c3_open_price = Open[0];
               c3_place_order = true;
              }
            else
               c3_place_order = false;

            if(c3_Sellcount == 0)
              {
               c3_account_equity_sell = AccountInfoDouble(ACCOUNT_EQUITY);
               c3_targetprice_sell = target_amount3 != 0 ? (c3_account_equity_sell + target_amount3) : (c3_account_equity_sell + ((c3_account_equity_sell * target_percent3) / 100));
               c3_riskprice_sell = (c3_account_equity_sell - ((c3_account_equity_sell * Account_Risk_percent3) / 100));
              }

            if(c3_place_order)
              {
               double c3_lot = getLots(3);
               if(IsMarginSufficient(ORDER_TYPE_SELL, c3_lot))
                 {
                  trade.SetExpertMagicNumber(c3_MagicNumber);
                  trade.SetDeviationInPoints(UseSlippage);
                  if(trade.Sell(c3_lot, _Symbol, Bid))
                    {
                     c3_Buycycle = true;
                     c3_check_for_sell_close = true;
                     c3_Sellcount++;
                    }
                 }
              }
           }

      double c3_profit_Buy = c3_account_equity_buy + MyAccountProfit_Buy(c3_MagicNumber);
      double c3_profit_Sell = c3_account_equity_sell + MyAccountProfit_Sell(c3_MagicNumber);

      if((c3_profit_Sell >= c3_targetprice_sell || c3_profit_Sell <= c3_riskprice_sell))
        {
         ClosePositions(c3_MagicNumber, POSITION_TYPE_SELL);
         if(c3_check_for_sell_close)
            c3_sellcycle = false;
         c3_Sellcount = 0;
        }
      if((c3_profit_Buy >= c3_targetprice_buy || c3_profit_Buy <= c3_riskprice_buy))
        {
         ClosePositions(c3_MagicNumber, POSITION_TYPE_BUY);
         if(c3_check_for_buy_close)
            c3_Buycycle = false;
         c3_Buycount = 0;
        }
     }

}

#endif

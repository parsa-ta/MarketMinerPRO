void ProcessCycle1()
{
//--- CYCLE 1
   if(cycle1)
     {
      double ma1_arr[1], ma2_arr[1], ma3_arr[1], rsi_arr[1], wpr_arr[1];
      double MA = 0, MA2 = 0, MA3 = 0, rsi = 0, wpr = 0;

      if(MA1_Enable && CopyBuffer(h_ma1, 0, 0, 1, ma1_arr) > 0)
         MA = ma1_arr[0];
      if(MA2_Enable && CopyBuffer(h_ma2, 0, 0, 1, ma2_arr) > 0)
         MA2 = ma2_arr[0];
      if(MA3_Enable && CopyBuffer(h_ma3, 0, 0, 1, ma3_arr) > 0)
         MA3 = ma3_arr[0];
      if(RSI_Enable && CopyBuffer(h_rsi, 0, 0, 1, rsi_arr) > 0)
         rsi = rsi_arr[0];
      if(WPR_Enable && CopyBuffer(h_wpr, 0, 0, 1, wpr_arr) > 0)
         wpr = wpr_arr[0];

      int c1_signal = 0;

      if(MA1_Enable)
        {
         if(Close[1] > MA && Open[0] > MA)
            c1_signal = (c1_signal == 0) ? 1 : 0;
         if(Close[1] < MA && Open[0] < MA)
            c1_signal = (c1_signal == 0) ? 2 : 0;
        }
      if(MA2_Enable)
        {
         if(Close[1] > MA2 && Open[0] > MA2)
            c1_signal = (c1_signal == 0) ? 1 : 0;
         if(Close[1] < MA2 && Open[0] < MA2)
            c1_signal = (c1_signal == 0) ? 2 : 0;
        }
      if(MA3_Enable)
        {
         if(Close[1] > MA3 && Open[0] > MA3)
            c1_signal = (c1_signal == 0) ? 1 : 0;
         if(Close[1] < MA3 && Open[0] < MA3)
            c1_signal = (c1_signal == 0) ? 2 : 0;
        }
      if(RSI_Enable && rsi > 0)
        {
         if(rsi < RSI_Buy_Level)
            c1_signal = (c1_signal == 0) ? 1 : 0;
         if(rsi > RSI_Sell_Level)
            c1_signal = (c1_signal == 0) ? 2 : 0;
        }
      if(WPR_Enable && wpr != 0)
        {
         if(wpr < WPR_Buy_Level)
            c1_signal = (c1_signal == 0) ? 1 : 0;
         if(wpr > WPR_Sell_Level)
            c1_signal = (c1_signal == 0) ? 2 : 0;
        }

      if(Reverse_Signals && c1_signal != 0)
         c1_signal = (c1_signal == 1) ? 2 : 1;

      if(c1_signal == 1 && c1_Buycycle)
        {
         c1_check_for_sell_close = false;
         if(Open[0] != c1_open_price)
           {
            c1_open_price = Open[0];
            c1_place_order = true;
           }
         else
            c1_place_order = false;

         if(c1_Buycount == 0)
           {
            c1_account_equity_buy = AccountInfoDouble(ACCOUNT_EQUITY);
            c1_targetprice_buy = target_amount != 0 ? (c1_account_equity_buy + target_amount) : (c1_account_equity_buy + ((c1_account_equity_buy * target_percent) / 1000));
            c1_riskprice_buy = (c1_account_equity_buy - ((c1_account_equity_buy * Account_Risk_percent) / 1000));
           }

         if(c1_place_order)
           {
            double c1_lot = getLots(1);
            if(IsMarginSufficient(ORDER_TYPE_BUY, c1_lot))
              {
               trade.SetExpertMagicNumber(c1_MagicNumber);
               trade.SetDeviationInPoints(UseSlippage);
               if(trade.Buy(c1_lot, _Symbol, Ask))
                 {
                  c1_sellcycle = true;
                  c1_check_for_buy_close = true;
                  c1_Buycount++;
                 }
              }
           }
        }
      else
         if(c1_signal == 2 && c1_sellcycle)
           {
            c1_check_for_buy_close = false;
            if(Open[0] != c1_open_price)
              {
               c1_open_price = Open[0];
               c1_place_order = true;
              }
            else
               c1_place_order = false;

            if(c1_Sellcount == 0)
              {
               c1_account_equity_sell = AccountInfoDouble(ACCOUNT_EQUITY);
               c1_targetprice_sell = target_amount != 0 ? (c1_account_equity_sell + target_amount) : (c1_account_equity_sell + ((c1_account_equity_sell * target_percent) / 100));
               c1_riskprice_sell = (c1_account_equity_sell - ((c1_account_equity_sell * Account_Risk_percent) / 100));
              }

            if(c1_place_order)
              {
               double c1_lot = getLots(1);
               if(IsMarginSufficient(ORDER_TYPE_SELL, c1_lot))
                 {
                  trade.SetExpertMagicNumber(c1_MagicNumber);
                  trade.SetDeviationInPoints(UseSlippage);
                  if(trade.Sell(c1_lot, _Symbol, Bid))
                    {
                     c1_Buycycle = true;
                     c1_check_for_sell_close = true;
                     c1_Sellcount++;
                    }
                 }
              }
           }

      double c1_profit_Buy = c1_account_equity_buy + MyAccountProfit_Buy(c1_MagicNumber);
      double c1_profit_Sell = c1_account_equity_sell + MyAccountProfit_Sell(c1_MagicNumber);

      if((c1_profit_Sell >= c1_targetprice_sell || c1_profit_Sell <= c1_riskprice_sell))
        {
         ClosePositions(c1_MagicNumber, POSITION_TYPE_SELL);
         if(c1_check_for_sell_close)
            c1_sellcycle = false;
         c1_Sellcount = 0;
        }
      if((c1_profit_Buy >= c1_targetprice_buy || c1_profit_Buy <= c1_riskprice_buy))
        {
         ClosePositions(c1_MagicNumber, POSITION_TYPE_BUY);
         if(c1_check_for_buy_close)
            c1_Buycycle = false;
         c1_Buycount = 0;
        }
     }

}

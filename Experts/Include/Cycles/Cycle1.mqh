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

      if(c1_signal == 1 && C1.Buycycle)
        {
         C1.check_for_sell_close = false;
         if(Open[0] != C1.open_price)
           {
            C1.open_price = Open[0];
            C1.place_order = true;
           }
         else
            C1.place_order = false;

         if(C1.Buycount == 0)
           {
            C1.account_equity_buy = AccountInfoDouble(ACCOUNT_EQUITY);
            C1.targetprice_buy = target_amount != 0 ? (C1.account_equity_buy + target_amount) : (C1.account_equity_buy + ((C1.account_equity_buy * target_percent) / 1000));
            C1.riskprice_buy = (C1.account_equity_buy - ((C1.account_equity_buy * Account_Risk_percent) / 1000));
           }

         if(C1.place_order)
           {
            double c1_lot = getLots(1);
            if(IsMarginSufficient(ORDER_TYPE_BUY, c1_lot))
              {
               trade.SetExpertMagicNumber(c1_MagicNumber);
               trade.SetDeviationInPoints(UseSlippage);
               if(trade.Buy(c1_lot, _Symbol, Ask))
                 {
                  C1.Sellcycle = true;
                  C1.check_for_buy_close = true;
                  C1.Buycount++;
                 }
              }
           }
        }
      else
         if(c1_signal == 2 && C1.Sellcycle)
           {
            C1.check_for_buy_close = false;
            if(Open[0] != C1.open_price)
              {
               C1.open_price = Open[0];
               C1.place_order = true;
              }
            else
               C1.place_order = false;

            if(C1.Sellcount == 0)
              {
               C1.account_equity_sell = AccountInfoDouble(ACCOUNT_EQUITY);
               C1.targetprice_sell = target_amount != 0 ? (C1.account_equity_sell + target_amount) : (C1.account_equity_sell + ((C1.account_equity_sell * target_percent) / 100));
               C1.riskprice_sell = (C1.account_equity_sell - ((C1.account_equity_sell * Account_Risk_percent) / 100));
              }

            if(C1.place_order)
              {
               double c1_lot = getLots(1);
               if(IsMarginSufficient(ORDER_TYPE_SELL, c1_lot))
                 {
                  trade.SetExpertMagicNumber(c1_MagicNumber);
                  trade.SetDeviationInPoints(UseSlippage);
                  if(trade.Sell(c1_lot, _Symbol, Bid))
                    {
                     C1.Buycycle = true;
                     C1.check_for_sell_close = true;
                     C1.Sellcount++;
                    }
                 }
              }
           }

      double c1_profit_Buy = C1.account_equity_buy + MyAccountProfit_Buy(c1_MagicNumber);
      double c1_profit_Sell = C1.account_equity_sell + MyAccountProfit_Sell(c1_MagicNumber);

      if((c1_profit_Sell >= C1.targetprice_sell || c1_profit_Sell <= C1.riskprice_sell))
        {
         ClosePositions(c1_MagicNumber, POSITION_TYPE_SELL);
         if(C1.check_for_sell_close)
            C1.Sellcycle = false;
         C1.Sellcount = 0;
        }
      if((c1_profit_Buy >= C1.targetprice_buy || c1_profit_Buy <= C1.riskprice_buy))
        {
         ClosePositions(c1_MagicNumber, POSITION_TYPE_BUY);
         if(C1.check_for_buy_close)
            C1.Buycycle = false;
         C1.Buycount = 0;
        }
     }

}

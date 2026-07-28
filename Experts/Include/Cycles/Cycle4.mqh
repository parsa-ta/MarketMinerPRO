#ifndef __CYCLE4_MQH__
#define __CYCLE4_MQH__

void ProcessCycle4()
{
//--- CYCLE 4
   if(cycle4)
     {
      double up_env4[2], dn_env4[2];
      CopyBuffer(h_env4, UPPER_LINE, 0, 2, up_env4);
      CopyBuffer(h_env4, LOWER_LINE, 0, 2, dn_env4);

      int c4_signal = 0;
      if(dn_env4[1] - Close[1] > Distance * UsePoint && dn_env4[0] - Bid > Distance * UsePoint)
         c4_signal = 1;
      else
         if(Close[1] - up_env4[1] > Distance * UsePoint && Bid - up_env4[0] > Distance * UsePoint)
            c4_signal = 2;

      if(Reverse_Signals4 && c4_signal != 0)
         c4_signal = (c4_signal == 1) ? 2 : 1;

      if(c4_signal == 1 && c4_Buycycle)
        {
         c4_check_for_sell_close = false;
         if(Open[0] != c4_open_price)
           {
            c4_open_price = Open[0];
            c4_place_order = true;
           }
         else
            c4_place_order = false;

         if(c4_Buycount == 0)
           {
            c4_account_equity_buy = AccountInfoDouble(ACCOUNT_EQUITY);
            c4_targetprice_buy = target_amount4 != 0 ? (c4_account_equity_buy + target_amount4) : (c4_account_equity_buy + ((c4_account_equity_buy * target_percent4) / 100));
            c4_riskprice_buy = (c4_account_equity_buy - ((c4_account_equity_buy * Account_Risk_percent4) / 100));
           }

         if(c4_place_order)
           {
            double c4_lot = getLots(4);
            if(IsMarginSufficient(ORDER_TYPE_BUY, c4_lot))
              {
               trade.SetExpertMagicNumber(c4_MagicNumber);
               trade.SetDeviationInPoints(UseSlippage);
               if(trade.Buy(c4_lot, _Symbol, Ask))
                 {
                  c4_sellcycle = true;
                  c4_check_for_buy_close = true;
                  c4_Buycount++;
                 }
              }
           }
        }
      else
         if(c4_signal == 2 && c4_sellcycle)
           {
            c4_check_for_sell_close = false;
            if(Open[0] != c4_open_price)
              {
               c4_open_price = Open[0];
               c4_place_order = true;
              }
            else
               c4_place_order = false;

            if(c4_Sellcount == 0)
              {
               c4_account_equity_sell = AccountInfoDouble(ACCOUNT_EQUITY);
               c4_targetprice_sell = target_amount4 != 0 ? (c4_account_equity_sell + target_amount4) : (c4_account_equity_sell + ((c4_account_equity_sell * target_percent4) / 100));
               c4_riskprice_sell = (c4_account_equity_sell - ((c4_account_equity_sell * Account_Risk_percent4) / 100));
              }

            if(c4_place_order)
              {
               double c4_lot = getLots(4);
               if(IsMarginSufficient(ORDER_TYPE_SELL, c4_lot))
                 {
                  trade.SetExpertMagicNumber(c4_MagicNumber);
                  trade.SetDeviationInPoints(UseSlippage);
                  if(trade.Sell(c4_lot, _Symbol, Bid))
                    {
                     c4_Buycycle = true;
                     c4_check_for_sell_close = true;
                     c4_Sellcount++;
                    }
                 }
              }
           }

      double c4_profit_Buy = c4_account_equity_buy + MyAccountProfit_Buy(c4_MagicNumber);
      double c4_profit_Sell = c4_account_equity_sell + MyAccountProfit_Sell(c4_MagicNumber);

      if((c4_profit_Sell >= c4_targetprice_sell || c4_profit_Sell <= c4_riskprice_sell))
        {
         ClosePositions(c4_MagicNumber, POSITION_TYPE_SELL);
         if(c4_check_for_sell_close)
            c4_sellcycle = false;
         c4_Sellcount = 0;
        }
      if((c4_profit_Buy >= c4_targetprice_buy || c4_profit_Buy <= c4_riskprice_buy))
        {
         ClosePositions(c4_MagicNumber, POSITION_TYPE_BUY);
         if(c4_check_for_buy_close)
            c4_Buycycle = false;
         c4_Buycount = 0;
        }
     }
}

#endif

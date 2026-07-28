#ifndef __CYCLE_STATE_MQH__
#define __CYCLE_STATE_MQH__

struct CycleState
{
    double account_equity_buy;
    double targetprice_buy;
    double riskprice_buy;

    double account_equity_sell;
    double targetprice_sell;
    double riskprice_sell;

    bool Buycycle;
    bool Sellcycle;

    bool check_for_buy_close;
    bool check_for_sell_close;

    bool place_order;

    double open_price;

    int Buycount;
    int Sellcount;

    void Reset()
    {
        account_equity_buy = 0;
        targetprice_buy = 0;
        riskprice_buy = 0;

        account_equity_sell = 0;
        targetprice_sell = 0;
        riskprice_sell = 0;

        Buycycle = true;
        Sellcycle = true;

        check_for_buy_close = false;
        check_for_sell_close = false;

        place_order = false;

        open_price = 0;

        Buycount = 0;
        Sellcount = 0;
    }
};

CycleState C1;
CycleState C2;
CycleState C3;
CycleState C4;

#endif

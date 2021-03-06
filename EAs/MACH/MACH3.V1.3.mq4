//+-----------------------------------------------------------------+
//|                                                   MACH3_v1.3.mq4 |
//|                                      rodolfo.leonardo@gmail.com. |
//+------------------------------------------------------------------+
#property copyright " MACH3_v1.3"
#property link      "rodolfo.leonardo@gmail.com"
#property version   "1.3"
#property description "MACH3   v1.3 - Grid Expert Advisor"
#property description "This EA is 100% FREE "
#property description "This EA is baseaded in 1-Ilan2.1by Tarasov "
#property description "Coder: rodolfo.leonardo@gmail.com "
#property strict

string vg_versao = " MACH 3 v1.3 2018-02-22 ";

//+------------------------------------------------------------------+
//|           ENUM                                   |
//+------------------------------------------------------------------+
enum ENUM_LOT_MODE {
    LOT_MODE_FIXED = 1,// Fixed Lot
    LOT_MODE_PERCENT = 2,// Percent Lot
     LOT_MODE_EQUITY = 3,// Equity Lot
};

enum ENUM_SINAL_MODE {
    SINAL_RSI = 1,// RSI
    SINAL_MM = 2,// Media Movel
    SINAL_MM_RSI = 2,// RSI + Media Movel
};

//+------------------------------------------------------------------+
//|  input parameters                                                |
//+------------------------------------------------------------------+

extern string               Version__= "----------------------------------------------------------------";
extern string               Version___ = "----------------- MACH3 v1.3  --------------------------------";
extern string               Version____ = "----------------------------------------------------------------";


extern string               InpChartDisplay__= "------------------------Display Info--------------------";
extern bool                 InpChartDisplay= FALSE;                           // Display Info
extern bool                 InpDisplayInpBackgroundColor= TRUE;               // Display background color
extern color                InpBackgroundColor = MediumBlue;                  // background color

extern string MagicNUMBER= "--------Magic Number Engine---------";

string EAName1 = "MACH 1";
input bool    InpEnableMACH1  = true;                                          // Enable MACH 1   [BUY]   
extern int    InpMagicNumber1 = 8801111;                                        // Magic MACH1


string EAName2 = "MACH 2";
input bool    InpEnableMACH2  = true;                                          // Enable MACH 2   [SELL]
extern int    InpMagicNumber2 = 8802222;                                        // Magic MACH2

string EAName3 = "MACH 3";
input bool    InpEnableMACH3  = false;                                           // Enable MACH 3   [BUY / SELL]
extern int    InpMagicNumber3 = 8803333;                                        // Magic MACH3

extern string SINAL__= "----------------------------- SINAL-----------------------";
extern ENUM_SINAL_MODE InpSinalMode = SINAL_MM;                                //TYPE SINAL

extern string RSIConfig__ = "-----------------------------RSI-----------------------";
extern double InpRsiMinimum = 30.0;                                             //Rsi Minimum
extern double InpRsiMaximum = 70.0;                                             //Rsi Maximum

extern string MovingAverageConfig__ = "-----------------------------Moving Average-----------------------";
input ENUM_TIMEFRAMES        InpMaFrame= PERIOD_CURRENT;      // Moving Average TimeFrame
input int                    InpMaPeriod= 3;                // Moving Average Period
input ENUM_MA_METHOD         InpMaMethod= MODE_EMA;         // Moving Average Method
input ENUM_APPLIED_PRICE     InpMaPrice= PRICE_OPEN;        // Moving Average Price
input int                    InpMaShift= 0;                 // Moving Average Shift

extern string Config__= "---------------------------Config--------------------------------------";
extern ENUM_LOT_MODE InpLotsMode  = LOT_MODE_EQUITY;                           //Lots Mode
extern double InpLots = 0.01;                                                   //Lots if LOT_MODE_FIXED
extern int    InpEquityPerLot= 15000;                                           //Equity per lot if LOT_MODE_EQUITY
input double  InpPercentLot= 0.02;                                              //Equity per lot if LOT_MODE_PERCENT
extern int    InpLotdecimal = 2;                                                //Lotdecimal
extern double InpTakeProfit = 1800.0;                                            //Take Profit 
extern double InpStoploss = 500.0;                                              //InpStoploss
extern double InpSlip = 3.0;                                                    //Slip
input int     InpHedgex= 3;                                                     // After Level Change Lot A to B (Necessari A/B Engine Enable)
input double  InpMaxLot = 0.10;                                                 // Max Lot 


extern string Configgrid__ = "---------------------------GRID--------------------------------------";
extern double InpLotExponent = 1.2651;                                             // Grid Increment Factor
extern bool   InpDynamicPips= true;                                             // Dynamic Grid
extern int    InpStepSizeGridDefault= 12;                                        // Step Size in Pips [Default if InpDynamicPips true]
extern int    InpGlubina = 24;                                                   //Qtd Periodos p/ maxima e minima
extern int    InpDEL = 3;                                                       //Divizor de (maxima - minima) p/ calculo do tamanho do grid


extern string TrailingStop__= "--------------------Trailling Stop--------------";
extern bool   InpUseTrailingStop = TRUE;                                       // Use Trailling Stop´?  
extern double InpTrailStart = 17.0;                                             // TraillingStart
extern double InpTrailStop = 29.0;                                              // Size Trailling stop


extern string Filter__= "--------------------Filter --------------";
extern double InpDrop = 5000;                                                   // Filter CCI to close ALL
extern int    InpMaxTrades = 99;                                                // Max Lot Open Simultaneo 
input int     InpDailyTarget= 0;                                                // Daily Target in Money



extern string FilterOpenOneCandle__= "--------------------Filter One Order by Candle--------------";
input bool                 InpOpenOneCandle= FALSE;                              // Open one order by candle
input ENUM_TIMEFRAMES      InpTimeframeBarOpen= PERIOD_CURRENT;                 // Timeframe OpenOneCandle


extern string Filtervg_Spread__= "----------------------------Filter Max vg_Spread--------------------";
input int                  InpMaxvg_Spread= 24;                                 // Max vg_Spread 


extern string EquityCaution__= "------------------------Filter Caution of Equity ---------------";
extern bool                 InpUseEquityCaution= true;                          //  EquityCaution?
extern double               InpInpTotalEquityRiskCaution = 0.2;                   // Total % Risk to EquityCaution
extern ENUM_TIMEFRAMES      InpTimeframeEquityCaution= PERIOD_H4;                // Timeframe as EquityCaution


extern string EquitySTOP__= "------------------------Filter  Equity STOP ---------------";
extern bool   InpUseEquityStop = FALSE;                                         // Usar EquityStop?
extern double InpTotalEquityRisk = 20.0;                                        // Total % Risk to EquityStop
extern bool InpAlertPushEquityLoss= false;                                      //Send Alert to Celular
extern bool InpCloseAllEquityLoss = false;                                      // Close all orders in InpTotalEquityRisk 


extern string FFCall__= "----------------------------Filter News FFCall------------------------";
extern bool                 InpUseFFCall= FALSE;                                 // Use Filter News FFCall
extern int                  InpMinsBeforeNews = 60;                             // mins before an event to stay out of trading
extern int                  InpMinsAfterNews  = 20;                             // mins after  an event to stay out of trading
extern bool                 InpIncludeHigh= true;                               // Include New High Impact

extern string TimeFilter__= "-------------------------Filter DateTime---------------------------";
extern bool InpUtilizeTimeFilter= true;
extern bool InpTrade_in_Monday  = true;
extern bool InpTrade_in_Tuesday = true;
extern bool InpTrade_in_Wednesday= true;
extern bool InpTrade_in_Thursday= true;
extern bool InpTrade_in_Friday  = true;

extern string InpStartHour = "00:00";
extern string InpEndHour   = "23:59";

//+------------------------------------------------------------------+
//|  VARIAVEIS                                   |
//+------------------------------------------------------------------+

//VAR MACH1
double PriceTarget1, StartEquity1, BuyTarget1, SellTarget1;
double AveragePrice1, SellLimit1, BuyLimit1, v_sumLots1;
double LastBuyPrice1, LastSellPrice1, Stopper1 = 0.0, iLots1, l1, ordprof1;
int NumOfTrades1 = 0, v_qtdOrdensOpen1, ticket1, timeprev1 = 0, expiration1, m_orders_count1;
bool TradeNow1 = FALSE, LongTrade1 = FALSE, ShortTrade1 = FALSE, flag1, NewOrdersPlaced1 = FALSE;
datetime  m_time_equityrisk1, m_datetime_ultcandleopen1;

//VAR MACH2
double PriceTarget2, StartEquity2, BuyTarget2, SellTarget2;
double AveragePrice2, SellLimit2, BuyLimit2, v_sumLots2;
double LastBuyPrice2, LastSellPrice2, Stopper2 = 0.0, iLots2, l2, ordprof2;
int NumOfTrades2 = 0, v_qtdOrdensOpen2, ticket2, timeprev2 = 0, expiration2, m_orders_count2;
bool TradeNow2 = FALSE, LongTrade2 = FALSE, ShortTrade2 = FALSE, flag2, NewOrdersPlaced2 = FALSE;
datetime  m_time_equityrisk2, m_datetime_ultcandleopen2;

//VAR MACH3
double PriceTarget3, StartEquity3, BuyTarget3, SellTarget3;
double AveragePrice3, SellLimit3, BuyLimit3, v_sumLots3;
double LastBuyPrice3, LastSellPrice3, Stopper3 = 0.0, iLots3, l3, ordprof3;
int NumOfTrades3 = 0, v_qtdOrdensOpen3, ticket3, timeprev3 = 0, expiration3, m_orders_count3;
bool TradeNow3 = FALSE, LongTrade3 = FALSE, ShortTrade3 = FALSE, flag3, NewOrdersPlaced3 = FALSE;
datetime  m_time_equityrisk3, m_datetime_ultcandleopen3;


//VARIAVEIS GLOBAIS MACH
double vg_AccountEquityHighAmt, vg_PrevEquity, vg_Spread, vg_profit_all;
bool vg_news_time, vg_initpainel;
int vg_cnt = 0;
int    vg_GridSize= 0;
string vg_filters_on;
datetime vg_time_equityriskstopall, vg_DailyTargetday;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
{
    vg_Spread = MarketInfo(Symbol(), MODE_SPREAD) * Point;

    vg_filters_on = "";
    vg_initpainel = true;

    printf(vg_versao +" - Grid Hedging Expert Advisor");

    return (INIT_SUCCEEDED);
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason){

}


//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick() {
   
    double account_balance, margin_required, risk_balance;

    vg_Spread = MarketInfo(Symbol(), MODE_SPREAD) * Point;
    double vg_profit_all = CalculateProfit(InpMagicNumber1, InpMagicNumber2, InpMagicNumber3);
    bool hedge= false;

    RefreshRates();

    vg_filters_on = "";


    //FILTER SPREAD

    if (vg_Spread > InpMaxvg_Spread) {
        vg_filters_on += "Filter InpMaxvg_Spread ON \n";
        return;
    }

    //FILTER NEWS
    if (InpUseFFCall)
        NewsHandling();

    if (vg_news_time && InpUseFFCall) {
        vg_filters_on += "Filter News ON \n";
        return;
    }

    //FILTER DATETIME
    if (InpUtilizeTimeFilter && !TimeFilter()) {
        vg_filters_on += "Filter TimeFilter ON \n";
        
    }

   // SE EquityStop  ENABLE
    if (InpUseEquityStop) {
        if (vg_time_equityriskstopall == iTime(NULL, PERIOD_W1, 0)) {
            vg_filters_on += "Filter EquitySTOP  ON \n";
            return;
        }
    }

    //FILTER DailyTarget 
     if (vg_DailyTargetday == TimeDayOfWeek(TimeCurrent())) {
          vg_filters_on += "Filter DailyTarget ON \n";
          return;
     }

    //IF DailyTarget CloseAll
    if (InpDailyTarget > 0 && vg_profit_all >= InpDailyTarget){
        vg_DailyTargetday = TimeDayOfWeek(TimeCurrent());
        CloseThisSymbolAll(InpMagicNumber1, InpMagicNumber2, InpMagicNumber3);
    }
    

    double vLots= InpLots;
    
    if(InpLotsMode == LOT_MODE_PERCENT){

         risk_balance = InpPercentLot * AccountBalance() / 100.0;
        margin_required = MarketInfo(Symbol(), MODE_MARGINREQUIRED);
        vLots = MathRound(risk_balance / margin_required, SymbolInfoDouble(Symbol(), SYMBOL_VOLUME_STEP));
    }
    if(InpLotsMode == LOT_MODE_EQUITY){
        vLots = MathFloor((AccountEquity() / InpEquityPerLot / 100) / MarketInfo(Symbol(), 24)) * MarketInfo(Symbol(), 24);
    }

    //SINAL
    int SinalMM= 0;
    int SinalRSI= 0;
    int Sinal= 0;
    double PrevCl = iClose(Symbol(), 0, 2);
    double CurrCl= iClose(Symbol(), 0, 1);

    if (PrevCl > CurrCl && iRSI(NULL, PERIOD_H1, 14, PRICE_CLOSE, 1) > InpRsiMinimum) SinalRSI = 1;
    if (PrevCl < CurrCl && iRSI(NULL, PERIOD_H1, 14, PRICE_CLOSE, 1) < InpRsiMaximum) SinalRSI =  -1;

    if(iClose(NULL, 0, 0) > iMA(NULL, InpMaFrame, InpMaPeriod, 0, InpMaMethod, InpMaPrice, InpMaShift))SinalMM = 1;
    if(iClose(NULL, 0, 0) < iMA(NULL, InpMaFrame, InpMaPeriod, 0, InpMaMethod, InpMaPrice, InpMaShift))SinalMM = -1;


    if(InpSinalMode == SINAL_RSI){
           Sinal = SinalMM;
    }else if(InpSinalMode == SINAL_MM){
         Sinal = SinalRSI;
    } else if(InpSinalMode == SINAL_MM_RSI){
          if(SinalRSI == SinalMM)   Sinal = SinalMM;
    }


    // SE MACH1 [BUY] ENABLE
    if (InpEnableMACH1) {

        //FILTER EquityCaution
        if (v_qtdOrdensOpen1 == 0) m_time_equityrisk1 = -1;

        if (m_time_equityrisk1 == iTime(NULL, InpTimeframeEquityCaution, 0)
            && m_time_equityrisk2 != iTime(NULL, InpTimeframeEquityCaution, 0)

        ) {
            vg_filters_on += "Filter EquityCaution MACH 1 ON \n";
        }
        else {


            if (Sinal == 1) {

               if ( InpEnableMACH2) {
             //Envia para a Engine1 o lote da Engine2
                if(v_qtdOrdensOpen2 > (InpHedgex * InpLotExponent)  && ShortTrade2 && !LongTrade1 ) 
                { 
                    for(int i =0;i< InpHedgex;i++) {
                    vLots +=  NormalizeDouble(vLots * MathPow(InpLotExponent, i), InpLotdecimal) ; 
                    }
                    vLots =  vLots * 3; 
                hedge = true; 
                }
             }

                MACHx(EAName1, InpMagicNumber1, Sinal, PriceTarget1, StartEquity1, BuyTarget1, SellTarget1,
                    AveragePrice1, SellLimit1, BuyLimit1,
                    LastBuyPrice1, LastSellPrice1, Stopper1, iLots1, l1, ordprof1,
                    NumOfTrades1, v_qtdOrdensOpen1, ticket1, timeprev1, expiration1,
                    TradeNow1, LongTrade1, ShortTrade1, flag1, NewOrdersPlaced1, m_time_equityrisk1,
                    m_datetime_ultcandleopen1, v_sumLots1, vLots, hedge);
            }
        }
    }

    // SE MACH2  [SELL] ENABLE
    if (InpEnableMACH2) {

        //FILTER EquityCaution
        if (v_qtdOrdensOpen2 == 0) m_time_equityrisk2 = -1;

        if (m_time_equityrisk2 == iTime(NULL, InpTimeframeEquityCaution, 0)
            && m_time_equityrisk1 != iTime(NULL, InpTimeframeEquityCaution, 0)
        ) {
            vg_filters_on += "Filter EquityCaution MACH 2 ON \n";
        }
        else {
            if (Sinal == -1) {

                 if ( InpEnableMACH1) {
             //Envia para a Engine2 o lote da Engine1
                if(v_qtdOrdensOpen1 > (InpHedgex * InpLotExponent)  && LongTrade1 && !ShortTrade2 ) 
                { 
                   for(int i =0;i< InpHedgex;i++) {
                    vLots +=  NormalizeDouble(vLots * MathPow(InpLotExponent, i), InpLotdecimal) ; 
                    }
                    vLots =  vLots * 3; 
                hedge = true; 
                }
             }

              

                MACHx(EAName2, InpMagicNumber2, Sinal, PriceTarget2, StartEquity2, BuyTarget2, SellTarget2,
                    AveragePrice2, SellLimit2, BuyLimit2,
                    LastBuyPrice2, LastSellPrice2, Stopper2, iLots2, l2, ordprof2,
                    NumOfTrades2, v_qtdOrdensOpen2, ticket2, timeprev2, expiration2,
                    TradeNow2, LongTrade2, ShortTrade2, flag2, NewOrdersPlaced2, m_time_equityrisk2,
                    m_datetime_ultcandleopen2, v_sumLots2, vLots, hedge);
            }
        }
    }

    // SE MACH3  [BUY/SELL] ENABLE
    if (InpEnableMACH3) {
        //FILTER EquityCaution
        if (v_qtdOrdensOpen3 == 0) m_time_equityrisk3 = -1;

        if (m_time_equityrisk3 == iTime(NULL, InpTimeframeEquityCaution, 0)
        ) {
            vg_filters_on += "Filter EquityCaution MACH 3 ON \n";
        }
        else {

            

 if (PrevCl > CurrCl && iRSI(NULL, PERIOD_H1, 14, PRICE_CLOSE, 1) > InpRsiMinimum) Sinal = 1;
    if (PrevCl < CurrCl && iRSI(NULL, PERIOD_H1, 14, PRICE_CLOSE, 1) < InpRsiMaximum) Sinal =  -1;


            MACHx(EAName3, InpMagicNumber3, Sinal, PriceTarget3, StartEquity3, BuyTarget3, SellTarget3,
                AveragePrice3, SellLimit3, BuyLimit3,
                LastBuyPrice3, LastSellPrice3, Stopper3, iLots3, l3, ordprof3,
                NumOfTrades3, v_qtdOrdensOpen3, ticket3, timeprev3, expiration3,
                TradeNow3, LongTrade3, ShortTrade3, flag3, NewOrdersPlaced3, m_time_equityrisk3,
                m_datetime_ultcandleopen3, v_sumLots3, vLots, hedge);

        }
    }


    // SE EquityStop  ENABLE
    if (InpUseEquityStop) {
        
        if (vg_profit_all < 0.0 && MathAbs(vg_profit_all) > InpTotalEquityRisk / 100.0 * AccountEquity()) {
            if (InpCloseAllEquityLoss) { CloseThisSymbolAll(InpMagicNumber1, InpMagicNumber2, InpMagicNumber3); Print("Closed All due_Hilo to Stop Out"); }
            if (InpAlertPushEquityLoss) SendNotification("EquityLoss Alert " + (string)vg_profit_all);

            vg_time_equityriskstopall = iTime(NULL, PERIOD_W1, 0);
            return;
        }
        else {
            vg_time_equityriskstopall = -1;
        }
    }

   
   
    // SE ChartDisplay  ENABLE
    if (InpChartDisplay)
        Informacoes();
}


//+------------------------------------------------------------------+
//|           EA MACH x                                              |
//+------------------------------------------------------------------+
void MACHx(string ID, int MagicNumber, int vSinal, double & PriceTarget, double & StartEquity, double & BuyTarget, double & SellTarget,
    double & AveragePrice, double & SellLimit, double & BuyLimit,
    double & LastBuyPrice, double & LastSellPrice, double & Stopper, double & iLots, double & l, double & ordprof,
    int & NumOfTrades, int & v_totalOrdensOpen, int & ticket, int & timeprev, int & expiration,
    bool & TradeNow, bool & LongTrade, bool & ShortTrade, bool & flag, bool & NewOrdersPlaced,
    datetime & m_time_equityrisk, datetime & vDatetimeUltCandleOpen, double & v_sumLots, double & Lots, bool hedge){

    //NORMALIZA LOT
    if (Lots < MarketInfo(Symbol(), 23)) Lots = MarketInfo(Symbol(), 23);
    if (Lots > MarketInfo(Symbol(), 25)) Lots = MarketInfo(Symbol(), 25);

    // SE DynamicPips  ENABLE
    if (InpDynamicPips) {

        // calculate highest and lowest price from last bar to 24 bars ago
        double hival= High[iHighest(NULL, 0, MODE_HIGH, InpGlubina, 1)];    
        
        // chart used for symbol and time period
        double loval= Low[iLowest(NULL, 0, MODE_LOW, InpGlubina, 1)];       
        // calculate pips for spread between orders
        vg_GridSize = NormalizeDouble((hival - loval) / InpDEL / Point, 0);         

        if (vg_GridSize < InpStepSizeGridDefault / InpDEL) vg_GridSize = NormalizeDouble(InpStepSizeGridDefault / InpDEL, 0);

        // if dynamic pips fail, assign pips extreme value
        if (vg_GridSize > InpStepSizeGridDefault * InpDEL) vg_GridSize = NormalizeDouble(InpStepSizeGridDefault * InpDEL, 0);          
    } else 
      vg_GridSize = InpStepSizeGridDefault;

    // SE TrailingStop  ENABLE
    if (InpUseTrailingStop) TrailingAlls(InpTrailStart, InpTrailStop, AveragePrice, MagicNumber);

    // Drop  = CloseThisSymbolAll
    if ((iCCI(NULL, 15, 55, 0, 0) > InpDrop && ShortTrade) || (iCCI(NULL, 15, 55, 0, 0) < (-InpDrop) && LongTrade)) {
        CloseThisSymbolAll(MagicNumber);
        Print("Closed All due to TimeOut [InpDrop] ");
    }

    if (timeprev == Time[0]) return;
    timeprev = Time[0];

    double CurrentPairProfit = CalculateProfit(MagicNumber);
    
    //VERIFICA SE POSSUI TRADER ATIVO
    v_totalOrdensOpen = CountTrades(MagicNumber);
    if (v_totalOrdensOpen == 0) flag = FALSE;
    for (vg_cnt = OrdersTotal() - 1; vg_cnt >= 0; vg_cnt--) {
        OrderSelect(vg_cnt, SELECT_BY_POS, MODE_TRADES);
        if (OrderSymbol() != Symbol() || OrderMagicNumber() != MagicNumber) continue;
        if (OrderSymbol() == Symbol() && OrderMagicNumber() == MagicNumber) {
            if (OrderType() == OP_BUY) {
                LongTrade = TRUE;
                ShortTrade = FALSE;
                break;
            }
        }
        if (OrderSymbol() == Symbol() && OrderMagicNumber() == MagicNumber) {
            if (OrderType() == OP_SELL) {
                LongTrade = FALSE;
                ShortTrade = TRUE;
                break;
            }
        }
    }

    //VERIFY GRID SPACE TO TRADE
    if (v_totalOrdensOpen > 0 && v_totalOrdensOpen <= InpMaxTrades) {
        RefreshRates();
        double l_lastlot1, l_lastlot2 = 0;
        LastBuyPrice = FindLastBuyPrice(MagicNumber, l_lastlot1);
        LastSellPrice = FindLastSellPrice(MagicNumber, l_lastlot2);
        v_sumLots = l_lastlot1 + l_lastlot2;

        if (LongTrade && LastBuyPrice - Ask >= vg_GridSize * Point) TradeNow = TRUE;
        if (ShortTrade && Bid - LastSellPrice >= vg_GridSize * Point) TradeNow = TRUE;
    }

    if (v_totalOrdensOpen < 1) {
        ShortTrade = FALSE;
        LongTrade = FALSE;
        TradeNow = TRUE;
        StartEquity = AccountEquity();
    }

   // SE OpenOneCandle   ENABLE
    if ( !InpOpenOneCandle  || (InpOpenOneCandle && vDatetimeUltCandleOpen != iTime(NULL, InpTimeframeBarOpen, 0))) {

        // ORDEM DE GRID
        if (TradeNow && (ShortTrade || LongTrade)) {
            LastBuyPrice = FindLastBuyPrice(MagicNumber, v_sumLots);
            LastSellPrice = FindLastSellPrice(MagicNumber, v_sumLots);

            NumOfTrades = v_totalOrdensOpen;

            //if(hedge)
             //   iLots = Lots;
            //else
               iLots = NormalizeDouble(Lots * MathPow(InpLotExponent, NumOfTrades), InpLotdecimal);

            if (iLots < MarketInfo(Symbol(), 23)) iLots = MarketInfo(Symbol(), 23);
            if (iLots > MarketInfo(Symbol(), 25)) iLots = MarketInfo(Symbol(), 25);
            if (iLots > InpMaxLot && !hedge) iLots = InpMaxLot;

           

            RefreshRates();

            
           //SELL
            if (ShortTrade  && vSinal == -1) {
                
                ticket = OpenPendingOrder(1, iLots, Bid, InpSlip, Ask, 0, 0, ID + "-" + NumOfTrades + "-" + vg_GridSize, MagicNumber, 0, HotPink);
                if (ticket < 0) {
                    Print("Error: ", GetLastError());
                    return;
                }
                LastSellPrice = FindLastSellPrice(MagicNumber, v_sumLots);
                TradeNow = FALSE;
                vDatetimeUltCandleOpen = iTime(NULL, InpTimeframeBarOpen, 0);
                NewOrdersPlaced = TRUE;
            }

           
            //BUY
           if (LongTrade && vSinal == 1) {
                    
                    ticket = OpenPendingOrder(0, iLots, Ask, InpSlip, Bid, 0, 0, ID + "-" + NumOfTrades + "-" + vg_GridSize, MagicNumber, 0, Lime);
                    if (ticket < 0) {
                        Print("Error: ", GetLastError());
                        return;
                    }
                    LastBuyPrice = FindLastBuyPrice(MagicNumber, v_sumLots);
                    TradeNow = FALSE;
                    vDatetimeUltCandleOpen = iTime(NULL, InpTimeframeBarOpen, 0);
                    NewOrdersPlaced = TRUE;
            }
            
        }
    }

    // CONTROL DRAWDOWN
    double vProfit= CalculateProfit(MagicNumber);
    if (vProfit < 0.0 && MathAbs(vProfit) > InpInpTotalEquityRiskCaution / 100.0 * AccountEquity()) {
        m_time_equityrisk = iTime(NULL, InpTimeframeEquityCaution, 0);
    } else {
        m_time_equityrisk = -1;
    }


    //  OpenOneCandle   
    if (!InpOpenOneCandle || (InpOpenOneCandle && vDatetimeUltCandleOpen != iTime(NULL, InpTimeframeBarOpen, 0))) {

        // 1ª ORDEM DO GRID
        if (TradeNow && v_totalOrdensOpen < 1) {

            SellLimit = Bid;
            BuyLimit = Ask;
            if (!ShortTrade && !LongTrade) {

                NumOfTrades = v_totalOrdensOpen;

                if(hedge)
                    iLots = Lots;
                else
                    iLots = NormalizeDouble(Lots * MathPow(InpLotExponent, NumOfTrades), InpLotdecimal);

                if (iLots < MarketInfo(Symbol(), 23)) iLots = MarketInfo(Symbol(), 23);
                if (iLots > MarketInfo(Symbol(), 25)) iLots = MarketInfo(Symbol(), 25);

              
                if (iLots > InpMaxLot && !hedge) iLots = InpMaxLot;

               
                //SELL
                if (vSinal == -1) {
                    ticket = OpenPendingOrder(1, iLots, SellLimit, InpSlip, SellLimit, 0, 0, ID + "-" + NumOfTrades, MagicNumber, 0, HotPink);
                    if (ticket < 0) {
                        Print("Error: ", GetLastError());
                        return;
                    }
                    
                    LastSellPrice = FindLastSellPrice(MagicNumber, v_sumLots);
                    TradeNow = FALSE;
                    vDatetimeUltCandleOpen = iTime(NULL, InpTimeframeBarOpen, 0);
                    NewOrdersPlaced = TRUE;
                   
                }

                //BUY
                if (vSinal == 1) {

                    ticket = OpenPendingOrder(0, iLots, BuyLimit, InpSlip, BuyLimit, 0, 0, ID + "-" + NumOfTrades, MagicNumber, 0, Lime);
                    if (ticket < 0) {
                        Print("Error: ", GetLastError());
                        return;
                    }
                    LastBuyPrice = FindLastBuyPrice(MagicNumber, v_sumLots);
                    TradeNow = FALSE;
                    vDatetimeUltCandleOpen = iTime(NULL, InpTimeframeBarOpen, 0);
                    NewOrdersPlaced = TRUE;
                    
                    
                }

               // if (ticket > 0) expiration = TimeCurrent() + 60.0 * (60.0 * InpMaxTradeOpenHours);
               
            }
        }
    }

    //CALC AveragePrice / Count Total Lots
    v_totalOrdensOpen = CountTrades(MagicNumber);
    AveragePrice = 0;
    double Count = 0;
    for (vg_cnt = OrdersTotal() - 1; vg_cnt >= 0; vg_cnt--) {
        OrderSelect(vg_cnt, SELECT_BY_POS, MODE_TRADES);
        if (OrderSymbol() != Symbol() || OrderMagicNumber() != MagicNumber) continue;
        if (OrderSymbol() == Symbol() && OrderMagicNumber() == MagicNumber) {
            if (OrderType() == OP_BUY || OrderType() == OP_SELL) {
                AveragePrice += OrderOpenPrice() * OrderLots();
                Count += OrderLots();
            }
        }
    }
    if (v_totalOrdensOpen > 0) AveragePrice = NormalizeDouble(AveragePrice / Count, Digits);
    v_sumLots = Count;

    //CALC PriceTarget/BuyTarget/Stopper
    if (NewOrdersPlaced) {
        for (vg_cnt = OrdersTotal() - 1; vg_cnt >= 0; vg_cnt--) {
            OrderSelect(vg_cnt, SELECT_BY_POS, MODE_TRADES);
            if (OrderSymbol() != Symbol() || OrderMagicNumber() != MagicNumber) continue;
            if (OrderSymbol() == Symbol() && OrderMagicNumber() == MagicNumber) {
                if (OrderType() == OP_BUY) {
                    PriceTarget = AveragePrice + InpTakeProfit * Point;
                    BuyTarget = PriceTarget;
                    Stopper = AveragePrice - InpStoploss * Point;
                    flag = TRUE;
                }
            }
            if (OrderSymbol() == Symbol() && OrderMagicNumber() == MagicNumber) {
                if (OrderType() == OP_SELL) {
                    PriceTarget = AveragePrice - InpTakeProfit * Point;
                    SellTarget = PriceTarget;
                    Stopper = AveragePrice + InpStoploss * Point;
                    flag = TRUE;
                }
            }
        }
    }

    //ADD TAKE PROFIT
    if (NewOrdersPlaced) {
        if (flag == TRUE) {
            for (vg_cnt = OrdersTotal() - 1; vg_cnt >= 0; vg_cnt--) {
                OrderSelect(vg_cnt, SELECT_BY_POS, MODE_TRADES);
                if (OrderSymbol() != Symbol() || OrderMagicNumber() != MagicNumber) continue;
                if (OrderSymbol() == Symbol() && OrderMagicNumber() == MagicNumber) 
                OrderModify(OrderTicket(), NormalizeDouble(AveragePrice, Digits), NormalizeDouble(OrderStopLoss(), Digits), NormalizeDouble(PriceTarget, Digits), 0, Yellow);
                NewOrdersPlaced = FALSE;
            }
        }
    }

    //CLOSE ALL IF MaxTrades 
    if (v_totalOrdensOpen > InpMaxTrades) {
        for (int pos = 0; pos < OrdersTotal(); pos++) {
            OrderSelect(pos, SELECT_BY_POS);
            if (OrderSymbol() != Symbol() || OrderMagicNumber() != MagicNumber) continue;
            if (OrderSymbol() == Symbol() && OrderMagicNumber() == MagicNumber)
                if (OrderType() == OP_SELL) {
                    OrderClose(OrderTicket(), OrderLots(), Ask, 5, White);
                    ordprof = OrderSwap() + OrderProfit() + OrderCommission();
                    if (GetLastError() == 0) {
                        SendNotification("SellOrder: " + Symbol() + ", " + OrderType() + ", " + DoubleToStr(Ask, Digits) + ", " + DoubleToStr(OrderLots(), 2) + ", " + DoubleToStr(ordprof, 2));
                    }
                    pos = OrdersTotal();
                }
            if (OrderType() == OP_BUY) {
                OrderClose(OrderTicket(), OrderLots(), Bid, 5, White);
                ordprof = OrderSwap() + OrderProfit() + OrderCommission();
                if (GetLastError() == 0) {
                    SendNotification("BuyOrder: " + Symbol() + ", " + OrderType() + ", " + DoubleToStr(Ask, Digits) + ", " + DoubleToStr(OrderLots(), 2) + ", " + DoubleToStr(ordprof, 2));
                }
                pos = OrdersTotal();
            }
        }
    }
}

//+------------------------------------------------------------------+
//|           CountTrades                                   |
//+------------------------------------------------------------------+
int CountTrades(int MagicNumber) {
    int count = 0;
    for (int trade = OrdersTotal() - 1; trade >= 0; trade--) {
        OrderSelect(trade, SELECT_BY_POS, MODE_TRADES);
        if (OrderSymbol() != Symbol() || OrderMagicNumber() != MagicNumber) continue;
        if (OrderSymbol() == Symbol() && OrderMagicNumber() == MagicNumber)
            if (OrderType() == OP_SELL || OrderType() == OP_BUY) count++;
    }
    return (count);
}

//+------------------------------------------------------------------+
//|           CloseThisSymbolAll                                   |
//+------------------------------------------------------------------+
void CloseThisSymbolAll(int MagicNumber) {
    for (int trade = OrdersTotal() - 1; trade >= 0; trade--) {
        OrderSelect(trade, SELECT_BY_POS, MODE_TRADES);
        if (OrderSymbol() == Symbol()) {
            if (OrderSymbol() == Symbol() && OrderMagicNumber() == MagicNumber) {
                if (OrderType() == OP_BUY) OrderClose(OrderTicket(), OrderLots(), Bid, InpSlip, Blue);
                if (OrderType() == OP_SELL) OrderClose(OrderTicket(), OrderLots(), Ask, InpSlip, Red);
            }
            Sleep(1000);
        }
    }
}


//+------------------------------------------------------------------+
//|           OpenPendingOrder                                   |
//+------------------------------------------------------------------+
int OpenPendingOrder(int pType, double pLots, double pLevel, int sp, double pr, int sl, int tp, string pComment, int pMagic, int pDatetime, color pColor) {
    int ticket = 0;
    int err = 0;
    int c = 0;
    int NumberOfTries = 100;
    switch (pType) {
        case 2:
            for (c = 0; c < NumberOfTries; c++) {
                ticket = OrderSend(Symbol(), OP_BUYLIMIT, pLots, pLevel, sp, StopLong(pr, sl), TakeLong(pLevel, tp), pComment, pMagic, pDatetime, pColor);
                err = GetLastError();
                if (err == 0/* NO_ERROR */) {
                    SendNotification("BUYLIMIT " + Symbol() + ", BuyLimit, " + DoubleToStr(pLevel, Digits) + ", " + DoubleToStr(pLots, 2));
                    break;
                }
                if (!(err == 4/* SERVER_BUSY */ || err == 137/* BROKER_BUSY */ || err == 146/* TRADE_CONTEXT_BUSY */ || err == 136/* OFF_QUOTES */)) break;
                Sleep(1000);
            }
            break;
        case 4:
            for (c = 0; c < NumberOfTries; c++) {
                ticket = OrderSend(Symbol(), OP_BUYSTOP, pLots, pLevel, sp, StopLong(pr, sl), TakeLong(pLevel, tp), pComment, pMagic, pDatetime, pColor);
                err = GetLastError();
                if (err == 0/* NO_ERROR */) {
                    SendNotification("BUYSTOP " + Symbol() + ", BuyStop, " + DoubleToStr(pLevel, Digits) + ", " + DoubleToStr(pLots, 2));
                    break;
                }
                if (!(err == 4/* SERVER_BUSY */ || err == 137/* BROKER_BUSY */ || err == 146/* TRADE_CONTEXT_BUSY */ || err == 136/* OFF_QUOTES */)) break;
                Sleep(5000);
            }
            break;
        case 0:
            for (c = 0; c < NumberOfTries; c++) {
                RefreshRates();
                ticket = OrderSend(Symbol(), OP_BUY, pLots, NormalizeDouble(Ask, Digits), sp, NormalizeDouble(StopLong(Bid, sl), Digits), NormalizeDouble(TakeLong(Ask, tp), Digits), pComment, pMagic, pDatetime, pColor);
                err = GetLastError();
                if (err == 0/* NO_ERROR */) {
                    SendNotification("BuyOrder: " + Symbol() + ", Buy, " + DoubleToStr(Ask, Digits) + ", " + DoubleToStr(pLots, 2));
                    break;
                }
                if (!(err == 4/* SERVER_BUSY */ || err == 137/* BROKER_BUSY */ || err == 146/* TRADE_CONTEXT_BUSY */ || err == 136/* OFF_QUOTES */)) break;
                Sleep(5000);
            }
            break;
        case 3:
            for (c = 0; c < NumberOfTries; c++) {
                ticket = OrderSend(Symbol(), OP_SELLLIMIT, pLots, pLevel, sp, StopShort(pr, sl), TakeShort(pLevel, tp), pComment, pMagic, pDatetime, pColor);
                err = GetLastError();
                if (err == 0/* NO_ERROR */) {
                    SendNotification("SELLLIMIT " + Symbol() + ", SellLimit, " + DoubleToStr(pLevel, Digits) + ", " + DoubleToStr(pLots, 2));
                    break;
                }
                if (!(err == 4/* SERVER_BUSY */ || err == 137/* BROKER_BUSY */ || err == 146/* TRADE_CONTEXT_BUSY */ || err == 136/* OFF_QUOTES */)) break;
                Sleep(5000);
            }
            break;
        case 5:
            for (c = 0; c < NumberOfTries; c++) {
                ticket = OrderSend(Symbol(), OP_SELLSTOP, pLots, pLevel, sp, StopShort(pr, sl), TakeShort(pLevel, tp), pComment, pMagic, pDatetime, pColor);
                err = GetLastError();
                if (err == 0/* NO_ERROR */) {
                    SendNotification("SELLSTOP " + Symbol() + ", SellStop, " + DoubleToStr(pLevel, Digits) + ", " + DoubleToStr(pLots, 2));
                    break;
                }
                if (!(err == 4/* SERVER_BUSY */ || err == 137/* BROKER_BUSY */ || err == 146/* TRADE_CONTEXT_BUSY */ || err == 136/* OFF_QUOTES */)) break;
                Sleep(5000);
            }
            break;
        case 1:
            for (c = 0; c < NumberOfTries; c++) {
                ticket = OrderSend(Symbol(), OP_SELL, pLots, NormalizeDouble(Bid, Digits), sp, NormalizeDouble(StopShort(Ask, sl), Digits), NormalizeDouble(TakeShort(Bid, tp), Digits), pComment, pMagic, pDatetime, pColor);
                err = GetLastError();
                if (err == 0/* NO_ERROR */) {
                    SendNotification("SELL " + Symbol() + ", Sell, " + DoubleToStr(Bid, Digits) + ", " + DoubleToStr(pLots, 2));
                    break;
                }
                if (!(err == 4/* SERVER_BUSY */ || err == 137/* BROKER_BUSY */ || err == 146/* TRADE_CONTEXT_BUSY */ || err == 136/* OFF_QUOTES */)) break;
                Sleep(5000);
            }
    }
    return (ticket);
}

//+------------------------------------------------------------------+
//|           StopLong                                   |
//+------------------------------------------------------------------+
double StopLong(double price, int stop) {
    if (stop == 0) return (0);
    else return (price - stop * Point);
}

//+------------------------------------------------------------------+
//|           StopShort                                   |
//+------------------------------------------------------------------+
double StopShort(double price, int stop) {
    if (stop == 0) return (0);
    else return (price + stop * Point);
}

//+------------------------------------------------------------------+
//|           TakeLong                                   |
//+------------------------------------------------------------------+
double TakeLong(double price, int stop) {
    if (stop == 0) return (0);
    else return (price + stop * Point);
}

//+------------------------------------------------------------------+
//|           TakeShort                                   |
//+------------------------------------------------------------------+
double TakeShort(double price, int stop) {
    if (stop == 0) return (0);
    else return (price - stop * Point);
}

//+------------------------------------------------------------------+
//|           CalculateProfit                                   |
//+------------------------------------------------------------------+
double CalculateProfit(int MagicNumber) {
    double Profit = 0;
    for (vg_cnt = OrdersTotal() - 1; vg_cnt >= 0; vg_cnt--) {
        OrderSelect(vg_cnt, SELECT_BY_POS, MODE_TRADES);
        if (OrderSymbol() != Symbol() || OrderMagicNumber() != MagicNumber) continue;
        if (OrderSymbol() == Symbol() && OrderMagicNumber() == MagicNumber)
            if (OrderType() == OP_BUY || OrderType() == OP_SELL) Profit += OrderProfit();
    }
    return (Profit);
}
//+------------------------------------------------------------------+
//|           TrailingAlls                                   |
//+------------------------------------------------------------------+
void TrailingAlls(int pType, int stop, double AvgPrice, int MagicNumber) {
    int profit;
    double stoptrade;
    double stopcal;
    if (stop != 0) {
        for (int trade = OrdersTotal() - 1; trade >= 0; trade--) {
            if (OrderSelect(trade, SELECT_BY_POS, MODE_TRADES)) {
                if (OrderSymbol() != Symbol() || OrderMagicNumber() != MagicNumber) continue;
                if (OrderSymbol() == Symbol() || OrderMagicNumber() == MagicNumber) {
                    if (OrderType() == OP_BUY) {
                        profit = NormalizeDouble((Bid - AvgPrice) / Point, 0);
                        if (profit < pType) continue;
                        stoptrade = OrderStopLoss();
                        stopcal = Bid - stop * Point;
                        if (stoptrade == 0.0 || (stoptrade != 0.0 && stopcal > stoptrade)) OrderModify(OrderTicket(), AvgPrice, stopcal, OrderTakeProfit(), 0, Aqua);
                    }
                    if (OrderType() == OP_SELL) {
                        profit = NormalizeDouble((AvgPrice - Ask) / Point, 0);
                        if (profit < pType) continue;
                        stoptrade = OrderStopLoss();
                        stopcal = Ask + stop * Point;
                        if (stoptrade == 0.0 || (stoptrade != 0.0 && stopcal < stoptrade)) OrderModify(OrderTicket(), AvgPrice, stopcal, OrderTakeProfit(), 0, Red);
                    }
                }
                Sleep(1000);
            }
        }
    }
}
//+------------------------------------------------------------------+
//|           AccountEquityHigh                       |
//+------------------------------------------------------------------+
double AccountEquityHigh(int MagicNumber) {
    if (CountTrades(MagicNumber) == 0) vg_AccountEquityHighAmt = AccountEquity();
    if (vg_AccountEquityHighAmt < vg_PrevEquity) vg_AccountEquityHighAmt = vg_PrevEquity;
    else vg_AccountEquityHighAmt = AccountEquity();
    vg_PrevEquity = AccountEquity();
    return (vg_AccountEquityHighAmt);
}

//+------------------------------------------------------------------+
//|           FindLastBuyPrice                                     |
//+------------------------------------------------------------------+
double FindLastBuyPrice(int MagicNumber, double & v_sumLots) {

    v_sumLots = 0;
    double oldorderopenprice;
    int oldticketnumber;
    double unused = 0;
    int ticketnumber = 0;
    for (int vg_cnt = OrdersTotal() - 1; vg_cnt >= 0; vg_cnt--) {
        OrderSelect(vg_cnt, SELECT_BY_POS, MODE_TRADES);
        if (OrderSymbol() != Symbol() || OrderMagicNumber() != MagicNumber) continue;
        if (OrderSymbol() == Symbol() && OrderMagicNumber() == MagicNumber && OrderType() == OP_BUY) {
            oldticketnumber = OrderTicket();
            if (oldticketnumber > ticketnumber) {
                oldorderopenprice = OrderOpenPrice();
                //unused = oldorderopenprice;
                v_sumLots += OrderLots();
                ticketnumber = oldticketnumber;
            }
        }
    }
    return (oldorderopenprice);
}

//+------------------------------------------------------------------+
//|           FindLastSellPrice                                     |
//+------------------------------------------------------------------+
double FindLastSellPrice(int MagicNumber, double & v_sumLots) {
    v_sumLots = 0;
    double oldorderopenprice;
    int oldticketnumber;
    double unused = 0;
    int ticketnumber = 0;
    for (int vg_cnt = OrdersTotal() - 1; vg_cnt >= 0; vg_cnt--) {
        OrderSelect(vg_cnt, SELECT_BY_POS, MODE_TRADES);
        if (OrderSymbol() != Symbol() || OrderMagicNumber() != MagicNumber) continue;
        if (OrderSymbol() == Symbol() && OrderMagicNumber() == MagicNumber && OrderType() == OP_SELL) {
            oldticketnumber = OrderTicket();
            if (oldticketnumber > ticketnumber) {
                oldorderopenprice = OrderOpenPrice();
                //unused = oldorderopenprice;
                v_sumLots += OrderLots();
                ticketnumber = oldticketnumber;
            }
        }
    }
    return (oldorderopenprice);
}


//+------------------------------------------------------------------+
//|           Informacoes                                     |
//+------------------------------------------------------------------+
void Informacoes()
{

    string Ls_64;

    int Li_84;

    if (!IsOptimization()) {

        Ls_64 = "==========================\n";
        Ls_64 = Ls_64 + " " + vg_versao + "\n";
        Ls_64 = Ls_64 + "==========================\n";
        // Ls_64 = Ls_64 + "  Broker:  " + AccountCompany() + "\n";
        Ls_64 = Ls_64 + "  Time of Broker:" + TimeToStr(TimeCurrent(), TIME_DATE | TIME_SECONDS) + "\n";
        // Ls_64 = Ls_64 + "  Currenci: " + AccountCurrency() + "\n";
        //Ls_64 = Ls_64 + "==========================\n";
        Ls_64 = Ls_64 + "  Grid Size : " + (string)vg_GridSize + " Pips \n";
        Ls_64 = Ls_64 + "  InpTakeProfit: " + (string)InpTakeProfit + " Pips \n";
        //  Ls_64 = Ls_64 + "  Lot Mode : " + (string)InpLotMode + "  \n";
        Ls_64 = Ls_64 + "  Exponent Factor: " + (string)InpLotExponent + " pips\n";
        // Ls_64 = Ls_64 + "  Daily Target: " + (string)InpDailyTarget + "\n";
        //  Ls_64 = Ls_64 + "  Hedge After Level: " + (string)InpHedge + " \n";
        Ls_64 = Ls_64 + "  InpMaxvg_Spread: " + (string)InpMaxvg_Spread + " pips\n";
        Ls_64 = Ls_64 + "==========================\n";
        Ls_64 = Ls_64 + "  vg_Spread: " + (string)MarketInfo(Symbol(), MODE_SPREAD) + " \n";
        Ls_64 = Ls_64 + "  Equity:      " + DoubleToStr(AccountEquity(), 2) + " \n";
        Ls_64 = Ls_64 + "  Last Lot :     | 1 : " + DoubleToStr(v_sumLots1, 2) + " | 2 : " + DoubleToStr(v_sumLots2, 2) + " | 3 : " + DoubleToStr(v_sumLots3, 2) + " \n";
        Ls_64 = Ls_64 + "  Orders Opens : | 1 : " + (string)v_qtdOrdensOpen1  + " | 2 : " + (string)v_qtdOrdensOpen2 + " | 3 : " + (string)v_qtdOrdensOpen3 + " \n";
        Ls_64 = Ls_64 + "  Profit/Loss:   | 1 : " + DoubleToStr(CalculateProfit(InpMagicNumber1), 2) + " | 2 : " + DoubleToStr(CalculateProfit(InpMagicNumber2), 2) + " | 3 : " + DoubleToStr(CalculateProfit(InpMagicNumber3), 2) + " \n";
        Ls_64 = Ls_64 + " ==========================\n";
        Ls_64 = Ls_64 + " EquityCautionFilter : " + (string)InpUseEquityCaution + " \n";
        Ls_64 = Ls_64 + " InpTotalEquityRiskCaution : " + DoubleToStr(InpInpTotalEquityRiskCaution, 2) + " % \n";
        Ls_64 = Ls_64 + " EquityStopFilter : " + (string)InpUseEquityStop + " \n";
        Ls_64 = Ls_64 + " InpTotalEquityRiskStop : " + DoubleToStr(InpTotalEquityRisk, 2) + " % \n";
        Ls_64 = Ls_64 + " NewsFilter : " + (string)InpUseFFCall + " \n";
        Ls_64 = Ls_64 + " TimeFilter : " + (string)InpUtilizeTimeFilter + " \n";
        Ls_64 = Ls_64 + " ==========================\n";
        Ls_64 = Ls_64 + vg_filters_on;



        Comment(Ls_64);
        Li_84 = 16;
        if (InpDisplayInpBackgroundColor) {
            if (vg_initpainel || Seconds() % 5 == 0) {
                vg_initpainel = FALSE;
                for (int count_88= 0; count_88 < 12; count_88++)
                {
                    for (int count_92= 0; count_92 < Li_84; count_92++)
                    {
                        ObjectDelete("background" + (string)count_88+ (string)count_92);
                        ObjectDelete("background" + (string)count_88+ ((string)(count_92 + 1)));
                        ObjectDelete("background" + (string)count_88+ ((string)(count_92 + 2)));
                        ObjectCreate("background" + (string)count_88+ (string)count_92, OBJ_LABEL, 0, 0, 0);
                        ObjectSetText("background" + (string)count_88+ (string)count_92, "n", 30, "Wingdings", InpBackgroundColor);
                        ObjectSet("background" + (string)count_88+ (string)count_92, OBJPROP_XDISTANCE, 20 * count_88);
                        ObjectSet("background" + (string)count_88+ (string)count_92, OBJPROP_YDISTANCE, 23 * count_92 + 9);
                    }
                }
            }
        } else {
            if (vg_initpainel || Seconds() % 5 == 0) {
                vg_initpainel = FALSE;
                for (int count_88= 0; count_88 < 9; count_88++)
                {
                    for (int count_92= 0; count_92 < Li_84; count_92++)
                    {
                        ObjectDelete("background" + (string)count_88+ (string)count_92);
                        ObjectDelete("background" + (string)count_88+ ((string)(count_92 + 1)));
                        ObjectDelete("background" + (string)count_88+ ((string)(count_92 + 2)));

                    }
                }
            }
        }
    }
}


//+------------------------------------------------------------------+
//|           TimeFilter                                     |
//+------------------------------------------------------------------+
bool TimeFilter()
{

    bool _res= false;
    datetime _time_curent= TimeCurrent();
    datetime _time_start = StrToTime(DoubleToStr(Year(), 0) + "." + DoubleToStr(Month(), 0) + "." + DoubleToStr(Day(), 0) + " " + InpStartHour);
    datetime _time_stop= StrToTime(DoubleToStr(Year(), 0) + "." + DoubleToStr(Month(), 0) + "." + DoubleToStr(Day(), 0) + " " + InpEndHour);
    if (((InpTrade_in_Monday == true) && (TimeDayOfWeek(Time[0]) == 1)) ||
        ((InpTrade_in_Tuesday == true) && (TimeDayOfWeek(Time[0]) == 2)) ||
        ((InpTrade_in_Wednesday == true) && (TimeDayOfWeek(Time[0]) == 3)) ||
        ((InpTrade_in_Thursday == true) && (TimeDayOfWeek(Time[0]) == 4)) ||
        ((InpTrade_in_Friday == true) && (TimeDayOfWeek(Time[0]) == 5)))

        if (_time_start > _time_stop) {
            if (_time_curent >= _time_start || _time_curent <= _time_stop) _res = true;
        }
        else
            if (_time_curent >= _time_start && _time_curent <= _time_stop) _res = true;

    return (_res);

}

//+------------------------------------------------------------------+
//|            Function to check if it is news time                                     |
//+------------------------------------------------------------------+
void NewsHandling()
{
   static int PrevMinute= -1;

    if (Minute() != PrevMinute) {
        PrevMinute = Minute();

        // Use this call to get ONLY impact of previous event
        int impactOfPrevEvent=
            (int)iCustom(NULL, 0, "FFCal", true, true, false, true, true, 2, 0);

        // Use this call to get ONLY impact of nexy event
        int impactOfNextEvent=
            (int)iCustom(NULL, 0, "FFCal", true, true, false, true, true, 2, 1);

        int minutesSincePrevEvent=
            (int)iCustom(NULL, 0, "FFCal", true, true, false, true, false, 1, 0);

        int minutesUntilNextEvent=
            (int)iCustom(NULL, 0, "FFCal", true, true, false, true, false, 1, 1);

        vg_news_time = false;
        if ((minutesUntilNextEvent <= InpMinsBeforeNews) ||
            (minutesSincePrevEvent <= InpMinsAfterNews)) {
            vg_news_time = true;
        }
    }
}



//+------------------------------------------------------------------+
//|           CalculateProfit                                   |
//+------------------------------------------------------------------+
double CalculateProfit(int InpMagic, int InpMagic2, int InpMagic3 )
{
    double ld_ret_0= 0;
    for (int g_pos_344= OrdersTotal() - 1; g_pos_344 >= 0; g_pos_344--)
    {
        if (!OrderSelect(g_pos_344, SELECT_BY_POS, MODE_TRADES)) { continue; }
        if (OrderSymbol() != Symbol() || (OrderMagicNumber() != InpMagic && OrderMagicNumber() != InpMagic2 && OrderMagicNumber() != InpMagic3)) continue;
        if (OrderSymbol() == Symbol() && (OrderMagicNumber() == InpMagic || OrderMagicNumber() == InpMagic2 || OrderMagicNumber() == InpMagic3))
            if (OrderType() == OP_BUY || OrderType() == OP_SELL) ld_ret_0 += OrderProfit();
    }
    return (ld_ret_0);
}

//+------------------------------------------------------------------+
//|           CloseThisSymbolAll                                   |
//+------------------------------------------------------------------+
void CloseThisSymbolAll(int InpMagic, int InpMagic2, int InpMagic3) {
    for (int trade = OrdersTotal() - 1; trade >= 0; trade--) {
        if (!OrderSelect(trade, SELECT_BY_POS, MODE_TRADES)) { continue; }
        if (OrderSymbol() != Symbol() || (OrderMagicNumber() != InpMagic && OrderMagicNumber() != InpMagic2 && OrderMagicNumber() != InpMagic3)) continue;
        if (OrderSymbol() == Symbol() && (OrderMagicNumber() == InpMagic || OrderMagicNumber() == InpMagic2 || OrderMagicNumber() == InpMagic3)) {
            if (OrderType() == OP_BUY) OrderClose(OrderTicket(), OrderLots(), Bid, InpSlip, Blue);
            if (OrderType() == OP_SELL) OrderClose(OrderTicket(), OrderLots(), Ask, InpSlip, Red);
        }
        Sleep(1000);

    }
}

double MathRound(double x, double m) { return m * MathRound(x / m); }
double MathFloor(double x, double m) { return m * MathFloor(x / m); }
double MathCeil (double x, double m) { return m * MathCeil(x / m); }


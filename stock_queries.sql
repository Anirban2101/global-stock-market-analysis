-- Q1. Total 10 year return per stock
SELECT Ticker,
       round(first_close, 2) as Buy_Price_2016,
       round(last_close, 2) as Current_Price_2026,
       round((last_close - first_close) / first_close * 100, 2) as TOTAL_RETURN_PCT
FROM (
    SELECT Ticker, 
            first_value(close) over (partition by ticker order by date asc) as first_close, 
		    first_value(close) over (partition by ticker order by date desc) as last_close
	FROM stock_prices
    ) subquery
group by ticker, first_close, last_close
order by TOTAL_RETURN_PCT desc;


-- Q2. Risk adjusted return
SELECT 
    Ticker,
    Market,
    ROUND(AVG(Daily_Return), 4) as Avg_Daily_Return,
    ROUND(AVG(Volatility_30), 4) as Avg_Volatility,
    ROUND(AVG(Daily_Return) / AVG(Volatility_30), 4) as Risk_Adjusted_Return
FROM stock_prices
WHERE Daily_Return IS NOT NULL 
AND Volatility_30 > 0
GROUP BY Ticker, Market
ORDER BY Risk_Adjusted_Return Desc;


-- Q3.  India vs US market head to head
SELECT 
   Market, 
   ROUND(AVG(Daily_Return), 4) as Avg_Daily_Return,
   ROUND(AVG(Volatility_30), 4) as Avg_Volatility,
   COUNT(DISTINCT Ticker) as Total_Stocks
FROM stock_prices
WHERE Daily_Return IS NOT NULL AND Volatility_30 > 0
GROUP BY Market;
       
       
-- Q4. Year by year performance — which year was best and worst
SELECT 
    Market,
    ROUND(AVG(Daily_Return), 4) as Avg_Daily_Return,
    YEAR(Date) as years
FROM stock_prices
WHERE Daily_Return IS NOT NULL
GROUP BY Market, years;


-- Q5. COVID crash analysis — March 2020 specifically
SELECT 
    Ticker,
    Market,
    ROUND(AVG(Daily_Return), 4) as Avg_Daily_Return
FROM stock_prices
WHERE Date BETWEEN '2020-03-01' AND '2020-03-31' 
GROUP BY Ticker, Market
ORDER BY Avg_Daily_Return;


-- Q6.  Post COVID recovery — best recovery stocks April to December 2020
SELECT 
    Ticker,
    Market,
    ROUND(AVG(Daily_Return), 4) as Avg_Daily_Return
FROM stock_prices
WHERE Date BETWEEN '2020-04-01' AND '2020-12-31' 
GROUP BY Ticker, Market
ORDER BY Avg_Daily_Return Desc;


-- Q7. Consistency kings using standard deviation of annual returns
SELECT 
    Ticker,
    Market,
    ROUND(AVG(Yearly_Avg_Return), 4) as Avg_Annual_Return,
    ROUND(STDDEV(Yearly_Avg_Return), 4) as Return_Consistency,
    ROUND(AVG(Yearly_Avg_Return) / STDDEV(Yearly_Avg_Return), 4) as Consistency_Score
FROM (
    SELECT 
       Ticker,
       Market,
       YEAR(Date) as Year,
       AVG(Daily_Return) as Yearly_Avg_Return
   FROM stock_prices
   WHERE Daily_Return IS NOT NULL
   GROUP BY Ticker, Market, YEAR(Date)
   ) as yearly_data
GROUP BY Ticker, Market
ORDER BY Consistency_Score DESC;


-- Q8. Volume surge detection — days when trading volume was 3x the average high
SELECT 
    s.Date,
    s.Ticker,
    s.Market,
    s.Volume,
    ROUND(avg_vol.Avg_Volume, 0) as Normal_Avg_Volume,
    ROUND(s.Volume / avg_vol.Avg_Volume, 2) as Volume_Multiplier
FROM stock_prices s
JOIN (
    SELECT 
        Ticker,
        AVG(Volume) as Avg_Volume
    FROM stock_prices
    GROUP BY Ticker
    ) as avg_vol ON s.Ticker = avg_vol.Ticker
WHERE s.Volume > avg_vol.Avg_Volume * 3
ORDER BY Volume_Multiplier DESC
LIMIT 20;


-- Q9. Rolling 52 week high and low per stock
SELECT 
    w.Ticker,
    w.Market,
    w.High_52_Week,
    w.Low_52_Week,
    cp.Current_Price,
    ROUND((cp.Current_Price - w.Low_52_Week) / (w.High_52_Week - w.Low_52_Week) * 100, 2) as Position_In_Range
FROM (
    SELECT 
	   Ticker,
        Market,
        ROUND(MAX(Close), 2) as High_52_Week,
		ROUND(MIN(Close), 2) as Low_52_Week,
        ROUND(MAX(Close) - MIN(Close), 2) as Price_Difference,
        ROUND((MAX(Close) - MIN(Close)) / MIN(Close) * 100, 2) as Difference_Pct
	FROM stock_prices
    WHERE Date >= DATE_SUB(CURDATE(), INTERVAL 52 WEEK)
    GROUP BY Ticker,Market
    ORDER BY Difference_Pct DESC
) as w
JOIN (
    SELECT Ticker, ROUND(Close, 2) as Current_Price
    FROM stock_prices
    WHERE Date = (SELECT MAX(Date) FROM stock_prices)
    ) as cp ON w.Ticker = cp.Ticker
ORDER BY Position_In_Range DESC;


-- Q10. Portfolio simulation — equal weighted India vs US portfolio comparison
SELECT 
    Market,
    ROUND(SUM(10000 / first_price * last_price), 2) as Portfolio_Value,
    ROUND(SUM(10000 / first_price * last_price) - 100000, 2) as Total_Profit,
    ROUND((SUM(10000 / first_price * last_psrice) - 100000) / 100000 * 100, 2) as Return_Pct
FROM (
    SELECT DISTINCT Ticker, Market, first_price, last_price
    FROM (
        SELECT 
            Ticker,
            Market,
            FIRST_VALUE(Close) OVER (PARTITION BY Ticker ORDER BY Date ASC) as first_price,
            FIRST_VALUE(Close) OVER (PARTITION BY Ticker ORDER BY Date DESC) as last_price
        FROM stock_prices
    ) as all_rows
) as prices
GROUP BY Market;
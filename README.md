### 📈 Global Stock Market Intelligence — 10-Year Multi-Market Analysis

## "If you had invested ₹1,00,000 in Indian stocks vs US stocks in 2016 — which portfolio would be worth more today?"
A complete end-to-end data analytics project analyzing 20 global stocks across Indian (NSE) and US (NYSE/NASDAQ) markets over 10 years. Unlike typical portfolio projects, data was collected live and programmatically from Yahoo Finance's data feed using Python — the same way real financial data pipelines work in industry.

## 🗂️ Dataset
Source: Yahoo Finance live data feed via yfinance Python library — not a static CSV download
Stocks: 10 Indian (NSE) + 10 US (NYSE/NASDAQ) — NVDA, AAPL, TSLA, MSFT, RELIANCE, TCS, BAJFINANCE, ICICIBANK and more
Period: May 2016 — May 2026 (10 years)
Size: 51,860 rows of daily OHLCV data


## 🛠️ Tools Used
Python (yfinance, pandas, matplotlib, seaborn) — live data collection, cleaning, feature engineering, EDA visualizations
MySQL — 10 business SQL queries using window functions, subqueries, CTEs, and statistical functions
Microsoft Excel — pivot tables, AVERAGEIF formulas, conditional formatting
Microsoft Power BI — 4-page interactive dark-themed dashboard with DAX measures

## 💡 Key Business Findings
💰 ₹1,00,000 in US stocks in 2016 → ₹30,88,770 today. Same investment in Indian stocks → ₹4,63,886 — a 6.7x difference over identical time periods
🏆 NVDA delivered 21,716% total return over 10 years, driven by the AI chip supercycle post-2022. WIPRO delivered the lowest at 107%
📉 Indian banks crashed hardest during COVID — BAJFINANCE averaged -2.82% daily in March 2020. HINDUNILVR gained +0.36% the same month — consumer staples demand surged during lockdowns
📊 US and India markets show near-zero correlation (0.07–0.15) — adding Indian stocks to a US portfolio provides genuine diversification benefit, a core principle of global portfolio construction
📅 2022 was the only year US markets went negative (-0.14% avg daily) — driven by Federal Reserve rate hikes. Indian markets stayed positive that year at +0.018%
🎯 ICICIBANK ranks as the most consistent performer when measuring annual return stability — outranking even NVDA which delivers spectacular but highly variable year-to-year returns
🔍 HINDUNILVR traded at 104x its normal volume on May 7, 2020 — detected through SQL volume anomaly analysis, coinciding with exceptional COVID-era quarterly results
📍 AAPL and GOOGL are currently trading at or near their 52-week highs (100% and 97.6% positioning) while several Indian IT stocks sit near yearly lows

## 🖥️ Dashboard Preview
Page 1 — Global Market Overview
<img width="962" height="541" alt="Screenshot 2026-05-20 173811" src="https://github.com/user-attachments/assets/455d0f76-f598-4a52-aa61-7b967b424cdb" />

Page 2 — Stock Performance Intelligence
<img width="962" height="541" alt="Screenshot 2026-05-20 173843" src="https://github.com/user-attachments/assets/8f924478-2e5a-4290-b436-b33a7fa366bb" />

Page 3 — Market Crisis & Recovery Analysis
<img width="960" height="537" alt="Screenshot 2026-05-20 173935" src="https://github.com/user-attachments/assets/f1577522-3992-48d6-8ee7-73ea655fc037" />

Page 4 — Portfolio & Investment Intelligence
<img width="961" height="539" alt="Screenshot 2026-05-20 173957" src="https://github.com/user-attachments/assets/4294d313-65c9-4077-b003-6a77a401f16b" />

## 🗃️ SQL Analysis
Ten business queries covering total return analysis, risk-adjusted returns, India vs US market comparison, year-by-year performance, COVID crash and recovery analysis, consistency ranking, volume anomaly detection, 52-week high/low positioning, and portfolio simulation. See stock_queries.sql for full code.

## ⚙️ How to Run
pip install yfinance pandas matplotlib seaborn sqlalchemy mysql-connector-python
Run stock_analysis.ipynb in Jupyter Notebook — pulls live data, cleans, and loads into MySQL automatically
Run stock_queries.sql in MySQL Workbench
Open stock_analysis_summary.xlsx for Excel summary
Open stock_market_analysis.pbix in Power BI Desktop


Data source — Yahoo Finance via yfinance | Period — May 2016 to May 2026 | Built for portfolio demonstration

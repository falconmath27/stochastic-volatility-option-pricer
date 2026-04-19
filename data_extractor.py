import yfinance as yf

# fetching historical data
ticker = yf.Ticker("ONGC.NS")
data = ticker.history(start="2000-01-03", end = "2009-03-30")

data[['Close']].to_csv('ONGC_prices.csv')
print("ONGC_prices.csv has been saved")
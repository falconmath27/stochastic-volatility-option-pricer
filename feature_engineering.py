import numpy as np
import pandas as pd

input_file = "AAPL_prices.csv"
output_file = "AAPL_features.csv"

data = pd.read_csv(input_file, parse_dates=["Date"])
data = data.sort_values("Date").copy()

# here i am performing for 2 volatilities, 5 days window and 20 days window, along with 5 days and 20 days moving average.
# there are 252 trading days in a year, so annualizing daily volatility by * sqrt(252)
data["Rolling_Volatility_5"] = data["Log_Return"].rolling(5).std() * np.sqrt(252)
data["Rolling_Volatility_20"] = data["Log_Return"].rolling(20).std() * np.sqrt(252)

data["Moving_Average_5"] = data["Close"].rolling(5).mean()
data["Moving_Average_20"] = data["Close"].rolling(20).mean()

data["Volume_Change"] = data["Volume"].pct_change()

data["Momentum_5"] = data["Close"].pct_change(5)

# This is the annualized volatility observed over the next five trading days.
# used as the target in the regression model, i.e. predicting future volatility for 5 days
data["Future_Volatility_5"] = (
    data["Log_Return"].rolling(5).std().shift(-5) * np.sqrt(252)
)

data = data.dropna().reset_index(drop=True)
data.to_csv(output_file, index=False)

print(f"Saved {len(data)} feature rows to {output_file}")
print("Target column: Future_Volatility_5")

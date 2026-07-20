from pathlib import Path

import numpy as np
import yfinance as yf


stock = "AAPL"
stocknm = stock.split('.')[0]
output_file = f"{stocknm}_prices.csv"

# Download the most recent two years so the history aligns with the live
# option-chain data used later in the project.
period = "2y"

cache_dir = Path("data") / "yfinance_cache"
cache_dir.mkdir(parents=True, exist_ok=True)
yf.set_tz_cache_location(str(cache_dir.resolve()))

print(f"Downloading {stocknm} historical data...")
data = yf.download(
    stock,
    period=period,
    interval="1d",
    auto_adjust=False,
    progress=False,
    timeout=30,
)

if data.empty:
    raise RuntimeError(f"Yahoo Finance returned no data for {stocknm}")

# yfinance can return two-level column names even for one ticker.
if getattr(data.columns, "nlevels", 1) > 1:
    data.columns = data.columns.get_level_values(0)

data = data[["Open", "High", "Low", "Close", "Volume"]].copy()

data["Daily_Return"] = data["Close"].pct_change()
data["Log_Return"] = np.log(data["Close"]).diff()

data.to_csv(output_file, index_label="Date")
print(f"{output_file} has been saved ({len(data)} rows)")
print("Columns:", ", ".join(data.columns))

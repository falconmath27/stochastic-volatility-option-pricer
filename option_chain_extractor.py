"""Downloading the current option chain for the same ticker as data_extractor.py."""

from pathlib import Path

import numpy as np
import yfinance as yf

stock = "AAPL"
file_ticker = stock.replace(".", "_")

cache_dir = Path("data") / "yfinance_cache"
cache_dir.mkdir(parents=True, exist_ok=True)
yf.set_tz_cache_location(str(cache_dir.resolve()))

print(f"Downloading option expiries for {stock}...")
ticker = yf.Ticker(stock)
expiries = ticker.options

if not expiries:
    raise RuntimeError(
        f"Yahoo Finance returned no option chain for {stock}. "
        "This ticker may not be supported by Yahoo Finance options data."
    )

# The first expiry is usually the nearest available expiry.
expiry = expiries[0]
chain = ticker.option_chain(expiry)


def prepare_options(options, option_type):
    options = options.copy()
    options["Ticker"] = stock
    options["Expiry"] = expiry
    options["Option_Type"] = option_type
    # Bid-ask midpoint is a better market-price estimate than last trade.
    options["Market_Price"] = np.where(
        (options["bid"] > 0) & (options["ask"] > 0),
        (options["bid"] + options["ask"]) / 2,
        options["lastPrice"],
    )
    return options


calls = prepare_options(chain.calls, "Call")
puts = prepare_options(chain.puts, "Put")

calls_file = f"{file_ticker}_calls_{expiry}.csv"
puts_file = f"{file_ticker}_puts_{expiry}.csv"

calls.to_csv(calls_file, index=False)
puts.to_csv(puts_file, index=False)

print(f"Expiry selected: {expiry}")
print(f"Saved {len(calls)} calls to {calls_file}")
print(f"Saved {len(puts)} puts to {puts_file}")

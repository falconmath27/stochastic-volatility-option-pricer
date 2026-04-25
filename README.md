# Stochastic Volatility Option Pricer

A MATLAB-based option pricing project that combines:

- **EGARCH(1,1)** volatility forecasting from historical returns
- **Crank-Nicolson finite difference** pricing for European put options
- **Greeks visualization** (Delta, Gamma, Theta) across multiple strike prices

The model uses ONGC historical price data and solves a modified Black-Scholes PDE under time-varying volatility.

## Key Features

- Forecasts near-term volatility using an EGARCH model
- Prices European put options for multiple strikes (`K = 20, 22, 24, 26`)
- Generates comparative plots for:
  - Option price vs stock price
  - Delta vs stock price
  - Gamma vs stock price
  - Theta vs stock price

## Project Structure

| File | Purpose |
|---|---|
| `main.m` | Main workflow: data loading, return calculation, volatility forecast, pricing, and plots |
| `forecast_volatility.m` | Fits EGARCH(1,1) model and forecasts volatility for `ndays` |
| `crank_nicolson_pricer.m` | Crank-Nicolson PDE solver for European put option pricing |
| `calculate_greeks.m` | Utility function to compute Delta, Gamma, Theta from PDE output |
| `plot_delta.m` | Plots Delta curves for multiple strikes |
| `plot_gamma.m` | Plots Gamma curves for multiple strikes |
| `plot_theta.m` | Plots Theta curves for multiple strikes |
| `data_extractor.py` | Downloads ONGC historical close prices (`ONGC_prices.csv`) via Yahoo Finance |
| `ONGC_prices.csv` | Historical price dataset used by MATLAB workflow |
| `BKM-B-10-278-dedember.pdf` | Reference document used in the project |

## Requirements

- MATLAB (with Econometrics Toolbox for `egarch`, `estimate`, and `forecast`)
- (Optional) Python 3 + `yfinance` to refresh market data

## How to Run

1. Ensure `ONGC_prices.csv` is in the project root.  
   To regenerate it:
   ```bash
   pip install yfinance
   python data_extractor.py
   ```
2. Open the project in MATLAB.
3. Run:
   ```matlab
   main
   ```
4. The script produces option-pricing and Greeks comparison figures.

## Notes

- Current setup uses:
  - Risk-free rate `r = 0.08`
  - Dividend yield `D = 0.10`
  - Maturity `T = 1/12` (1 month)
  - Forecast horizon `ndays = 30`
- Pricing is implemented for **European put options**.

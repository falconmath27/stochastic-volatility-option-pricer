import numpy as np
import pandas as pd
from arch import arch_model

input_file = "AAPL_prices.csv"
output_file = "AAPL_egarch_forecast.csv"

data = pd.read_csv(input_file, parse_dates=["Date"])
returns = data["Log_Return"].dropna() * 100

model = arch_model(returns, vol="EGARCH", p=1, o=1, q=1, dist="normal")
result = model.fit(disp="off")

# converting percentage-return variance to annualized volatility.
next_day_variance = result.forecast(horizon=1).variance.iloc[-1, 0]
annualized_volatility = np.sqrt(next_day_variance) / 100 * np.sqrt(252)

forecast = pd.DataFrame(
    {
        "Last_Data_Date": [data["Date"].iloc[-1]],
        "Forecast_Horizon": ["1 trading day"],
        "EGARCH_Annualized_Volatility": [annualized_volatility],
    }
)
forecast.to_csv(output_file, index=False)

print(f"Saved EGARCH forecast to {output_file}")
print(f"Next-day annualized volatility: {annualized_volatility:.2%}")

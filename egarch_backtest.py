import numpy as np
import pandas as pd
from arch import arch_model
from sklearn.metrics import mean_absolute_error, mean_squared_error

prices_file = "AAPL_prices.csv"
features_file = "AAPL_features.csv"
predictions_file = "AAPL_egarch_predictions.csv"
metrics_file = "AAPL_egarch_metrics.csv"

prices = pd.read_csv(prices_file, parse_dates=["Date"])
features = pd.read_csv(features_file, parse_dates=["Date"])


split_row = int(len(features) * 0.8)
test = features.iloc[split_row:].copy()

predicted_volatility = []

for test_date in test["Date"]:
    
    returns = prices.loc[prices["Date"] <= test_date, "Log_Return"].dropna() * 100

    model = arch_model(returns, vol="EGARCH", p=1, o=1, q=1, dist="normal")
    result = model.fit(disp="off")

    five_day_variances = result.forecast(
        horizon=5, method="simulation", simulations=1_000
    ).variance.iloc[-1].to_numpy()

    five_day_volatility = np.sqrt(five_day_variances.mean()) / 100 * np.sqrt(252)
    predicted_volatility.append(five_day_volatility)

results = test[["Date", "Future_Volatility_5"]].copy()
results["EGARCH_Predicted_Volatility"] = predicted_volatility
results.to_csv(predictions_file, index=False)

rmse = np.sqrt(mean_squared_error(results["Future_Volatility_5"], predicted_volatility))
mae = mean_absolute_error(results["Future_Volatility_5"], predicted_volatility)
pd.DataFrame({"RMSE": [rmse], "MAE": [mae]}).to_csv(metrics_file, index=False)

print(f"Saved EGARCH predictions to {predictions_file}")
print(f"Saved EGARCH metrics to {metrics_file}")
print(f"RMSE: {rmse:.4f}")
print(f"MAE: {mae:.4f}")

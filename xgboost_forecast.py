import numpy as np
import pandas as pd
from sklearn.metrics import mean_absolute_error, mean_squared_error
from xgboost import XGBRegressor

input_file = "AAPL_features.csv"
predictions_file = "AAPL_xgboost_predictions.csv"
metrics_file = "AAPL_xgboost_metrics.csv"

data = pd.read_csv(input_file, parse_dates=["Date"])
feature_columns = [
    "Log_Return",
    "Rolling_Volatility_5",
    "Rolling_Volatility_20",
    "Moving_Average_5",
    "Moving_Average_20",
    "Volume_Change",
    "Momentum_5",
]
target_column = "Future_Volatility_5"

# Training on older dates and testing on newer dates.
# 80% train , 20% test
split_row = int(len(data) * 0.8)
train = data.iloc[:split_row]
test = data.iloc[split_row:]

model = XGBRegressor(
    n_estimators=200,
    max_depth=3,
    learning_rate=0.05,
    objective="reg:squarederror",
    random_state=42,
)
model.fit(train[feature_columns], train[target_column])

predictions = model.predict(test[feature_columns])
results = test[["Date", target_column]].copy()
results["XGBoost_Predicted_Volatility"] = predictions
results.to_csv(predictions_file, index=False)

rmse = np.sqrt(mean_squared_error(test[target_column], predictions))
mae = mean_absolute_error(test[target_column], predictions)
pd.DataFrame({"RMSE": [rmse], "MAE": [mae]}).to_csv(metrics_file, index=False)

print(f"Saved predictions to {predictions_file}")
print(f"Saved metrics to {metrics_file}")
print(f"RMSE: {rmse:.4f}")
print(f"MAE: {mae:.4f}")

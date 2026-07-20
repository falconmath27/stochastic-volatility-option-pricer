# QuantLab: AI-Powered Option Mispricing Detection Platform

> **A quantitative analytics platform that combines econometric models, machine learning, and option pricing algorithms to identify potentially mispriced options from live market data.**

---

# Problem Statement

Every day, thousands of option contracts are traded across multiple strike prices and expiration dates.

Professional traders and analysts cannot manually evaluate every option to determine whether it is fairly priced relative to current market conditions.

Most traditional option pricing models rely heavily on statistical volatility estimation (such as GARCH/EGARCH). However, financial markets are highly nonlinear, and modern Machine Learning models may provide better volatility forecasts.

This project investigates whether improved volatility forecasting can lead to more accurate theoretical option pricing while providing an automated platform to detect potentially mispriced options.

---

# Project Goal

Develop an end-to-end quantitative analytics platform that can:

- Download live market data
- Forecast future volatility using both econometric and Machine Learning models
- Compute theoretical option prices
- Compare theoretical prices against market prices
- Identify potentially underpriced and overpriced contracts
- Benchmark statistical models against Machine Learning models
- Visualize the complete workflow through an interactive dashboard

---

# Objectives

### Primary Objective

Build an automated system capable of identifying potentially mispriced options using quantitative finance and machine learning techniques.

### Secondary Objectives

- Compare EGARCH and XGBoost for volatility forecasting.
- Study how volatility forecasting impacts downstream option pricing.
- Compare analytical and numerical pricing methods.
- Build a modular software architecture suitable for future research.
- Create an interactive dashboard for visualization.

---

# Research Question

> **Can Machine Learning-based volatility forecasting improve theoretical option pricing compared to traditional econometric models?**

---

# High-Level Workflow

```
                    User

                     │

                     ▼

             Enter Stock Ticker

                     │

                     ▼

          Download Historical Data

                     │

                     ▼

          Download Live Option Chain

                     │

                     ▼

           Feature Engineering

                     │

         ┌───────────┴───────────┐

         ▼                       ▼

      EGARCH                 XGBoost

         │                       │

         └───────────┬───────────┘

                     ▼

         Predicted Volatility

                     │

                     ▼

          Option Pricing Models

         ┌───────────┴───────────┐

         ▼                       ▼

   Black-Scholes         Crank-Nicolson

         │                       │

         └───────────┬───────────┘

                     ▼

      Theoretical Option Price

                     │

                     ▼

     Compare with Market Price

                     │

                     ▼

      Mispricing Detection Engine

                     │

                     ▼

      Rank Mispriced Contracts

                     │

                     ▼

       Interactive Dashboard
```

---

# System Architecture

```
                         Streamlit Dashboard

                                 │

                             FastAPI

                                 │

      ┌──────────────────────────┼──────────────────────────┐

      ▼                          ▼                          ▼

 Market Data              Volatility Engine         Pricing Engine

      │                          │                          │

      ▼                          ▼                          ▼

 yFinance                  EGARCH Model          Black-Scholes

 Option Chain              XGBoost Model         Crank-Nicolson

      │                          │                          │

      └───────────────┬──────────┴───────────────┘

                      ▼

             Mispricing Detector

                      │

                      ▼

          Interactive Visualizations
```

---

# Project Modules

## 1. Market Data Module

Responsible for:

- Historical stock prices
- Live stock price
- Live option chain
- Data preprocessing

Output

```
Historical Prices

Option Chain

Returns
```

---

## 2. Feature Engineering

Generate features for Machine Learning.

Features

- Log Returns
- Daily Returns
- Rolling Volatility
- Moving Average
- Rolling Mean
- Rolling Standard Deviation
- Volume Change
- Momentum

Output

```
Feature Matrix
```

---

## 3. Volatility Forecasting

Two independent forecasting models.

### Statistical Model

- EGARCH(1,1)

### Machine Learning Model

- XGBoost Regressor

Outputs

```
Predicted Annualized Volatility
```

Evaluation Metrics

- RMSE
- MAE
- MAPE

---

## 4. Option Pricing Engine

Implement two pricing methods.

### Analytical

- Black-Scholes

### Numerical

- Crank-Nicolson Finite Difference Method

Outputs

```
Theoretical Option Price
```

---

## 5. Greeks Engine

Compute

- Delta
- Gamma
- Theta
- Vega
- Rho

Visualize their behavior across strike prices.

---

## 6. Mispricing Detection Engine

For every option contract

```
Market Price

↓

Theoretical Price

↓

Pricing Difference

↓

Mispricing Percentage
```

Generate

- Top Underpriced Options
- Top Overpriced Options

---

## 7. Interactive Dashboard

Dashboard Features

### Market Overview

- Historical Price Chart
- Live Stock Price

### Volatility Analysis

- EGARCH Forecast
- XGBoost Forecast
- Comparison Plot

### Option Chain

Display

- Strike
- Expiry
- Market Price
- Model Price
- Difference

### Greeks

Interactive visualization of

- Delta
- Gamma
- Theta
- Vega

### Mispricing Table

Display

- Most Underpriced Contracts
- Most Overpriced Contracts

---

# Tech Stack

## Programming

- Python 3.14

---

## Backend

- FastAPI
- Uvicorn
- Pydantic

---

## Data Processing

- pandas
- NumPy

---

## Numerical Computing

- SciPy

---

## Machine Learning

- XGBoost
- scikit-learn

---

## Econometric Models

- arch

---

## Visualization

- Streamlit
- Plotly

---

## Market Data

- yfinance

---

## Testing

- pytest

---

# Folder Structure

```
quantlab/

│

├── app/
│   ├── api/
│   ├── services/
│   ├── config.py
│   └── main.py
│

├── market_data/
│   ├── downloader.py
│   ├── option_chain.py
│   └── preprocessing.py
│

├── volatility/
│   ├── egarch.py
│   ├── xgboost_model.py
│   ├── feature_engineering.py
│   └── evaluation.py
│

├── pricing/
│   ├── black_scholes.py
│   ├── crank_nicolson.py
│   └── greeks.py
│

├── detector/
│   ├── mispricing.py
│   └── ranking.py
│

├── dashboard/
│   ├── Home.py
│   ├── plots.py
│   └── pages/
│

├── experiments/
│   ├── compare_models.py
│   ├── benchmark.py
│   └── metrics.py
│

├── tests/
│

├── notebooks/
│

├── requirements.txt

├── README.md

└── Dockerfile (Future)
```

---

# Development Roadmap

---

## Phase 1 — Data Pipeline (2–3 Days)

### Goals

- Download historical stock prices
- Download live option chain
- Clean and preprocess data

Deliverable

Reliable market data pipeline.

---

## Phase 2 — Volatility Forecasting (3 Days)

Implement

- EGARCH
- Feature Engineering
- XGBoost

Compare both models using

- RMSE
- MAE
- MAPE

Deliverable

Volatility prediction engine.

---

## Phase 3 — Option Pricing (2 Days)

Implement

- Black-Scholes
- Crank-Nicolson

Validate numerical pricing against analytical pricing.

Deliverable

Pricing engine.

---

## Phase 4 — Greeks & Mispricing (2 Days)

Implement

- Delta
- Gamma
- Theta
- Vega
- Rho

Compare

```
Market Price

vs

Model Price
```

Generate

- Mispricing %
- Ranking

Deliverable

Mispricing detection module.

---

## Phase 5 — Dashboard (2–3 Days)

Develop a Streamlit dashboard to display

- Historical stock prices
- Volatility forecasts
- Pricing comparison
- Greeks
- Mispriced options

Deliverable

Interactive dashboard.

---

## Phase 6 — API (1 Day)

Create REST APIs

```
GET /stock

GET /option-chain

POST /forecast-volatility

POST /price-option

GET /mispricing
```

Deliverable

FastAPI backend.

---

## Phase 7 — Benchmarking & Evaluation (2 Days)

Conduct experiments on multiple stocks.

Suggested Stocks

- AAPL
- MSFT
- NVDA
- GOOGL
- TSLA

Compare

Volatility Models

- EGARCH
- XGBoost

Pricing Models

- Black-Scholes
- Crank-Nicolson

Evaluation Metrics

- RMSE
- MAE
- MAPE
- Pricing Error
- Runtime

Deliverable

Research-style benchmark report.

---

## Phase 8 — Documentation & Testing (1–2 Days)

- Unit Tests
- Project Documentation
- Architecture Diagram
- Results Summary
- Screenshots
- GitHub README

Deliverable

Portfolio-ready project.

---

# Expected Deliverables

- Modular Python codebase
- Live market data pipeline
- EGARCH volatility forecasting
- XGBoost volatility forecasting
- Black-Scholes pricing engine
- Crank-Nicolson pricing engine
- Greeks computation
- Automated mispricing detection
- Interactive Streamlit dashboard
- FastAPI backend
- Experimental benchmarking report
- Clean documentation

---

# Future Work

- Monte Carlo pricing
- American option pricing
- Heston volatility model
- LSTM/Transformer volatility forecasting
- Real-time WebSocket updates
- Docker deployment
- Cloud deployment (AWS/GCP)
- Automated daily market scans
- Alert system for significant mispricing events

---

# Resume Impact

This project demonstrates skills in:

- Quantitative Finance
- Machine Learning
- Numerical Methods
- Scientific Computing
- Backend Development
- Data Engineering
- Software Architecture
- Experimental Evaluation
- API Development
- Interactive Data Visualization

Rather than being a standalone option pricing calculator, **QuantLab** is designed as a modular research and analytics platform that evaluates volatility forecasting techniques and their impact on theoretical option pricing while automatically surfacing potentially mispriced option contracts for further analysis.

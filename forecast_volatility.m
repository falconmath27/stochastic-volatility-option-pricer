function sigma = forecast_voltility(returns, ndays)

try
    Mdl = egarch('GARCHLags', 1 , 'ARCHLags',1 ,'LeverageLags',1);

    % EstMdl is a model , that takes in the returns as input, and
    % calculates the mathematical weights that are alpha, beta, gamma
    EstMdl = estimate(Mdl, returns, 'Display',off);

    % Checking if the estimation was successful
    if isempty(EstMdl)
        error('Model estimation failed. Please check the input data.');
    end

    % Forecasting the volatility for the specified number of days (30)
    vForecast = forecast(EstMdl, ndays, 'Y0', returns);

    % annualizing daily volatility, standard days of trading in india = 252
    sigma = (sqrt(vForecast)/100)*sqrt(252);

catch
    % if EGARCH not available taking constant volatility = 0.4
    warning('Missing! Using fallback constant volatility');
    sigma = repmat(0.4, ndays, 1);
end
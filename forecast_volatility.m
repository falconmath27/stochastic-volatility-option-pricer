function sigma = forecast_volatility(returns, ndays)

    Mdl = egarch('GARCHLags', 1 , 'ARCHLags',1 ,'LeverageLags',1);

    % EstMdl is a model , that takes in the returns as input, and
    % calculates the mathematical weights that are alpha, beta, gamma
    EstMdl = estimate(Mdl, returns, 'Display','off');

    % Checking if the estimation was successful
    if isempty(EstMdl)
        error('Model estimation failed. Please check the input data.');
    end

    % Forecasting the volatility for the specified number of days (30)
    vForecast = forecast(EstMdl, ndays, 'Y0', returns);

    % annualizing daily volatility, standard days of trading in india = 252
    sigma = (sqrt(vForecast)/100);


end
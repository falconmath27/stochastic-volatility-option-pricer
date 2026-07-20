clear; clc; close all;

disp('Loading ONGC Data...');
opts = detectImportOptions('ONGC_prices.csv');
opts.VariableNamingRule = 'preserve'; 
data = readtable('ONGC_prices.csv', opts);

%%%% THE NEXT LINE OF CODES HAVE BEEN PUT TO READ AND CHECK THE DATA

% Force the second column to be numeric, even if it's text
raw_prices = data{:, 2};
if iscell(raw_prices) || isstring(raw_prices) || ischar(raw_prices)
    % Clean up any currency symbols or extra spaces if they exist
    clean_prices = regexprep(string(raw_prices), '[^\d.]', ''); 
    prices = str2double(clean_prices);
else
    prices = raw_prices;
end
if any(isnan(prices))
    error('DATA ERROR: Could not convert prices to numbers. Check your CSV format.');
end


returns = 100 * diff(log(prices));
returns = returns(:);         
returns = rmmissing(returns); % Delete empty rows

fprintf('Successfully loaded %d return data points.\n', length(returns));

disp('Runnings EGARCH model')
ndays = 30;
sigma = forecast_volatility(returns, ndays);

line_styles = {'r:', 'g-.', 'b--', 'k-'}; 
disp('Solving PDE')
K = 20;
r = 0.08;
D = 0.1;
T = [1/12 1/6 1/4 1/3];
Smax = 50;
M = 100;
N = ndays;

disp('plotting the graphs');
figure;

subplot(2,2,1);
hold on;
for i = 1:length(T)
    [V,S] = crank_nicolson_pricer(K,r,D,T(i),Smax,M,N,sigma);
    plot(S, V(:, 1), line_styles{i}, 'LineWidth', 2, 'DisplayName', ['T = ', num2str(360*T(i))]);
end

legend('Location', 'northeast');

xlabel('Stock Price (S)');
ylabel('Option Price (V)');
title('Option Price vs Stock Price for Time');
grid on;
hold off;

% plotting the greeks graph
subplot(2,2,2);
plot_delta(sigma, ndays);
subplot(2,2,3);
plot_gamma(sigma, ndays);
subplot(2,2,4);
plot_theta(sigma, ndays);

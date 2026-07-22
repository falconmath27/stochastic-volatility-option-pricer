function[V,S] = crank_nicolson_pricer(K, r, D, T, Smax, M, N, sigma)
% Inputs:
%   K, r, D, T - Strike, Rate, Dividend, Time to maturity
%   Smax, M, N - Max stock price, price steps, time steps
%   sigma      - Vector of daily forecasted volatilities
% Outputs:
%   V - Matrix of option prices
%   S - Vector of stock price grid points

dS = Smax/M;
dt = T/N;

S = (0:M)' * dS;
V = zeros(M+1, N+1);

% Put payoff
V(:, N+1) = max(K-S, 0);

i = (1:M-1)'; % grid points

for j = N:-1:1
    sig = sigma(j);

    alpha = 0.25 * dt * (sig^2 * i.^2 - (r - D) * i);
    beta  = -0.5 * dt * (sig^2 * i.^2 + r);
    gamma = 0.25 * dt * (sig^2 * i.^2 + (r - D) * i);

    A = diag(1 - beta) + diag(-alpha(2:end), -1) + diag(-gamma(1:end-1), 1);
    X = diag(1 + beta) + diag(alpha(2:end), -1) + diag(gamma(1:end-1), 1);

    %Boundary conditions
    V(1,j) = K * exp(-r * (N + 1 - j) * dt);
    V(M+1,j) = 0;

    % Right-Hand Side
    RHS = X * V(2:M, j+1);
    RHS(1) = RHS(1) + alpha(1) * (V(1, j) + V(1, j+1));
    RHS(end) = RHS(end) + gamma(end) * (V(M+1, j) + V(M+1, j+1));
        
    % Solve system
    V(2:M, j) = A \ RHS;
end
end
function [Delta, Gamma, Theta] = calculate_greeks(V, S, dt)
    dS = S(2) - S(1);
    Delta = (V(3:end, 1) - V(1:end-2, 1)) / (2 * dS);
    Gamma = (V(3:end, 1) - 2*V(2:end-1, 1) + V(1:end-2, 1)) / (dS^2);
    Theta = (V(:, 2) - V(:, 1)) / dt; 
end
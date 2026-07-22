function plot_theta(sigma, ndays)
   
    T = [1/12 1/6 1/4 1/3];
    line_styles = {'r:', 'g-.', 'b--', 'k-'}; 
    r = 0.08; D = 0.10; K = 20;
    Smax = 50; M = 200; N = ndays;
    dt = T/N;
    
    
    hold on;
   
    sigma_val = mean(sigma);
    
    for i = 1:length(T)
        Ti = T(i);
        [V, S] = crank_nicolson_pricer(K, r, D, Ti, Smax, M, N, sigma);
        
        dS = S(2) - S(1);
        Delta = zeros(size(S));
        Gamma = zeros(size(S));
        
        Delta(2:end-1) = (V(3:end, 1) - V(1:end-2, 1)) / (2 * dS);
        Gamma(2:end-1) = (V(3:end, 1) - 2*V(2:end-1, 1) + V(1:end-2, 1)) / (dS^2);
        
        Delta(1) = Delta(2); Delta(end) = Delta(end-1);
        Gamma(1) = Gamma(2); Gamma(end) = Gamma(end-1);
        
        Theta = r .* V(:, 1) - (r - D) .* S .* Delta - 0.5 * sigma_val^2 .* (S.^2) .* Gamma;
        
        plot(S, Theta, line_styles{i}, 'LineWidth', 1.5, ...
            'DisplayName', ['T=', num2str(360*Ti)]);
    end
    xlabel('Stock Price');
    ylabel('Theta');
    title('Theta vs Stock Price for Time');
    legend('show', 'Location', 'best');
    xlim([0 50]); ylim([-8 0.5]); 
     
    box on;                                 
    hold off;
end
function plot_gamma(sigma, ndays)
    
    T = [1/12 1/6 1/4 1/3];
    line_styles = {'r:', 'g-.', 'b--', 'k-'}; 
    r = 0.08; D = 0.10; K = 20;
    Smax = 50; M = 200; N = ndays;
    
    
    hold on;
    
    for i = 1:length(T)
        Ti= T(i);
        [V, S] = crank_nicolson_pricer(K, r, D, Ti, Smax, M, N, sigma);
        
        dS = S(2) - S(1);
        Gamma = (V(3:end, 1) - 2*V(2:end-1, 1) + V(1:end-2, 1)) / (dS^2);
        
        plot(S(2:end-1), Gamma, line_styles{i}, 'LineWidth', 1.5, ...
            'DisplayName', ['T=', num2str(360*Ti)]);
    end
    xlim([0 50]); ylim([-0.02 0.18]); 
    xlabel('Stock Price (S)');
    ylabel('Gamma');
    title('Gamma vs Stock Price for Time');
    legend('show');
    box on;                                 
    hold off;
end
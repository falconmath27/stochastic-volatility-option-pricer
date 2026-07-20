function plot_delta(sigma, ndays)
    T = [1/12 1/6 1/4 1/3];
    line_styles = {'r:', 'g-.', 'b--', 'k-'}; 
    r = 0.08; D = 0.10; K = 20; 
    Smax = 50; M = 200; N = ndays;
    
    hold on;
    for i = 1:length(T)
        Ti = T(i); 
        [V, S] = crank_nicolson_pricer(K, r, D, Ti, Smax, M, N, sigma);
        
        dS = S(2) - S(1);
        Delta = (V(3:end, 1) - V(1:end-2, 1)) / (2 * dS);
        
        plot(S(2:end-1), Delta, line_styles{i}, 'LineWidth', 1.5, 'DisplayName', ['T=', num2str(360*Ti)]);
    end
    xlabel('Stock Price (S)');
    ylabel('Delta');
    title('Delta vs Stock Price for Time');
    legend('show');

      
    box on;
    hold off;
end
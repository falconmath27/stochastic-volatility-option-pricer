function plot_gamma(sigma, ndays)
    
    K_list = [20, 22, 24, 26];
    line_styles = {'r:', 'g-.', 'b--', 'k-'}; 
    r = 0.08; D = 0.10; T = 1/12; 
    Smax = 50; M = 200; N = ndays;
    
    fig = figure('Name', 'Gamma Comparison');
    hold on;
    
    for i = 1:length(K_list)
        K = K_list(i);
        [V, S] = crank_nicolson_pricer(K, r, D, T, Smax, M, N, sigma);
        
        dS = S(2) - S(1);
        Gamma = (V(3:end, 1) - 2*V(2:end-1, 1) + V(1:end-2, 1)) / (dS^2);
        
        plot(S(2:end-1), Gamma, line_styles{i}, 'LineWidth', 1.5, ...
            'DisplayName', ['K=$', num2str(K)]);
    end
    xlim([0 50]); ylim([-0.02 0.18]); 
    xlabel('Stock Price (S)');
    ylabel('Gamma');
    title('Gamma vs Stock Price for Different Strike Prices');
    legend('show');
    box on;                                 
    hold off;
end
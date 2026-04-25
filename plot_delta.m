function plot_delta(sigma, ndays)
    K_list = [20, 22, 24, 26];
    line_styles = {'r:', 'g-.', 'b--', 'k-'}; 
    r = 0.08; D = 0.10; T = 1/12; 
    Smax = 50; M = 200; N = ndays;
    
    
    fig = figure('Name', 'Delta Comparison');
    hold on;
    
    for i = 1:length(K_list)
        K = K_list(i);
        [V, S] = crank_nicolson_pricer(K, r, D, T, Smax, M, N, sigma);
        
        dS = S(2) - S(1);
        Delta = (V(3:end, 1) - V(1:end-2, 1)) / (2 * dS);
        
        plot(S(2:end-1), Delta, line_styles{i}, 'LineWidth', 1.5, 'DisplayName', ['K=$', num2str(K)]);
    end
    xlabel('Stock Price (S)');
    ylabel('Delta');
    title('Delta vs Stock Price for Different Strike Prices');
    legend('show');

      
    box on;                                 
    hold off;
end
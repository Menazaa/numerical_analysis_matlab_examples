% Define symbolic variable
syms x

% --- CONFIGURATION ---
f = sin(x)/x + 0.5*cos(x)*x-0.1*x+3*sin(x)^2;           % The original function
a = 0;                % Expansion point (center)
n_orders = [1, 3, 5, 7, 11, 41, 71]; % Array of orders to compare (n-th degree polynomial)
x_range = [-4*pi, 4*pi]; 
% ---------------------

% Create a figure
figure;
hold on;
grid on;

% Plot the original function using fplot
fplot(f, x_range, 'k', 'LineWidth', 2,'Color', 'white');
legend_entries = {'Original Function'};

% Loop through specified orders and plot each Taylor approximation
colors = lines(length(n_orders)); % Get distinct colors
for i = 1:length(n_orders)
    % Calculate Taylor expansion up to order n+1 to get n-th degree polynomial
    T = taylor(f, x, 'ExpansionPoint', a, 'Order', n_orders(i) + 1);
    
    % Plot the approximation
    fplot(T, x_range, '--', 'Color', colors(i,:), 'LineWidth', 1.5);
    
    % Add to legend list
    legend_entries{end+1} = ['Order ' num2str(n_orders(i))];
end

% Formatting
title(['Taylor Approximation of ', char(f), ' at x = ', num2str(a)]);
xlabel('x');
ylabel('y');
legend(legend_entries, 'Location', 'best');
ylim([-8, 8]); % Adjust based on your function's range
hold off;

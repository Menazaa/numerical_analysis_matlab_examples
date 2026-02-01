x = linspace(-10, 10, 500);
f = x.^2 + 3*x + 2;

figure;
plot(x, f, 'LineWidth', 2);
grid on;
xlabel('x');
ylabel('f(x)');
title('1D Optimization Problem');

figure;
contour(x, y, z, 30);
xlabel('x');
ylabel('y');
title('Optimization Contour Plot');
grid on;

x_path = [-4 -2 -1 -0.5 0];
y_path = [3  2  1  0.3 0];

hold on;
plot(x_path, y_path, 'r-o', 'LineWidth', 2);

A = 10;
[x,y] = meshgrid(linspace(-5.12,5.12,400));
z = 2*A + (x.^2 - A*cos(2*pi*x)) + ...
           (y.^2 - A*cos(2*pi*y));

figure;
surf(x,y,z);
shading interp;
title('Rastrigin Test Function');


x_path = [-4 -2 -1 -0.5 0];
y_path = [3  2  1  0.3 0];

hold on;
plot(x_path, y_path, 'r-o', 'LineWidth', 2);
[x,y] = meshgrid(linspace(-2,2,400));
z = (1-x).^2 + 100*(y - x.^2).^2;

figure;
contour(x,y,z,50);
xlabel('x');
ylabel('y');
title('Rosenbrock Optimization Test Function');

[x, y] = meshgrid(linspace(-5,5,200));
z = x.^2 + y.^2;

figure;
surf(x, y, z);
shading interp;
xlabel('x');
ylabel('y');
zlabel('f(x,y)');
title('2D Optimization Problem');

[x, y] = meshgrid(linspace(-2, 2, 400));
z = (1 - x).^2 + 100 * (y - x.^2).^2;

figure;
surf(x, y, z);
shading interp;
xlabel('x');
ylabel('y');
zlabel('f(x,y)');
title('Rosenbrock Function (3D Surface)');
colorbar;

figure;
surf(x, y, log10(z + 1));
shading interp;
xlabel('x');
ylabel('y');
zlabel('log_{10}(f(x,y)+1)');
title('Rosenbrock Function (Log Scale)');
colorbar;

figure;
mesh(x, y, z);
xlabel('x');
ylabel('y');
zlabel('f(x,y)');
title('Rosenbrock Function (Mesh)');

x_path = [-1.5 -1  -0.5  0  0.5  1];
y_path = [ 2    1.5 1.2  1  1.1  1];

z_path = (1 - x_path).^2 + 100*(y_path - x_path.^2).^2;

figure;
surf(x, y, z);
shading interp;
hold on;
plot3(x_path, y_path, z_path, 'r-o', 'LineWidth', 2);
xlabel('x');
ylabel('y');
zlabel('f(x,y)');
title('Rosenbrock Function with Optimization Path');


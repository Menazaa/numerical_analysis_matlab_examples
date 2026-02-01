clear; clc; close all;

%% =========================================================
%  FUNCTION f : R^2 -> R
% =========================================================
syms x y
f_sym = x^2 + x*y + sin(y);

f = matlabFunction(f_sym);

%% =========================================================
%  EXPANSION POINT x0
% =========================================================
x0 = [1; 0.5];

%% =========================================================
%  GRID AROUND x0
% =========================================================
[xg, yg] = meshgrid(linspace(0.6,1.4,200), ...
                    linspace(0.1,0.9,200));

DX = xg - x0(1);
DY = yg - x0(2);

%% =========================================================
%  TRUE FUNCTION
% =========================================================
F = f(xg, yg);

%% =========================================================
%  HIGHER-ORDER TAYLOR EXPANSIONS
% =========================================================
orders = [1 2 3 4];
T = cell(length(orders),1);

for k = 1:length(orders)
    T_sym = taylor(f_sym, [x y], ...
        'ExpansionPoint', x0.', ...
        'Order', orders(k)+1);

    T_fun = matlabFunction(T_sym);
    T{k} = T_fun(xg, yg);
end

%% =========================================================
%  3D SURFACE VISUALIZATION
% =========================================================
figure('Name','Higher-Order Taylor Approximations');

subplot(2,3,1)
surf(xg, yg, F)
shading interp
title('Original f(x,y)')
xlabel('x'), ylabel('y'), zlabel('f')
grid on

for k = 1:length(orders)
    subplot(2,3,k+1)
    surf(xg, yg, T{k})
    shading interp
    title(sprintf('Taylor order %d', orders(k)))
    xlabel('x'), ylabel('y'), zlabel('T')
    grid on
end

%% =========================================================
%  ERROR SURFACES
% =========================================================
figure('Name','Error Surfaces');

for k = 1:length(orders)
    subplot(2,2,k)
    surf(xg, yg, abs(F - T{k}))
    shading interp
    title(sprintf('|Error|, order %d', orders(k)))
    xlabel('x'), ylabel('y'), zlabel('Error')
    grid on
end

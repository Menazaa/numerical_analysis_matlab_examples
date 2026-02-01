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
%  GRADIENT & HESSIAN
% =========================================================
grad_f = gradient(f_sym, [x y]);
H_f    = hessian(f_sym, [x y]);

grad0 = double(subs(grad_f, [x y], x0.'));
H0    = double(subs(H_f,    [x y], x0.'));
f0    = double(subs(f_sym, [x y], x0.'));

%% =========================================================
%  GRID AROUND x0
% =========================================================
[xg, yg] = meshgrid(linspace(0,2,200), linspace(-0.5,1.5,200));

DX = xg - x0(1);
DY = yg - x0(2);

%% =========================================================
%  TRUE FUNCTION
% =========================================================
F = f(xg, yg);

%% =========================================================
%  FIRST-ORDER TAYLOR (Equation 4.4)
%  f(x0 + δ) ≈ f0 + <∇f(x0), δ>
% =========================================================
T1 = f0 + grad0(1)*DX + grad0(2)*DY;

%% =========================================================
%  SECOND-ORDER TAYLOR (Equation 4.5)
%  f(x0 + δ) ≈ f0 + <∇f(x0), δ> + 1/2 <δ, H δ>
% =========================================================
T2 = f0 ...
   + grad0(1)*DX + grad0(2)*DY ...
   + 0.5 * ( ...
        H0(1,1)*DX.^2 + ...
      2*H0(1,2)*DX.*DY + ...
        H0(2,2)*DY.^2 );

%% =========================================================
%  3D SURFACES
% =========================================================
figure('Name','3D Taylor Approximation');

subplot(1,3,1)
surf(xg, yg, F)
shading interp
title('Original f(x,y)')
xlabel('x'), ylabel('y'), zlabel('f')
grid on

subplot(1,3,2)
surf(xg, yg, T1)
shading interp
title('1st-order Taylor (Tangent Plane)')
xlabel('x'), ylabel('y'), zlabel('T_1')
grid on

subplot(1,3,3)
surf(xg, yg, T2)
shading interp
title('2nd-order Taylor (Quadratic)')
xlabel('x'), ylabel('y'), zlabel('T_2')
grid on

%% =========================================================
%  2D CONTOUR COMPARISON
% =========================================================
figure('Name','Contour Comparison');

subplot(1,2,1)
contour(xg, yg, F, 12, 'LineWidth', 1.5); hold on
contour(xg, yg, T1, 12, '--', 'LineWidth', 1.5)
plot(x0(1), x0(2), 'ro', 'MarkerFaceColor','r')
title('f (solid) vs 1st-order Taylor (dashed)')
xlabel('x'), ylabel('y')
grid on

subplot(1,2,2)
contour(xg, yg, F, 12, 'LineWidth', 1.5); hold on
contour(xg, yg, T2, 12, '--', 'LineWidth', 1.5)
plot(x0(1), x0(2), 'ro', 'MarkerFaceColor','r')
title('f (solid) vs 2nd-order Taylor (dashed)')
xlabel('x'), ylabel('y')
grid on

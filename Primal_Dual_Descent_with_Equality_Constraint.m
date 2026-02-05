clear; clc; close all;

%% =========================================================
%  PROBLEM DEFINITION
% =========================================================
f  = @(x) exp(x(1) + 3*x(2)) + exp(x(1) - x(2)) + exp(-x(1));

grad_f = @(x) [ ...
    exp(x(1)+3*x(2)) + exp(x(1)-x(2)) - exp(-x(1));
    3*exp(x(1)+3*x(2)) - exp(x(1)-x(2)) ];

h = @(x) x(1)^2 + (x(2)+2)^2 - 1;

Jh = @(x) [2*x(1), 2*(x(2)+2)];

Hf = @(x) [ ...
    exp(x(1)+3*x(2)) + exp(x(1)-x(2)) + exp(-x(1)), ...
    3*exp(x(1)+3*x(2)) - exp(x(1)-x(2));
    3*exp(x(1)+3*x(2)) - exp(x(1)-x(2)), ...
    9*exp(x(1)+3*x(2)) + exp(x(1)-x(2)) ];

%% =========================================================
%  INITIALIZATION
% =========================================================
x = [-0.5; -0.5];
beta = 0;

maxIter = 5000;
tol = 1e-8;
eta = 1.0;

Xhist = x;
BetaHist = beta;
rxHist = [];
rbHist = [];

%% =========================================================
%  PRIMAL–DUAL NEWTON ITERATION
% =========================================================
for k = 1:maxIter

    % Residuals (as in the notes)
    rx = grad_f(x) + Jh(x).' * beta;   % dual residual
    rb = h(x);                         % primal residual

    rxHist(end+1) = norm(rx);
    rbHist(end+1) = abs(rb);

    if norm(rx) < tol && abs(rb) < tol
        break;
    end

    % KKT system
    KKT = [Hf(x), Jh(x).'; Jh(x), 0];
    delta = KKT \ (-[rx; rb]);

    % Update
    x     = x + eta * delta(1:2);
    beta = beta + eta * delta(3);

    Xhist(:,end+1) = x;
    BetaHist(end+1) = beta;
end

fprintf('x* = [%.3f, %.3f]\n', x(1), x(2));
fprintf('beta* = %.3f\n', beta);

%% =========================================================
%  2D CONTOUR PLOT
% =========================================================
[x1, x2] = meshgrid(linspace(-2,1,400), linspace(-3,0,400));
F = exp(x1+3*x2) + exp(x1-x2) + exp(-x1);

theta = linspace(0,2*pi,400);
cx = cos(theta);
cy = -2 + sin(theta);

figure;
contour(x1, x2, F, 30); hold on
plot(cx, cy, 'k', 'LineWidth',2)
plot(Xhist(1,:), Xhist(2,:), 'ro-', 'LineWidth',1.5)
xlabel('x_1'); ylabel('x_2')
title('2D Contours with Equality Constraint')
grid on

%% =========================================================
%  3D VISUALIZATION
% =========================================================
figure;
surf(x1, x2, F, 'EdgeColor','none', 'FaceAlpha',0.85)
hold on
shading interp

cz = exp(cx+3*cy) + exp(cx-cy) + exp(-cx);
plot3(cx, cy, cz, 'k', 'LineWidth',3)

traj_z = arrayfun(@(k) f(Xhist(:,k)), 1:size(Xhist,2));
plot3(Xhist(1,:), Xhist(2,:), traj_z, 'ro-', 'LineWidth',2)
plot3(x(1), x(2), f(x), 'gp', 'MarkerSize',14, 'MarkerFaceColor','g')

xlabel('x_1')
ylabel('x_2')
zlabel('f(x)')
title('3D View: Primal–Dual Newton on Constraint Manifold')
view(45,30)
grid on

%% =========================================================
%  RESIDUAL CONVERGENCE
% =========================================================
figure;
semilogy(rxHist,'LineWidth',2); hold on
semilogy(rbHist,'LineWidth',2);
legend('||r_x|| (dual residual)', '|r_\beta| (primal residual)')
xlabel('Iteration')
ylabel('Residual norm')
title('Primal and Dual Residual Convergence')
grid on

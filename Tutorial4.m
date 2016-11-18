clear all; close all; clc;
% define the spatial domain
xlength = 10; % [cm]
% set dimensions of the spatial grid and time step
ni = 50; % index i for columns in grid, corresponds to x direction
dt = 0.1; % [s]
dx = xlength / (ni-1);
% set coefficient of thermal diffusivity
alpha = 0.835; % [cm^2/s]
K = alpha * dt / (dx^2);
X = linspace(0, xlength, ni); % to convert from column to x
% definition of initial and boundary conditions
T_right = 50; % Temperature at right boundary (i=ni)
T_left = 100;  % Temperature at left boundary (i=1)
T_0 = 0; % Initial temperature at internal domain (t=0 / n=1)
% Explicit method loop (Euler) calculations
t_max = 20; % Calculate until t = t_max [s]
t = [0 : dt : t_max];
nn = size(t,2); % number of time steps
T = zeros(nn, ni); % initialise T matrix
T(:,1) = T_left; % boundary values (left)
T(:,ni) = T_right; % boundary values (right)
T(1,2:(ni-1)) = T_0; % initial values (t=0 / n=1)
for n = 1 : (nn-1)
    for i = 2 : (ni-1)
        T(n+1,i) = T(n,i) + K * (T(n,i+1) - 2*T(n,i) + T(n,i-1));
    end
end
% Plot a few profiles at 3, 6, 9 ans 12 s
f = figure(1);
plot(X,T(31,:),'-',X,T(61,:),'-',X,T(91,:),'-',X,T(121,:),'-');
title('Temperatures on a thin rod');
xlabel('x [cm]');
ylabel('T [{\circ}C]');
legend('t = 3s', 't = 6s', 't = 9s', 't = 12s')
% % Plot animation (evolution of plot from 0 to 20s)
% % create and open video object
% vo = VideoWriter('2Dplot_thinRodTemp_expl.avi');
% open(vo);
% % create individual image frames
% f = figure(2);
% for n = 1 : nn
%     plot(X,T(n,:));
%     xlim([0 xlength]);
%     ylim([0 100]);
%     title('Temperatures on a thin rod');
%     xlabel('x [cm]');
%     ylabel('T [{\circ}C]');
%     Time = sprintf('t = %2.1f s', t(n));
%     legend(Time);
% %   % write each frame to the file
%     current = getframe;
%     writeVideo(vo,current);
% end
% close(vo)
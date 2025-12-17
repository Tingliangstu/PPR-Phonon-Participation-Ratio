clear; close all;
tic;
% set up some parameters related to the MD simulation
N =1400 ;   % number of atoms
Nc = 300;   % number of correlation steps (a larger number gives a finer resolution)
dt = 0.005; % time interval in units of ps (its inverse is roughly the maximum frequency attainable)

omega = 1 : 1: 400; % angular frequency in units of THz
nu = omega / 2 / pi; % omega = 2 * pi * nu

% load and rearrange the data
data = load('v_all.mat');  % get data from your output file

%data.v_all(:,1:2,:) = 0;    % out-of-plane

%data1(:,2:3) = 0 ; %in-plane x

%data1(:,3) = 0 ; %in-plane 

v_all = data.v_all;

%Nf = size(data, 1) / N;      % number of frames
%v_all = zeros(N,3 , Nf);     % all the velocity data
%parfor n = 1 : Nf               % put the data into a good form
 %  v_all(:, :, n) = data((n - 1) * N + 1 : n * N, :);
%end

%v_all=reshape(data,[N,3,Nf]);

% call the function
[vacf, pdos] = find_pdos(v_all, Nc, dt, omega);

% plot the results:
figure;
t = (0 : Nc - 1) * dt;
plot(t, vacf, 'b-', 'linewidth', 2);
% xlabel('Correlation Time (ps)', 'fontsize', 15);
ylabel('Normalized VACF', 'fontsize', 15);
set(gca, 'fontsize', 15);

figure;
plot(nu, pdos, 'b-', 'linewidth', 2);
xlabel('nu (THz)', 'fontsize', 15);
ylabel('PDOS', 'fontsize', 15);
set(gca, 'fontsize', 15);

% should be approximately normalized to 0.5
normalization = sum(pdos) * (nu(2) - nu(1));

Area = trapz(nu,pdos);
toc;


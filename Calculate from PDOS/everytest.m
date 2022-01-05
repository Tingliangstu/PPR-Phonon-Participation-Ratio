%% At the beginning
clear; close all;
tic;
%% set up some parameters related to the MD simulation
N =2800 ;   % number of atoms
Nc = 300;   % number of correlation steps (a larger number gives a finer resolution)
dt = 0.005; % time interval in units of ps (its inverse is roughly the maximum frequency attainable)
omega = 1 : 1: 400; % angular frequency in units of THz
nu = omega / 2 / pi; % omega = 2 * pi * nu

%% load and rearrange the data

data = load('v_all.mat');     % get data from your output file

data.v_all(:,1:2,:) = 0;          % out-of-plane PDOS

%data1(:,2:3, :) = 0 ;           % in-plane PDOS

v_all = data.v_all;

%% calculate every atom's POOS

everypdos=zeros(length(omega), N);

parfor idx=1:N
    
         everypdos(:, idx) = find_everypdos(v_all(idx, :, :), Nc, dt, omega);   %compute pdos
        
end
 
%% calculate every atom's part_ratio

part_ratio=zeros(length(omega), 1);
parfor idx=1:length(omega)
        part_ratio(idx)=(sum(everypdos(idx,:).^2))^2/sum(everypdos(idx,:).^4)/N;
end

%% plot the results:

figure;
plot(nu, part_ratio, 'bo', 'linewidth', 2);
ylim([0,1]);
xlabel('nu (THz)', 'fontsize', 15);
ylabel('Participation ratio', 'fontsize', 15);
set(gca, 'fontsize', 15);

%%%% plot ÈýÎ¬Í¼

N_atoms = N ;
len_omega=length(omega);

localization_omega_id=[];
delta_omega=omega(2)-omega(1);

for idx=1:len_omega
    if part_ratio(idx)<0.4
        localization_omega_id = [localization_omega_id; idx];
    end
end

localization_intensity=zeros(1,N_atoms);

for idx=1:N_atoms
    localization_intensity(:, idx)=sum(everypdos(localization_omega_id, idx).*delta_omega);  %»ý·Ö
end

localization_ratio=localization_intensity./(sum(localization_intensity)/N_atoms);


save('localization_ratio.txt','localization_ratio', '-ascii')

toc;

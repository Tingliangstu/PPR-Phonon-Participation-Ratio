function [vacf_output, pdos] = find_pdos(v_all, Nc, dt, omega)
% v_all: all the velocity data in some format
% Nc: number of correlation steps
% dt: time interval between two frames, in units of ps
% omega: phonon angular frequency points you want to consider
Nf = size(v_all, 3);     % number of frames
M = Nf - Nc;             % number of time origins for time average
vacf = zeros(1, Nc);     % the velocity autocorrelation function (VACF)
parfor nc = 0 : Nc - 1      % loop over the correlation steps
   for m = 1 : M         % loop over the time origins
       vacf(nc + 1) = vacf(nc + 1) + sum(sum(v_all(:, :, m + 0) .* v_all(:, :, m + nc)));
   end
end
vacf = vacf / vacf(1);   % normalize the VACF (%vacf=vacf/M;  % you can also normalize it by using [vacf=vacf(1);] if you want)
vacf_output = vacf;      % copy the VACF before modifying it
vacf = vacf .* (cos(pi * (0 : Nc - 1) / Nc) + 1) * 0.5; % window function
vacf = vacf .* [1, 2 * ones(1, Nc - 1)]; % C(t) = C(-t)
pdos = zeros(length(omega), 1); % the phonon density of states (PDOS)
parfor n = 1 : length(omega) % Discrete cosine transform
   pdos(n) = dt * sum(vacf .* cos(omega(n) * (0 : Nc - 1) * dt));
end


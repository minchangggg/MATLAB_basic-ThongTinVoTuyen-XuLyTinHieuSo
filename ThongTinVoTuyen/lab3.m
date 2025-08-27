clc;
clear;

% Parameters
fc = 2000;        % Carrier frequency (MHz)
hb = 70;          % Base station antenna height (m)
hm = 1.5;         % Mobile station antenna height (m)
d = 1:10;         % Distance between transmitter and receiver (km)

% Mobile antenna correction factor for small/medium-sized cities
a_hm_small = (1.1*log10(fc) - 0.7)*hm - (1.56*log10(fc) - 0.8);

% Mobile antenna correction factor for large cities
if fc <= 200
    a_hm_large = 8.29*(log10(1.54*hm))^2 - 1.1;
else
    a_hm_large = 3.2*(log10(11.75*hm))^2 - 4.97;
end

% COST-231 Hata path loss model for small/medium-sized cities
C_small = 0; % Correction factor for small/medium city
PL_small = 46.3 + 33.9*log10(fc) - 13.82*log10(hb) - a_hm_small + ...
           (44.9 - 6.55*log10(hb))*log10(d) + C_small;

% COST-231 Hata path loss model for large cities
C_large = 3; % Correction factor for large city
PL_large = 46.3 + 33.9*log10(fc) - 13.82*log10(hb) - a_hm_large + ...
           (44.9 - 6.55*log10(hb))*log10(d) + C_large;

% Plotting
figure;
plot(log10(d), PL_small, 'b-o','LineWidth',1.5); hold on;
plot(log10(d), PL_large, 'r-s','LineWidth',1.5);
grid on;
xlabel('log_{10}(d) (km)');    % X-axis: log distance
ylabel('Path loss (dB)');     % Y-axis: path loss in dB
title('COST231-Hata Path Loss Model');
legend('Small/Medium City','Large City','Location','best');

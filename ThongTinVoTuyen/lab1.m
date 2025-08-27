% Hata Model Path Loss Simulation
% -------------------------------

% Parameters
f_carrier = 900;          % Carrier frequency (MHz)
h_ms      = 1.5;          % Mobile station antenna height (m)
d_km      = 1;            % Distance between BS and MS (km)
h_bs      = 50:5:200;     % Base station antenna height (m)

% Correction factor for small and large cities
a_hm_small = (1.1*log10(f_carrier) - 0.7) * h_ms - ...
             (1.56*log10(f_carrier) - 0.8);
a_hm_large = 3.2 * (log10(11.75*h_ms)).^2 - 4.97;

% Coefficients A, B, C, D
A_small = 69.55 + 26.16*log10(f_carrier) - 13.82*log10(h_bs) - a_hm_small;
A_large = 69.55 + 26.16*log10(f_carrier) - 13.82*log10(h_bs) - a_hm_large;
B       = 44.9 - 6.55*log10(h_bs);
C       = 5.4 + 2*(log10(f_carrier/28))^2;
D       = 40.94 + 4.78*(log10(f_carrier))^2 - 18.33*log10(f_carrier);

% Path loss calculations (small city)
Lp_urban_small     = A_small + B.*log10(d_km);
Lp_suburban_small  = Lp_urban_small - C;
Lp_open_small      = Lp_urban_small - D;

% Path loss calculations (large city)
Lp_urban_large     = A_large + B.*log10(d_km);
Lp_suburban_large  = Lp_urban_large - C;
Lp_open_large      = Lp_urban_large - D;

% Plot results for small city
figure
plot(h_bs, Lp_urban_small, 'b-', ...
     h_bs, Lp_suburban_small, 'g--', ...
     h_bs, Lp_open_small, 'r:^','LineWidth',1.2)
xlabel('Base Station Height h_{bs} (m)')
ylabel('Path Loss (dB)')
title('Hata Model - Small City')
legend('Urban','Suburban','Open Area','Location','northeast')
grid on

% Plot results for large city
figure
plot(h_bs, Lp_urban_large, 'b-', ...
     h_bs, Lp_suburban_large, 'g--', ...
     h_bs, Lp_open_large, 'r:^','LineWidth',1.2)
xlabel('Base Station Height h_{bs} (m)')
ylabel('Path Loss (dB)')
title('Hata Model - Large City')
legend('Urban','Suburban','Open Area','Location','northeast')
grid on

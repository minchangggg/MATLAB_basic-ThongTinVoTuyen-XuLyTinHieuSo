clc; clear; close all;

% ===== Tham số hệ thống =====
fc_MHz = 900;         % Tần số (MHz)
hb_m   = 50;          % Chiều cao trạm gốc (m)
hm_m   = 1.5;         % Chiều cao trạm di động (m)
dist_km = 1:20;       % Khoảng cách (km)

% ===== Hệ số hiệu chỉnh anten di động =====
% Thành phố vừa/nhỏ
a_hm_small = (1.1*log10(fc_MHz) - 0.7)*hm_m - (1.56*log10(fc_MHz) - 0.8);

% Thành phố lớn
if fc_MHz <= 200
    a_hm_large = 8.29*(log10(1.54*hm_m))^2 - 1.1;
else
    a_hm_large = 3.2*(log10(11.75*hm_m))^2 - 4.97;
end

% ===== Các hằng số phụ =====
C_corr = 5.4 + 2*(log10(fc_MHz/28))^2;  % Suburban correction
D_corr = 40.94 + 4.78*(log10(fc_MHz))^2 - 18.33*log10(fc_MHz); % Open correction
B_term = 44.9 - 6.55*log10(hb_m);

% ===== Công thức suy hao (Hata Model) =====
% Thành phố nhỏ/vừa
A_small = 69.55 + 26.16*log10(fc_MHz) - 13.82*log10(hb_m) - a_hm_small;
PL_small_urban    = A_small + B_term*log10(dist_km);
PL_small_suburban = PL_small_urban - C_corr;
PL_small_open     = PL_small_urban - D_corr;

% Thành phố lớn
A_large = 69.55 + 26.16*log10(fc_MHz) - 13.82*log10(hb_m) - a_hm_large;
PL_large_urban    = A_large + B_term*log10(dist_km);
PL_large_suburban = PL_large_urban - C_corr;
PL_large_open     = PL_large_urban - D_corr;

% ===== Vẽ đồ thị =====
figure;

% Thành phố nhỏ/vừa
subplot(1,2,1);
semilogx(dist_km, PL_small_open, 'r-o', ...
         dist_km, PL_small_suburban, 'b--s', ...
         dist_km, PL_small_urban, 'k-.*', 'LineWidth', 1.5);
grid on;
title('(a) Thành phố vừa/nhỏ (h_b = 50 m)');
xlabel('Khoảng cách d (km) [log_{10} scale]');
ylabel('Suy hao đường truyền (dB)');
legend('Open area','Suburban','Urban','Location','best');

% Thành phố lớn
subplot(1,2,2);
semilogx(dist_km, PL_large_open, 'r-o', ...
         dist_km, PL_large_suburban, 'b--s', ...
         dist_km, PL_large_urban, 'k-.*', 'LineWidth', 1.5);
grid on;
title('(b) Thành phố lớn (h_b = 50 m)');
xlabel('Khoảng cách d (km) [log_{10} scale]');
ylabel('Suy hao đường truyền (dB)');
legend('Open area','Suburban','Urban','Location','best');

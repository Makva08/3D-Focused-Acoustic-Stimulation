% BAR Mode Estimation and Acoustic Transmittance Calculation for 3D-FAST Material Stack
clc;
clear;

% Material Properties
% Lithium Niobate (LiNbO3)
ln_thickness = 50e-6; % thickness in meters
ln_density = 4640; % kg/m^3
ln_acoustic_velocity = 7340; % m/s (longitudinal wave velocity)
ln_piezo_coupling = 0.47; % electromechanical coupling coefficient
Z_ln = ln_density * ln_acoustic_velocity;

% Indium Tin Oxide (ITO)
ito_thickness = 100e-9; % 100 nm
ito_density = 7120; % kg/m^3
ito_acoustic_velocity = 3960; % m/s (approximate value)
Z_ito = ito_density * ito_acoustic_velocity;

% Parylene
parylene_thickness = 1e-6; % 1 µm
parylene_density = 1289; % kg/m^3
parylene_acoustic_velocity = 2350; % m/s (approximate value)
Z_parylene = parylene_density * parylene_acoustic_velocity;

% Air Cavities (Approximated as Air)
air_density = 1.225; % kg/m^3
air_acoustic_velocity = 343; % m/s
Z_air = air_density * air_acoustic_velocity;

% Silicon (Si) Substrate
si_thickness = 500e-6; % 500 µm
si_density = 2330; % kg/m^3
si_acoustic_velocity = 8430; % m/s (longitudinal wave velocity)
Z_si = si_density * si_acoustic_velocity;

% Frequency Range
freq_min = 10e6; % 10 MHz
freq_max = 1e9; % 1 GHz
freq_step = 1e6; % 1 MHz step
frequencies = freq_min:freq_step:freq_max;

% Fundamental Frequencies (Simple BAR Model)
ln_fundamental_freq = ln_acoustic_velocity / (2 * ln_thickness);
si_fundamental_freq = si_acoustic_velocity / (2 * si_thickness);

fprintf('Lithium Niobate Fundamental Frequency: %.2f MHz\n', ln_fundamental_freq / 1e6);
fprintf('Silicon Substrate Fundamental Frequency: %.2f MHz\n', si_fundamental_freq / 1e6);

% Mode Estimation for Multiple Harmonics
harmonics = 1:20;
ln_modes = ln_fundamental_freq * harmonics;
si_modes = si_fundamental_freq * harmonics;

% Plotting Mode Frequencies
figure;
stem(harmonics, ln_modes / 1e6, 'b', 'DisplayName', 'LiNbO3 Modes');
hold on;
stem(harmonics, si_modes / 1e6, 'r', 'DisplayName', 'Silicon Modes');
grid on;
xlabel('Harmonic Number');
ylabel('Frequency (MHz)');
title('Estimated BAR Mode Frequencies for 3D-FAST Material Stack');
legend;

% Acoustic Transmittance Calculation (1D Acoustic Transmission Line Model)
% Assuming normal incidence, transmittance T = 4*Z1*Z2 / (Z1 + Z2)^2
Z_water = 1.48e6; % Acoustic impedance of water in Rayl

% Transmittance through each layer
T_ln = (4 * Z_ln * Z_water) / (Z_ln + Z_water)^2;
T_ito = (4 * Z_ito * Z_ln) / (Z_ito + Z_ln)^2;
T_parylene = (4 * Z_parylene * Z_ito) / (Z_parylene + Z_ito)^2;
T_si = (4 * Z_si * Z_parylene) / (Z_si + Z_parylene)^2;

total_transmittance = T_ln * T_ito * T_parylene * T_si;

fprintf('Acoustic Transmittance through Material Stack: %.4f\n', total_transmittance);

% Conclusion
disp('BAR mode and acoustic transmittance estimation complete. Frequencies and transmittance displayed.');
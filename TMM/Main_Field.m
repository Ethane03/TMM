%% This file calculates the field profile
%% CLEAR WORKSPACE

clear all; close all; clc;
currentfolder = pwd;
tic;
%% STRUCTURE DEFINITION AND SAMPLING PARAMETERS
% Layer thicknesses (nm)
d = [0,2, 30,250,100,100];

% Corresponding materials
n_structure = ["bk7", "TeO2","SiO2_Unaxis","dye1", "air", "air"];

% Polarization (choose 'S_Polarized' or 'P_Polarized')
polarization = 'S_Polarized';  

% Sampling parameters
meshsize   = 1;             % Step size for mesh (nm)
L          = 1;             % Number of wavelength points
M          = 1;             % Number of angle points
lambda0    = linspace(685, 685, L);   % Wavelength range [nm]
theta_deg  = linspace(60, 60, M);     % Angle range [deg]
name       = 'Structure1';

%% Reflectivity CALCULATION

theta0 = deg2rad(theta_deg);
N = numel(d);

[Rs, Rp, Ts, Tp, Ms, Ds, Mp, Dp, kx, n, beta, P, d, k0] = ...
    ART(d, lambda0, theta0, n_structure);
% Select polarization matrix
if polarization == "S_Polarized"
    DspPol = Ds;
elseif polarization == "P_Polarized"
    DspPol = Dp;
end

% Initialize arrays
EE = [];
nn = [];
dd = [];
dd0 = 0;

%% FIELD DISTRIBUTION THROUGH THE MULTILAYER

for j = 2:N-1
    k_x(j) = sqrt((n(j).*k0).^2 - beta.^2);
    % Forward propagation through layers before j
    Sj = eye(2, 2);
    for t = 1:j-1
        Sj = Sj * squeeze(P(t,:,:,:,:)) * squeeze(DspPol(t,:,:,:,:));
    end
    Sj_prime(j,:,:) = Sj;

    % Backward propagation through layers after j
    Sj = squeeze(DspPol(j,:,:,:,:));
    for t = j+1:N-1
        Sj = Sj * squeeze(P(t,:,:,:,:)) * squeeze(DspPol(t,:,:,:,:));
    end
    Sj_2prime(j,:,:) = Sj;

    % Full scattering matrix for layer j
    TestS(j,:,:) = squeeze(Sj_prime(j,:,:,:,:)) * squeeze(P(j,:,:,:,:)) * squeeze(Sj_2prime(j,:,:,:,:));

    % Electric field inside layer j
    jj0 = 0;
    for jj = 0:meshsize:d(j)
        jj0 = jj0 + 1;

        Nomi = squeeze(Sj_2prime(j,1,1))*exp(-1i*k_x(j)*(d(j)-jj)) + ...
               squeeze(Sj_2prime(j,2,1))*exp(+1i*k_x(j)*(d(j)-jj));

        DeNo = squeeze(Sj_prime(j,1,1))*squeeze(Sj_2prime(j,1,1))*exp(-1i*k_x(j)*d(j)) + ...
               squeeze(Sj_prime(j,1,2))*squeeze(Sj_2prime(j,2,1))*exp(+1i*k_x(j)*d(j));

 
        E22(j,jj0) = Nomi / DeNo;
        EE = [EE, Nomi/DeNo];
        nn = [nn, n(:,:,j)];   % Refractive index per mesh
        dd = [dd, dd0];    % Spatial coordinate (nm)
        dd0 = dd0 + meshsize;
    end

    % Field amplitude metrics
    validIdx = find(E22(j,:));
    E_mean(j) = mean(abs(E22(j,validIdx)));
    E_max(j)  = max(abs(E22(j,validIdx)));
    E_sum(j)  = sum(abs(E22(j,validIdx)));
end

[mx1, indxmx1] = max(E_mean);
[mx2, indxmx2] = max(E_max);

%% FIELD AND INDEX DISTRIBUTION PLOT

ymesh = 1000;
[X, Y] = meshgrid(dd, 0:1/ymesh:1);
[rx, cx] = size(X);

for i = 1:rx
    Z(i,:) = nn;
end

figure
surf(X, Y, abs(Z), 'EdgeColor', 'none', 'LineStyle', 'none');
xlabel('x (nm)', 'FontName', 'Arial', 'FontSize', 16, 'FontWeight', 'bold');
ylabel('Norm. Electric field (a.u.)', 'FontName', 'Arial', 'FontSize', 16, 'FontWeight', 'bold');
xlim tight
ylim tight
view(2)
hold on

E22 = (abs(EE)/mx2);
plot3(dd, E22, 10*ones(cx), 'Color', 'k', 'LineWidth', 2);

set(gca, 'XDir', 'reverse', ...
         'FontName', 'Arial', ...
         'FontSize', 18, ...
         'FontWeight', 'bold', ...
         'LineWidth', 2);
outDir = fullfile(currentfolder, 'Results');
savefig(fullfile(outDir,[name,'Field',polarization,'.fig']))
saveas(gcf,fullfile(outDir,[name,'Field',polarization,'.png']))

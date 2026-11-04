clear all; close all; clc;
currentfolder = pwd;

%% Structure Definition and Sampling Parameters
% Layer thicknesses (in nm) and corresponding refractive indices
d = [0,2, 30,250,100,100];
% Corresponding materials
n_structure = ["bk7", "ge","ag","dye1", "air", "air"];
% Wavelength (nm) and incidence angle (degrees)
L = 451;                               % Number of wavelength points
M = 91;                                % Number of angle points
lambda0   = linspace(400, 850, L);     % Wavelength range [nm]
theta_deg = linspace(0, 90, M);        % Angle range [degrees] 
name = 'Strucutre1';

%% Run simulation and  Compute Reflection and Transmission
theta0    = deg2rad(theta_deg);
tic;
[Rs,Rp,Ts,Tp,Ms,Ds,Mp,Dp,kx,n,beta,P,d,k0] = ART(d,lambda0,theta0,n_structure);
toc;
% Compute Absorptance
As = 1 - Rs - Ts;
Ap = 1 - Rp - Tp;

%% Use existing Results folder
outDir = fullfile(currentfolder, 'Results');
save(fullfile(outDir,[name,'_disp.mat']))
if(L>1 && M>1)
    Plot3D(theta_deg,lambda0,Rs,Rp,Ts,Tp,As,Ap,name,outDir,theta0)
elseif(L>1 && M==1)
    plot2D(lambda0,Rs,Rp,Ts,Tp,As,Ap,'Wavelength (nm)',name,outDir,theta0)
elseif(L==1 && M>1)
    plot2D(theta_deg,Rs,Rp,Ts,Tp,As,Ap,'Angle (°)',name,outDir,theta0)
elseif(L==1 && M==1)
message = sprintf('Rs = %d\nRp = %d\nTs = %d\nTp = %d\nAs = %d\nAp = %d', ...
    Rs,Rp,Ts,Tp,As, Ap);
msgbox(message, 'Parameter Values');
end

function [] = Plot3D(theta_deg,lambda0,Rs,Rp,Ts,Tp,As,Ap,name,outDir,theta0)


%% Combined TE/TM Surf Plots
figure('Color','w','Position',[100 100 1200 800]);

%% TE Reflectance
subplot(3,2,1)
surf(theta_deg, lambda0, Rs, 'EdgeColor','none')
xlabel('Angle (°)','FontName','Helvetica','FontSize',14)
ylabel('Wavelength (nm)','FontName','Helvetica','FontSize',14)
set(gca,'FontSize',12,'FontWeight','bold','YDir','reverse')
view(2); title('TE Reflectance','FontSize',12)
xlim("tight");ylim("tight");
colorbar

%% TM Reflectance
subplot(3,2,2)
surf(theta_deg, lambda0, Rp, 'EdgeColor','none')
xlabel('Angle (°)','FontName','Helvetica','FontSize',14)
ylabel('Wavelength (nm)','FontName','Helvetica','FontSize',14)
set(gca,'FontSize',12,'FontWeight','bold','YDir','reverse')
view(2); title('TM Reflectance','FontSize',12)
xlim("tight");ylim("tight");
colorbar

%% TE Transmittance
subplot(3,2,3)
surf(theta_deg, lambda0, Ts, 'EdgeColor','none')
xlabel('Angle (°)','FontName','Helvetica','FontSize',14)
ylabel('Wavelength (nm)','FontName','Helvetica','FontSize',14)
set(gca,'FontSize',12,'FontWeight','bold','YDir','reverse')
view(2); title('TE Transmittance','FontSize',12)
xlim("tight");ylim("tight");
colorbar

%% TM Transmittance
subplot(3,2,4)
surf(theta_deg, lambda0, Tp, 'EdgeColor','none')
xlabel('Angle (°)','FontName','Helvetica','FontSize',14)
ylabel('Wavelength (nm)','FontName','Helvetica','FontSize',14)
set(gca,'FontSize',12,'FontWeight','bold','YDir','reverse')
view(2); title('TM Transmittance','FontSize',12)
xlim("tight");ylim("tight");
colorbar

%% TE Absorptance
subplot(3,2,5)
surf(theta_deg, lambda0, As, 'EdgeColor','none')
xlabel('Angle (°)','FontName','Helvetica','FontSize',14)
ylabel('Wavelength (nm)','FontName','Helvetica','FontSize',14)
set(gca,'FontSize',12,'FontWeight','bold','YDir','reverse')
view(2); title('TE Absorptance','FontSize',12)
xlim("tight");ylim("tight");
colorbar

%% TM Absorptance
subplot(3,2,6)
surf(theta_deg, lambda0, Ap, 'EdgeColor','none')
xlabel('Angle (°)','FontName','Helvetica','FontSize',14)
ylabel('Wavelength (nm)','FontName','Helvetica','FontSize',14)
set(gca,'FontSize',12,'FontWeight','bold','YDir','reverse')
view(2); title('TM Absorptance','FontSize',12)
colorbar
xlim("tight");ylim("tight");

%% Save Figure
if ~exist(outDir,'dir'), mkdir(outDir); end
savefig(fullfile(outDir,['Surf_TE_TM_R_T_A_',name,'.fig']));
saveas(gcf, fullfile(outDir,['Surf_TE_TM_R_T_A_',name,'.png']));
end

function []=plot2D(theta_lambda0,Rs,Rp,Ts,Tp,As,Ap,x_Axis,name,outDir,theta0)
%% Combined TE/TM R, T, and A (Nature-style)

figure('Color','w','Position',[100 100 900 800]);

%% TE Reflectance
subplot(3,2,1)
plot(theta_lambda0, Rs, 'LineWidth',2,'Color',[0 0.4470 0.7410]); grid on
xlabel('Angle (°)','FontName','Helvetica','FontSize',14)
ylabel('TE Reflectance','FontName','Helvetica','FontSize',14)
ax = gca; ax.FontName='Helvetica'; ax.FontSize=12; ax.LineWidth=1.2;

%% TM Reflectance
subplot(3,2,2)
plot(theta_lambda0, Rp, 'LineWidth',2,'Color',[0.8500 0.3250 0.0980]); grid on
xlabel('Angle (°)','FontName','Helvetica','FontSize',14)
ylabel('TM Reflectance','FontName','Helvetica','FontSize',14)
ax = gca; ax.FontName='Helvetica'; ax.FontSize=12; ax.LineWidth=1.2;

%% TE Transmittance
subplot(3,2,3)
plot(theta_lambda0, Ts, 'LineWidth',2,'Color',[0.4660 0.6740 0.1880]); grid on
xlabel('Angle (°)','FontName','Helvetica','FontSize',14)
ylabel('TE Transmittance','FontName','Helvetica','FontSize',14)
ax = gca; ax.FontName='Helvetica'; ax.FontSize=12; ax.LineWidth=1.2;

%% TM Transmittance
subplot(3,2,4)
plot(theta_lambda0, Tp, 'LineWidth',2,'Color',[0.9290 0.6940 0.1250]); grid on
xlabel('Angle (°)','FontName','Helvetica','FontSize',14)
ylabel('TM Transmittance','FontName','Helvetica','FontSize',14)
ax = gca; ax.FontName='Helvetica'; ax.FontSize=12; ax.LineWidth=1.2;

%% TE Absorptance
subplot(3,2,5)
plot(theta_lambda0, As, 'LineWidth',2,'Color',[0.3010 0.7450 0.9330]); grid on
xlabel('Angle (°)','FontName','Helvetica','FontSize',14)
ylabel('TE Absorptance','FontName','Helvetica','FontSize',14)
ax = gca; ax.FontName='Helvetica'; ax.FontSize=12; ax.LineWidth=1.2;

%% TM Absorptance
subplot(3,2,6)
plot(theta_lambda0, Ap, 'LineWidth',2,'Color',[0.6350 0.0780 0.1840]); grid on
xlabel('Angle (°)','FontName','Helvetica','FontSize',14)
ylabel('TM Absorptance','FontName','Helvetica','FontSize',14)
ax = gca; ax.FontName='Helvetica'; ax.FontSize=12; ax.LineWidth=1.2;

%% Save figure
if ~exist(outDir,'dir'), mkdir(outDir); end
savefig(fullfile(outDir,['TE_TM_R_T_A_',name,'.fig']));
saveas(gcf, fullfile(outDir,['TE_TM_R_T_A_',name,'.png']));

end

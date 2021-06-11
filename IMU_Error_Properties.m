%% IMU Error Properties
% This Script File allows the user to turn on/off certian IMU errors to
% determine their effect on the full INS

%% Toggle Flags On/Off (true/false)

if (P.IMU_prop_flag)
%**************************************************************************
% Accel Constant Errors
P.accel.b_a_FB_flag = false;
P.accel.M_a_flag = false;

% Accel Varying Errors
P.accel.white_noise_accel_flag = true;
P.accel.colored_noise_accel_flag = true;


% Gyro Constant Errors
P.gyro.b_g_FB_flag = false;
P.gyro.M_g_flag = false;
P.gyro.gyro_sens_flag = false;

% Gyro Varying Errors
P.gyro.white_noise_gyro_flag = true;
P.gyro.colored_noise_gyro_flag = true;
%**************************************************************************
end 

%% Load Results from Calibration

load("IMU_Cal_Data/IMU_Cal_Const_Error_Sources.mat")
load("IMU_Cal_Data/IMU_Cal_Varying_Error_Sources.mat")

%% Set Desired IMU Errors

%__________________________________________________________________________
% Set Accel Constant Errors
if (P.accel.b_a_FB_flag == true)
    P.accel.b_a_FB = b_a_FB;
    P.accel.b_a_BS = (2*rand - 1) .* b_a_FB;
else
    P.accel.b_a_FB = zeros(3,1);
    P.accel.b_a_BS = zeros(3,1); 
end

if (P.accel.M_a_flag == true)
    P.accel.M_a = M_a;
else
    P.accel.M_a = zeros(3,3);
end

% Set Accel Varying Errors
if (P.accel.white_noise_accel_flag == true)
    P.accel.sigma_VRW = sigma_VRW;
else
    P.accel.sigma_VRW = zeros(3,1);
end

if (P.accel.colored_noise_accel_flag == true)
    P.accel.BI.sigma_n = sigma_n_accel;
    P.accel.BI.correlation_time = 0.1; % Unknown thus far
else
    P.accel.BI.sigma_n = zeros(3,1);
    P.accel.BI.correlation_time = 0.1;
end

%__________________________________________________________________________
% Set Gyro Constant Errors
if (P.gyro.b_g_FB_flag == true)
    P.gyro.b_g_FB = b_g_FB;
    P.gyro.b_g_BS = (2*rand - 1) .* b_g_FB; 
else
    P.gyro.b_g_FB = zeros(3,1);
    P.gyro.b_g_BS = zeros(3,1); 
end

if (P.gyro.M_g_flag == true)
    P.gyro.M_g = M_g;
else
    P.gyro.M_g = zeros(3,3);
end

if (P.gyro.gyro_sens_flag == true)
    P.gyro.G_g = (pi/180) * 0.05 * eye(3); % VN200 data sheet, Cross-Axis Sensitivity
else
    P.gyro.G_g = zeros(3,3);
end

% Set Gyro Varying Errors
if (P.gyro.white_noise_gyro_flag == true)
    P.gyro.sigma_ARW = sigma_ARW;
else
    P.gyro.sigma_ARW = zeros(3,1);
end

if (P.gyro.colored_noise_gyro_flag == true)
    P.gyro.BI.sigma_n = sigma_n_gyro;
    P.gyro.BI.correlation_time = 0.1; % unknown thus far
else
    P.gyro.BI.sigma_n = zeros(3,1);
    P.gyro.BI.correlation_time = 0.1;
end

%% Clear Uneccessary Variables from the workspace

clear accel_std b_a_FB b_g_FB gyro_std M_a M_g sigma_n_accel sigma_n_gyro
clear accel_VRW gyro_ARW sigma_VRW sigma_ARW
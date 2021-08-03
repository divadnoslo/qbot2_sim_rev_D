%% Monte Carlo Simulation for IMU Error Propagation
% This allows the user to simulate how different IMU errors propagate
% through the Tangential Mechanization

%% Name the Simulation M-File

file_name = 'cIMU_odometry_king_hallway_run';
file_path = [file_name, '_monte_carlo.mat'];

%% Set IMU Error Characteristics

% Add Folders to Path
addpath('IMU_Cal_Data', 'Nav_Functions', ...
        'Plot_Functions', 'Plot_Functions/plot_functions')

% Open Simulink Model
open('qbot2_sim_2020a')

% Load Qbot2 Parameters
init_qbot2_params;

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

% Set IMU Error Caracteristics
P.IMU_prop_flag = false;
IMU_Error_Properties;

% Set plotsim flag
P.plotsim_flag = false;

% Generat Motion Plan
qbot2_motion_plan;

% Aiding Sensor Config
aiding_sensor_config;

%% Define Monte Carlo Parameters

num_runs = 100;

r_x = zeros(num_runs, length(0:P.dt:P.t_end));
r_y = zeros(num_runs, length(0:P.dt:P.t_end));
r_z = zeros(num_runs, length(0:P.dt:P.t_end));
v_x = zeros(num_runs, length(0:P.dt:P.t_end));
v_y = zeros(num_runs, length(0:P.dt:P.t_end));
v_z = zeros(num_runs, length(0:P.dt:P.t_end));
phi = zeros(num_runs, length(0:P.dt:P.t_end));
theta = zeros(num_runs, length(0:P.dt:P.t_end));
psi = zeros(num_runs, length(0:P.dt:P.t_end));

%% ReRun if required -- Begin Simulation

% Begin Loop
for kk = 1 : num_runs
    
    % Start Timer
    tic
    
    % Run Simulation -- plot_sim() in StopFcn commented out!
    rng(kk)
    out = sim('qbot2_sim_2020a');
    
    % Isolate XYZ errors
    if (kk == 1)
        t = out.tout;
    end
    
    % Save Position
    r_x(kk,:) = out.r_t__t_b_est(:,1)';
    r_y(kk,:) = out.r_t__t_b_est(:,2)';
    r_z(kk,:) = out.r_t__t_b_est(:,3)';
    
    % Save Position
    v_x(kk,:) = out.v_t__t_b_est(:,1)';
    v_y(kk,:) = out.v_t__t_b_est(:,2)';
    v_z(kk,:) = out.v_t__t_b_est(:,3)';
    
    % Save Attitude (Euler Angles)
    for ii = 1 : length(t)
        [yaw, pitch, roll] = dcm2ypr(out.C_t__b_est(:,:,ii));
        phi(kk,ii) = roll;
        theta(kk,ii) = pitch;
        psi(kk,ii) = yaw;
    end
    
    % Clear Simulation Output
    clear out
    
    % End Timer
    fprintf('Run #%d of %d \n', kk, num_runs)
    toc
    
end

% Program Stats
beep

%% Save Data

save(file_path, 'num_runs', 't', ...
                'r_x', 'r_y', 'r_z', ...
                'v_x', 'v_y', 'v_z', ...
                'phi', 'theta', 'psi')
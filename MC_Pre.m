%% Monte Carlo Simulation for IMU Error Propagation
% This allows the user to simulate how different IMU errors propagate
% through the Tangential Mechanization

%% Name the Simulation M-File

file_name = 'rest_10min_gyro_cal';
file_path = [file_name, '_monte_carlo.mat'];

%% Set IMU Error Characteristics

% Open Simulink Model
open('qbot2_sim_2020a')

% Load Qbot2 Parameters
init_qbot2_params;

%**************************************************************************
% Accel Constant Errors
P.accel.b_a_FB_flag = false;
P.accel.M_a_flag = false;

% Accel Varying Errors
P.accel.white_noise_accel_flag = false;
P.accel.colored_noise_accel_flag = false;


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

%% Define Monte Carlo Parameters

num_runs = 100;

delta_x = zeros(num_runs, length(0:P.dt:P.t_end));
delta_y = zeros(num_runs, length(0:P.dt:P.t_end));
delta_z = zeros(num_runs, length(0:P.dt:P.t_end));
delta_r = zeros(num_runs, length(0:P.dt:P.t_end));

%% ReRun if required -- Begin Simulation

tic

% Begin Loop
for kk = 1 : num_runs
    
    % Run Simulation -- plot_sim() in StopFcn commented out!
    rng(kk)
    out = sim('qbot2_sim_2020a');
    
    % Isolate the Position Error
    if (kk == 1)
        t = out.tout;
    end
    delta_xyz = out.delta_r_t__t_b.Data';
    
    % Isolate XYZ errors
    delta_x(kk,:) = delta_xyz(1,:);
    delta_y(kk,:) = delta_xyz(2,:);
    delta_z(kk,:) = delta_xyz(3,:);
    
    % Find the magntiude of the position error
    for jj = 1 : length(delta_xyz)
        delta_r(kk,jj) = sqrt(delta_xyz(1,jj)^2 + delta_xyz(2,jj)^2 + delta_xyz(3,jj)^2);
    end
    
    % Clear Simulation Output
    clear out
    
end

% Program Stats
toc
beep

% Collect some stats
end_error = delta_r(:,end);
avg_error = mean(end_error);

sigma_x = zeros(1, length(0:P.dt:P.t_end));
sigma_y = zeros(1, length(0:P.dt:P.t_end));
sigma_z = zeros(1, length(0:P.dt:P.t_end));
for ii = 1 : length(t)
    
    % Std-Dev in X at each time step
    sigma_x(ii) = std(delta_x(:,ii));
    
    % Std-Dev in Y at each time step
    sigma_y(ii) = std(delta_y(:,ii));
    
    % Std-Dev in Z at each time step
    sigma_z(ii) = std(delta_z(:,ii));
    
end

%% Save Data

save(file_path, 't', 'delta_x', 'delta_y', 'delta_z', ...
              'delta_r', 'end_error', 'avg_error', 'num_runs', ...
              'sigma_x', 'sigma_y', 'sigma_z')
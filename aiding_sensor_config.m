%% Aiding Sensor Configuration
% David Olson

% This file allows the user to quickly swap and tweak the different aiding
% sensor configurations being explored. 

% The following options are:
%
%  - (0) No Measurement Update,     
%  - (1) Fake Velocity,             
%  - (2) Fake Attitude Only         
%  - (3) Full Fake Aiding          
%  - (4) Odometry                   
%  - (5) Kinect Aiding Only          
%  - (6) Odometry and Kinect Aiding 


%__________________________________________________________________________
%% Select Aiding Sensor Configuration

% Enter the Number of the desired Aiding Sensor Configuration above
P.aiding_sensor_config = 3;

% Turn On/Off the Complimentary Filter
P.use_comp_filter = false;

% Use Measurements for Kalman Filter Inputs (f_b__i_b, C_t__b, v_t__t_b)
P.use_f_b__i_b_meas = false;
P.use_C_t__b_meas = false;
P.use_v_t__t_b_meas = false;


%__________________________________________________________________________
%% Define All Aiding Sensor Properties

% No Measurement Update
% -- nothing to define

% Fake Velocity Aiding
P.sigma_fake_v = [0.1; 0.1; 0.01];

% Fake Attitude Aiding
P.sigma_fake_psi = [0.01; 0.01; 0.5] * pi/180;

% Odometry 
P.sigma_v_b__t_b_odo = [(P.sigma_odo_d / P.dt)^2; ...  % Variance of Speed in {b} frame
                         0.005^2; ...                  % Assumed Variance of body frame {y} vel, Nonholomonic Constraints
                         0.005^2];                     % Assumed Variance of body frame {z} vel, Nonholomonic Constraints
                     
% Kinect
P.sigma_kinect_euler = [0.45; 0.18; 0.04] * 180/pi; 
% Current Values from Previous Research Paper
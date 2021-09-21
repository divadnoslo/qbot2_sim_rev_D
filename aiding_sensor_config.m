%% Aiding Sensor Configuration
% David Olson

% This file allows the user to quickly swap and tweak the different aiding
% sensor configurations being explored. 

% The following options are:
%
%  - (0) No Measurement Update
%  - (1) Fake Velocity Only          
%  - (2) Fake Attitude Only         
%  - (3) Full Fake Aiding          
%  - (4) Odometry                   
%  - (5) Kinect Aiding Only          
%  - (6) Odometry and Kinect Aiding 


%__________________________________________________________________________
%% Select Aiding Sensor Configuration

% Enter the Number of the desired Aiding Sensor Configuration above
P.aiding_sensor_config = 4;

% Turn On/Off the Complimentary Filter
P.use_comp_filter = true;

% Turn on/off Barometer
P.use_barometer = true;

%__________________________________________________________________________
%% Define All Aiding Sensor Properties

% No Measurement Update
% -- nothing to define

% Fake Velocity Aiding
P.sigma_fake_v = [0.25; 0.25; 0.025];

% Fake Attitude Aiding
P.sigma_fake_psi = [0.1; 0.1; 0.989949493661167] * pi/180;

% Odometry 
P.sigma_v_b__t_b_odo = [(P.sigma_odo_d / P.dt); ...  % Variance of Speed in {b} frame
                         0.03; ...                  % Assumed Variance of body frame {y} vel, Nonholomonic Constraints
                         0.03];                     % Assumed Variance of body frame {z} vel, Nonholomonic Constraints
                     
% Kinect
P.sigma_pitch = 3 * pi/180; % Expected Rocking in the Qbot 2
P.sigma_yaw = 3 * pi/180;
P.sigma_SNHT = [0.05; 1; 1.5] * pi/180;

% Barometer
P.sigma_baro = 0.3;

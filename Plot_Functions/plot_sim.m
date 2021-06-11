function plot_sim(out, P)

% Provides plots of relevant states quickly and easily

%**************************************************************************
%% Plot Flags -- Turn on/off what plots you want to see!

% Plotting PVA Ground Truth________________________________________________
motion_3D_flag = false;
p_truth_flag   = false;
v_truth_flag   = false;
a_truth_flag   = false;

% Plotting PVA Measurements________________________________________________
p_meas_flag = false;
v_meas_flag = false;
a_meas_flag = false;
k_meas_flag = true;

% Plotting IMU Truth & Meas________________________________________________
accel_truth_flag = false;
accel_meas_flag  = false;
gyro_truth_flag  = false;
gyro_meas_flag   = false;
delta_accel_flag = false;
delta_gyro_flag  = false;

% Plotting PVA Errors from Tan Error Mech__________________________________
delta_p_flag = false;
delta_v_flag = false;
delta_a_flag = false;

% Plotting State Estimates for PVA Errors__________________________________
delta_r_t__t_b_est_flag   = false;
delta_v_t__t_b_est_flag   = false;
delta_psi_t__t_b_est_flag = false;

% Plotting Kalman Filtering Tuning Check___________________________________
r_KF_flag   = true;
v_KF_flag   = true;
psi_KF_flag = true;
residuals_flag = true;
meas_flag = true;

% Plotting Truth vs Estimates______________________________________________
r_truth_vs_est_flag   = true;
v_truth_vs_est_flag   = true;
psi_truth_vs_est_flag = true;

% Plotting Fake Aiding Sensor Outputs______________________________________
plot_fake_r = false;
plot_fake_v = false;
plot_fake_a = false;

% Plot Complimentary Filter Output_________________________________________
comp_filt_flag = false;
psd_plot_flag = false;
plot_omega_z_only = false;

%**************************************************************************
%% Plot Ground Truth

plot_truth(motion_3D_flag, p_truth_flag, v_truth_flag, a_truth_flag, out, P)

%% PVA Meas ---------------------------------------------------------------

plot_meas(p_meas_flag, v_meas_flag, a_meas_flag, k_meas_flag, out, P)

%% Plot IMU I/O -----------------------------------------------------------

plot_IMU(accel_truth_flag, accel_meas_flag, ...
                  gyro_truth_flag,  gyro_meas_flag, ...
                  delta_accel_flag, delta_gyro_flag, ...
                  out, P)
              
%% Plot PVA Error ---------------------------------------------------------

plot_error(delta_p_flag, delta_v_flag, delta_a_flag, out, P)

%% Plot State Estimate for PVA Errors--------------------------------------

plot_state_est_error(delta_r_t__t_b_est_flag, delta_v_t__t_b_est_flag, ...
                     delta_psi_t__t_b_est_flag, out, P)
                 
%% Plot Kalman Filter Tuning Check-----------------------------------------

plot_kalman_filter_tuning(r_KF_flag, v_KF_flag, psi_KF_flag, residuals_flag, meas_flag, out, P)
                 
%% Plot Truth vs Estimates-------------------------------------------------

plot_truth_vs_est(r_truth_vs_est_flag, v_truth_vs_est_flag, ...
                                             psi_truth_vs_est_flag, out, P)
                                         
%% Plot Fake Aiding Sensor Outputs

plot_fake(plot_fake_r, plot_fake_v, plot_fake_a, out, P)
                 
%% Plot Complimentary Filter Outputs

plot_comp_filter(comp_filt_flag, psd_plot_flag, plot_omega_z_only, out, P)
function plot_comp_filter(comp_filt_flag, psd_plot_flag, plot_omega_z_only, out, P)


% Isolate the separate angular velocities
w_true = out.w_t__t_b_true.Data;
w_imu = out.w_t__t_b_imu.Data;
w_odo = out.w_t__t_b_odo.Data;
w_comp = out.w_t__t_b_comp.Data;
t = out.tout;

if (comp_filt_flag == true)
    
    % Truth vs. IMU vs. Odo vs. Comp
    figure
    subplot(3,1,1)
    hold on
    plot(t, w_imu(:,1) * 180/pi, 'b')
    plot(t, w_odo(:,1) * 180/pi, 'g')
    plot(t, w_comp(:,1) * 180/pi, 'r')
    plot(t, w_true(:,1) * 180/pi, 'k-')
    title('\omega^t_t_b_,_x')
    ylabel('\circ/s')
    legend('IMU', 'Odo', 'Comp', 'Truth', 'Location', 'Best')
    grid on
    hold off
    subplot(3,1,2)
    hold on
    plot(t, w_imu(:,2) * 180/pi, 'b')
    plot(t, w_odo(:,2) * 180/pi, 'g')
    plot(t, w_comp(:,2) * 180/pi, 'r')
    plot(t, w_true(:,2) * 180/pi, 'k-')
    title('\omega^t_t_b_,_y')
    ylabel('\circ/s')
    % legend('IMU', 'Odo', 'Comp', 'Truth', 'Location', 'Best')
    grid on
    hold off
    subplot(3,1,3)
    hold on
    plot(t, w_imu(:,3) * 180/pi, 'b')
    plot(t, w_odo(:,3) * 180/pi, 'g')
    plot(t, w_comp(:,3) * 180/pi, 'r')
    plot(t, w_true(:,3) * 180/pi, 'k-')
    title('\omega^t_t_b_,_z')
    ylabel('\circ/s')
    % legend('IMU', 'Odo', 'Comp', 'Truth', 'Location', 'Best')
    grid on
    hold off
    
end

% PSD Plots
if (psd_plot_flag == true)
    
    % Isolate Z-Components
    w_imu_z = detrend(w_imu(:,3));
    w_odo_z = detrend(w_odo(:,3));
    w_comp_z = detrend(w_comp(:,3));
    w_error = w_odo_z - w_imu_z;
    
    % Plot PSD via P-Welch
    nfft = floor(2*P.Fs);
    
    % IMU PSD
    figure
    [pxx_imu, f_imu] = pwelch(w_imu_z * 180/pi, 2^4, [], nfft, P.Fs);
    plot(f_imu, sqrt(pxx_imu), 'b')
    str = ['\sigma_\omega = ', num2str(std(w_imu_z * 180/pi)), '\circ/s'];
    title(['\omega_z IMU PSD  ', str])
    xlabel('Frequency (Hz)')
    ylabel('deg/s / sqrt(Hz)')
    %xlim([0.5, 50])
    grid on
    hold off
    
    % Odo PSD
    figure
    [pxx_odo, f_odo] = pwelch(w_odo_z * 180/pi, 2^4, [], nfft, P.Fs);
    plot(f_odo, sqrt(pxx_odo), 'b')
    str = ['\sigma_\omega = ', num2str(std(w_odo_z * 180/pi)), '\circ/s'];
    title(['\omega_z Odo PSD  ', str])
    xlabel('Frequency (Hz)')
    ylabel('deg/s / sqrt(Hz)')
    %xlim([0.5, 50])
    grid on
    hold off
    
    % Error PSD
    figure
    [pxx_error, f_error] = pwelch(w_error * 180/pi, 2^4, [], nfft, P.Fs);
    plot(f_error, sqrt(pxx_error), 'b')
    str = ['\sigma_\omega = ', num2str(std(w_error * 180/pi)), '\circ/s'];
    title(['\delta\omega_z (Odo - IMU) PSD  ', str])
    xlabel('Frequency (Hz)')
    ylabel('deg/s / sqrt(Hz)')
    %xlim([0.5, 50])
    grid on
    hold off
    
    % Comp Filter PSD
    % IMU PSD
    figure
    [pxx_comp, f_comp] = pwelch(w_comp_z * 180/pi, 2^4, [], nfft, P.Fs);
    plot(f_comp, sqrt(pxx_comp), 'b')
    str = ['\sigma_\omega = ', num2str(std(w_comp_z * 180/pi)), '\circ/s'];
    title(['\omega_z Comp PSD  ', str])
    xlabel('Frequency (Hz)')
    ylabel('deg/s / sqrt(Hz)')
    %xlim([0.5, 50])
    grid on
    hold off
    
end

% Plot Omega_z Only
if (plot_omega_z_only == true)
    
    figure
    hold on
    plot(t, w_imu(:,3) * 180/pi, 'b')
    plot(t, w_odo(:,3) * 180/pi, 'g')
    plot(t, w_comp(:,3) * 180/pi, 'r')
    plot(t, w_true(:,3) * 180/pi, 'k-')
    str = ['truth_a_v_g = ', num2str(mean(w_true(:,3) * 180/pi)), ...
           '\circ/s  comp_a_v_g = ', num2str(mean(w_comp(:,3) * 180/pi)), '\circ/s'];
    title(['\omega^t_t_b_,_z   ', str])
    ylabel('\circ/s')
    legend('IMU', 'Odo', 'Comp', 'Truth', 'Location', 'Best')
    grid on
    hold off
    
    figure
    subplot(2,1,1)
    hold on
    plot(t, (w_odo(:,3) - w_imu(:,3)) * 180/pi, 'b')
    str1 = ['E[\omega_z_,_e_r_r_o_r] = ', num2str(mean((w_odo(:,3) - w_imu(:,3)) * 180/pi)), ' \circ/s  '];
    str2 = ['\sigma_\omega = ', num2str(std((w_odo(:,3) - w_imu(:,3)) * 180/pi)), ' \circ/s'];
    title(['\omega_z_,_o_d_o - \omega_z_,_i_m_u   ', str1, str2])
    xlabel('Time (s)')
    ylabel('\circ/s')
    grid on
    hold off
    subplot(2,1,2)
    w_lpf = out.w_t__t_b_lpf.Data(:,3);
    hold on
    plot(t, w_lpf * 180/pi, 'b')
    str1 = ['E[\omega_z_,_l_p_f] = ', num2str(mean(w_lpf * 180/pi)), ' \circ/s  '];
    str2 = ['\sigma_\omega = ', num2str(std(w_lpf * 180/pi)), ' \circ/s'];
    title(['\omega_z_,_l_p_f   ', str1, str2])
    xlabel('Time (s)')
    ylabel('\circ/s')
    grid on
    hold off
end
    
end
function plot_IMU(accel_flag, gyro_flag, ...
    delta_accel_flag, delta_gyro_flag, out, P)
%PLOT_IMU Plots all things related to the IMU including
%   - Accel Truth
%   - Accel Meas
%   - Gyro Truth
%   - Gyro Meas
%   - Error in Accel (Meas - Truth)
%   - Error in Gyro  (Meas - Truth)

% Extract Time
t = out.tout;

%% Plot Accel Meas
if (accel_flag == true)
    
    % Accels:  Specific Force (N)
    figure
    hold on
    subplot(3,1,1)
    plot(t, out.accel_meas(:,1), 'r', t, out.accel_truth(:,1), 'k')
    title('Accel Truth vs. Meas: X-Axis   (f^b_i_b_,_x)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('m/s^2')
    grid on
    
    subplot(3,1,2)
    plot(t, out.accel_meas(:,2), 'g', t, out.accel_truth(:,2), 'k')
    title('Accel Truth vs. Meas: Y-Axis   (f^b_i_b_,_y)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('m/s^2')
    grid on
    
    subplot(3,1,3)
    plot(t, out.accel_meas(:,3), 'b', t, out.accel_truth(:,3), 'k')
    title('Accel Truth vs. Meas: Z-Axis   (f^b_i_b_,_z)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('m/s^2')
    legend('meas', 'truth', 'Location', 'Best')
    grid on
    hold off
    
end

%% Plot Gyro Meas
if (gyro_flag == true)
    
    % Gyros:  Rotation Rates  (deg/s)
    figure
    hold on
    subplot(3,1,1)
    plot(t, out.gyro_meas(:,1) * 180/pi, 'r', ...
         t, out.gyro_truth(:,1) * 180/pi, 'k')
    title('Gyro Truth vs. Meas: X-Axis   (\omega^b_i_b_,_x)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('\circ/s')
    legend('truth', 'meas', 'Location', 'Best')
    grid on
    
    subplot(3,1,2)
    plot(t, out.gyro_meas(:,2) * 180/pi, 'g', ...
         t, out.gyro_truth(:,2) * 180/pi, 'k')
    title('Gyro Truth vs. Meas: Y-Axis   (\omega^b_i_b_,_y)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('\circ/s')
    grid on
    
    subplot(3,1,3)
    plot(t, out.gyro_meas(:,3) * 180/pi, 'b', ...
         t, out.gyro_truth(:,3) * 180/pi, 'k')
    title('Gyro Truth vs. Meas: Z-Axis   (\omega^b_i_b_,_z)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('\circ/s')
    grid on
    
end

%% Plot Delta Accel
if (delta_accel_flag == true)
    
    % delta accel
    figure
    hold on
    subplot(3,1,1)
    plot(t, out.delta_f_b__i_b(:,1), 'r')
    title('Accel Meas Error on X-Axis   (\Deltaf^b_i_b_,_x)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('m/s^2')
    grid on
    subplot(3,1,2)
    plot(t, out.delta_f_b__i_b(:,2), 'g')
    title('Accel Meas Error on Y-Axis   (\Deltaf^b_i_b_,_y)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('m/s^2')
    grid on
    subplot(3,1,3)
    plot(t, out.delta_f_b__i_b(:,3), 'b')
    title('Accel Meas Error on Z-Axis   (\Deltaf^b_i_b_,_z)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('m/s^2')
    grid on
    hold off

end

%% Plot Delta Gyro
if (delta_gyro_flag == true)
    
    % delta gyro
    figure
    hold on
    subplot(3,1,1)
    plot(t, out.delta_w_b__i_b(:,1) * 180/pi, 'r')
    title('Gyro Meas Error on X-Axis   (\Delta\omega^b_i_b_,_x)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('\circ/s')
    grid on
    subplot(3,1,2)
    plot(t, out.delta_w_b__i_b(:,2) * 180/pi, 'g')
    title('Gyro Meas Error on Y-Axis   (\Delta\omega^b_i_b_,_y)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('\circ/s')
    grid on
    subplot(3,1,3)
    plot(t, out.delta_w_b__i_b(:,3) * 180/pi, 'b')
    title('Gyro Meas Error on Z-Axis   (\Delta\omega^b_i_b_,_z)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('\circ/s')
    grid on
    
end

end


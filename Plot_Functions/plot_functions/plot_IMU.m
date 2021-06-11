function plot_IMU(accel_truth_flag, accel_meas_flag, ...
                  gyro_truth_flag,  gyro_meas_flag, ...
                  delta_accel_flag, delta_gyro_flag, ...
                  out, P)
%PLOT_IMU Plots all things related to the IMU including
%   - Accel Truth
%   - Accel Meas
%   - Gyro Truth
%   - Gyro Meas
%   - Error in Accel (Meas - Truth)
%   - Error in Gyro  (Meas - Truth)

% Extract Time
t = out.tout;

%% Plot Accel Truth
if (accel_truth_flag == true)
    
    % Accels:  Specific Force (N)
    figure
    hold on
    subplot(3,1,1)
    plot(t, out.accel_truth.Data(:,1), 'r')
    title('IMU Truth: X-axis specific force')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('Acceleration (m/s^2)')
    grid on
    subplot(3,1,2)
    plot(t, out.accel_truth.Data(:,2), 'g')
    title('IMU Truth: Y-axis specific force')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('Acceleration (m/s^2)')
    grid on
    subplot(3,1,3)
    plot(t, out.accel_truth.Data(:,3), 'b')
    title('IMU Truth: Z-axis specific force')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('Acceleration (m/s^2)')
    grid on
    hold off
    
end

%% Plot Accel Meas
if (accel_meas_flag == true)
    
    % Accels:  Specific Force (N)
    figure
    hold on
    subplot(3,1,1)
    plot(t, out.accel_meas.Data(:,1), 'r')
    title('IMU Meas: X-axis specific force')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('Acceleration (m/s^2)')
    grid on
    subplot(3,1,2)
    plot(t, out.accel_meas.Data(:,2), 'g')
    title('IMU Meas: Y-axis specific force')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('Acceleration (m/s^2)')
    grid on
    subplot(3,1,3)
    plot(t, out.accel_meas.Data(:,3), 'b')
    title('IMU Meas: Z-axis specific force')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('Acceleration (m/s^2)')
    grid on
    hold off
    
end

%% Plot Gyro Truth
if (gyro_truth_flag == true)
    
    % Gyros:  Rotation Rates  (deg/s)
    figure
    hold on
    subplot(3,1,1)
    plot(t, out.gyro_truth.Data(:,1) * 180/pi, 'r')
    title('IMU Truth: X-axis angular velocity')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('Angular Velocity (deg/s)')
    grid on
    subplot(3,1,2)
    plot(t, out.gyro_truth.Data(:,2) * 180/pi, 'g')
    title('IMU Truth: Y-axis angular velocity')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('Angular Velocity (deg/s)')
    grid on
    subplot(3,1,3)
    plot(t, out.gyro_truth.Data(:,3) * 180/pi, 'b')
    title('IMU Truth: Z-axis angular velocity')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('Angular Velocity (deg/s)')
    grid on
    
end

%% Plot Gyro Meas
if (gyro_meas_flag == true)
    
    % Gyros:  Rotation Rates  (deg/s)
    figure
    hold on
    subplot(3,1,1)
    plot(t, out.gyro_meas.Data(:,1) * 180/pi, 'r')
    title('IMU Meas: X-axis angular velocity')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('Angular Velocity (deg/s)')
    grid on
    subplot(3,1,2)
    plot(t, out.gyro_meas.Data(:,2) * 180/pi, 'g')
    title('IMU Meas: Y-axis angular velocity')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('Angular Velocity (deg/s)')
    grid on
    subplot(3,1,3)
    plot(t, out.gyro_meas.Data(:,3) * 180/pi, 'b')
    title('IMU Meas: Z-axis angular velocity')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('Angular Velocity (deg/s)')
    
end

%% Plot Delta Accel
if (delta_accel_flag == true)
    
    % delta accel
    figure
    hold on
    subplot(3,1,1)
    plot(t, out.delta_f_b__i_b.Data(:,1), 'r')
    title('Error in X-Accel:  \deltaf^b_i_b')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('Acceleration (m/s^2)')
    grid on
    subplot(3,1,2)
    plot(t, out.delta_f_b__i_b.Data(:,2), 'g')
    title('Error in Y-Accel:  \deltaf^b_i_b')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('Acceleration (m/s^2)')
    grid on
    subplot(3,1,3)
    plot(t, out.delta_f_b__i_b.Data(:,3), 'b')
    title('Error in Z-Accel:  \deltaf^b_i_b')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('Acceleration (m/s^2)')
    grid on
    hold off

end

%% Plot Delta Gyro
if (delta_gyro_flag == true)
    
    % delta gyro
    figure
    hold on
    subplot(3,1,1)
    plot(t, out.delta_w_b__i_b.Data(:,1) * 180/pi, 'r')
    title('Error in X-Gyro:  \delta\omega^b_i_b')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('Angular Velocity (deg/s)')
    grid on
    subplot(3,1,2)
    plot(t, out.delta_w_b__i_b.Data(:,2) * 180/pi, 'g')
    title('Error in X-Gyro:  \delta\omega^b_i_b')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('Angular Velocity (deg/s)')
    grid on
    subplot(3,1,3)
    plot(t, out.delta_w_b__i_b.Data(:,3) * 180/pi, 'b')
    title('Error in X-Gyro:  \delta\omega^b_i_b')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('Angular Velocity (deg/s)')
    grid on
    
end

end


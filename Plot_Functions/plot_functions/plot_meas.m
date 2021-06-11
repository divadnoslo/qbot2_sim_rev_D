function plot_meas(p_meas_flag, v_meas_flag, a_meas_flag, out, P)
%PLOT_MEAS Plots all things related to PVA measurements (not IMU)
%   - Measured Position
%   - Measured Velocity
%   - Measured Attitude (Euler Angles)

% Extract Time
t = out.tout;

% Extract Variables
[pos, vel, rpy] = extract_PVA(out.P_meas.Data, ...
    out.V_meas.Data, ...
    out.A_meas.Data);

%% Plot Position Measured
if (p_meas_flag == true)
    
    % Position
    figure
    hold on
    plot(t, pos(1,:), 'r', t, pos(2,:), 'g',t, pos(3,:), 'b')
    title('MEAS: Position (m)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('r^t_tb (m)')
    grid on
    legend('r_x (m)', 'r_y (m)', 'r_z (m)', 'Location', 'Best')
    hold off
    
end

%% Plot Velocity Measured
if (v_meas_flag == true)
    
    % Velocity
    figure
    hold on
    plot(t, vel(1,:), 'r', t, vel(2,:), 'g', t, vel(3,:), 'b')
    title('MEAS: Velocity (m/s)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('vel (m/s)')
    grid on
    legend('v_x (m)', 'v_y (m)', 'v_z (m)', 'Location', 'Best')
    hold off
    
end

%% Plot Attitude Measured
if (a_meas_flag == true)
    
    % Attitude (Euler Angles)
    figure
    hold on
    subplot(3,1,1)
    plot(t, rpy(1,:), 'r')
    title('MEAS: Roll')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('\phi (deg)')
    grid on
    subplot(3,1,2)
    plot(t, rpy(2,:), 'g')
    title('MEAS: Pitch')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('\theta (deg)')
    grid on
    subplot(3,1,3)
    plot(t, unwrap(rpy(3,:)), 'b')
    title('MEAS: Yaw')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('\psi (deg)')
    grid on
    hold off
    
end


end


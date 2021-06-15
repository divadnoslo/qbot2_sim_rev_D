function plot_meas(p_meas_flag, v_meas_flag, a_meas_flag, out, P)
% Plots all plots related to Ground Truth, including:
%    - True Position
%    - True Velocity
%    - True Attitude

% Extract Time
t = out.tout;

% Extract PVA
pos = out.P_meas';
vel = out.V_meas';
for ii = 1 : length(t)
    [rpy(3,ii), rpy(2,ii), rpy(1,ii)] = dcm2ypr(out.A_meas(:,:,ii));
end

% Unwrap Yaw
rpy(3,:) = unwrap(rpy(3,:));

% Extract PVA Truth
pos_t = out.P_truth';
vel_t = out.V_truth';
rpy_t = out.A_truth';

% Position Truth Plot______________________________________________________
if (p_meas_flag == true)
    
    % X-Position
    k = 1;
    figure
    hold on
    subplot(3,1,k)
    plot(t, pos_t(k,:), 'k', t, pos(k,:), 'r')
    title('Measurement: r^t_t_b_,_x')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('r^t_t_b_,_x (m)')
%     ylim([min(pos(k,:)) - 0.1*min(pos(k,:)), ...
%           max(pos(k,:)) + 0.1*max(pos(k,:))])
    grid on
    hold off
    
    % Y-Position
    k = 2;
    hold on
    subplot(3,1,k)
    plot(t, pos_t(k,:), 'k', t, pos(k,:), 'g')
    title('Measurement: r^t_t_b_,_y')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('r^t_t_b_,_y (m)')
%     ylim([min(pos(k,:)) - 0.1*min(pos(k,:)), ...
%           max(pos(k,:)) + 0.1*max(pos(k,:))])
    grid on
    hold off
    
    % Z-Position
    k = 3;
    hold on
    subplot(3,1,k)
    plot(t, pos_t(k,:), 'k', t, pos(k,:), 'b')
    title('Measurement: r^t_t_b_,_z')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('r^t_t_b_,_z (m)')
    legend('truth', 'meas', 'Location', 'Best')
%     ylim([min(pos(k,:)) - 0.1*min(pos(k,:)), ...
%           max(pos(k,:)) + 0.1*max(pos(k,:))])
    grid on
    hold off
    
end

% Velocity Truth Plot______________________________________________________
if (v_meas_flag == true)
    
    % X-Velocity
    k = 1;
    figure
    hold on
    subplot(3,1,k)
    plot(t, vel_t(k,:), 'k', t, vel(k,:), 'r')
    title('Measurement: v^t_t_b_,_x')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('v^t_t_b_,_x (m/s)')
%     ylim([min(vel(k,:)) - 0.1*min(vel(k,:)), ...
%           max(vel(k,:)) + 0.1*max(vel(k,:))])
    grid on
    hold off
    
    % Y-Velocity
    k = 2;
    hold on
    subplot(3,1,k)
    plot(t, vel_t(k,:), 'k', t, vel(k,:), 'g')
    title('Measurement: v^t_t_b_,_y')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('v^t_t_b_,_y (m/s)')
%     ylim([min(vel(k,:)) - 0.1*min(vel(k,:)), ...
%           max(vel(k,:)) + 0.1*max(vel(k,:))])
    grid on
    hold off
    
    % Z-Velocity
    k = 3;
    hold on
    subplot(3,1,k)
    plot(t, vel_t(k,:), 'k', t, vel(k,:), 'b')
    title('Measurement: v^t_t_b_,_z')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('v^t_t_b_,_z (m/s)')
%     ylim([min(vel(k,:)) - 0.1*min(vel(k,:)), ...
%           max(vel(k,:)) + 0.1*max(vel(k,:))])
    legend('truth', 'meas', 'Location', 'Best')
    grid on
    hold off
    
end

% Attitude Truth Plot______________________________________________________
if(a_meas_flag == true)
    
    % Roll
    k = 1;
    figure
    hold on
    subplot(3,1,k)
    plot(t, rpy_t(k,:) * 180/pi, 'k', t, rpy(k,:) * 180/pi, 'r')
    title('Measurement: Roll (\phi^t_t_b)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
%     ylim([min(rpy(k,:) * 180/pi) - 0.1*min(rpy(k,:) * 180/pi), ...
%           max(rpy(k,:) * 180/pi) + 0.1*max(rpy(k,:) * 180/pi)])
    ylabel('\phi^t_t_b (\circ)')
    legend('truth', 'meas', 'Location', 'Best')
    grid on
    
    % Pitch
    k = 2;
    subplot(3,1,k)
    plot(t, rpy_t(k,:) * 180/pi, 'k', t, rpy(k,:) * 180/pi, 'g')
    title('Measurement: Pitch (\theta^t_t_b)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('\theta^t_t_b (\circ)')
%     ylim([min(rpy(k,:) * 180/pi) - 0.1*min(rpy(k,:) * 180/pi), ...
%           max(rpy(k,:) * 180/pi) + 0.1*max(rpy(k,:) * 180/pi)])
    grid on
    
    % Yaw
    k = 3;
    subplot(3,1,k)
    plot(t, rpy_t(k,:) * 180/pi, 'k', t, rpy(k,:) * 180/pi, 'b')
    title('Measurement: Yaw (\psi^t_t_b)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('\psi^t_t_b (\circ)')
%     ylim([min(rpy(k,:) * 180/pi) - 0.1*min(rpy(k,:) * 180/pi), ...
%           max(rpy(k,:) * 180/pi) + 0.1*max(rpy(k,:) * 180/pi)])
    grid on
    
end
    

end


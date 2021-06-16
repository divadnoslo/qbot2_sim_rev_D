function plot_truth(p_truth_flag, v_truth_flag, a_truth_flag, w_truth_flag, out, P)
% Plots all plots related to Ground Truth, including:
%    - True Position
%    - True Velocity
%    - True Attitude

% Extract Time
t = out.tout;

% Extract PVA
pos = out.P_truth';
vel = out.V_truth';
rpy = out.A_truth';

% Position Truth Plot______________________________________________________
if (p_truth_flag == true)
    
    % X-Position
    k = 1;
    figure
    hold on
    subplot(3,1,k)
    plot(t, pos(k,:), 'r')
    title('Ground Truth: r^t_t_b_,_x')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('r^t_t_b_,_x (m)')
    ylim([min(pos(k,:)) - 0.1*min(pos(k,:)), ...
          max(pos(k,:)) + 0.1*max(pos(k,:))])
    grid on
    hold off
    
    % Y-Position
    k = 2;
    hold on
    subplot(3,1,k)
    plot(t, pos(k,:), 'g')
    title('Ground Truth: r^t_t_b_,_y')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('r^t_t_b_,_y (m)')
    ylim([min(pos(k,:)) - 0.1*min(pos(k,:)), ...
          max(pos(k,:)) + 0.1*max(pos(k,:))])
    grid on
    hold off
    
    % Z-Position
    k = 3;
    hold on
    subplot(3,1,k)
    plot(t, pos(k,:), 'b')
    title('Ground Truth: r^t_t_b_,_z')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('r^t_t_b_,_z (m)')
%     ylim([min(pos(k,:)) - 0.1*min(pos(k,:)), ...
%           max(pos(k,:)) + 0.1*max(pos(k,:))])
    grid on
    hold off
    
end

% Velocity Truth Plot______________________________________________________
if (v_truth_flag == true)
    
    % X-Velocity
    k = 1;
    figure
    hold on
    subplot(3,1,k)
    plot(t, vel(k,:), 'r')
    title('Ground Truth: v^t_t_b_,_x')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('v^t_t_b_,_x (m/s)')
    ylim([min(vel(k,:)) - 0.1*min(vel(k,:)), ...
          max(vel(k,:)) + 0.1*max(vel(k,:))])
    grid on
    hold off
    
    % Y-Velocity
    k = 2;
    hold on
    subplot(3,1,k)
    plot(t, vel(k,:), 'g')
    title('Ground Truth: v^t_t_b_,_y')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('v^t_t_b_,_y (m/s)')
    ylim([min(vel(k,:)) - 0.1*min(vel(k,:)), ...
          max(vel(k,:)) + 0.1*max(vel(k,:))])
    grid on
    hold off
    
    % Z-Velocity
    k = 3;
    hold on
    subplot(3,1,k)
    plot(t, vel(k,:), 'b')
    title('Ground Truth: v^t_t_b_,_z')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('v^t_t_b_,_z (m/s)')
%     ylim([min(vel(k,:)) - 0.1*min(vel(k,:)), ...
%           max(vel(k,:)) + 0.1*max(vel(k,:))])
    grid on
    hold off
    
end

% Attitude Truth Plot______________________________________________________
if (a_truth_flag == true)
    
    % Roll
    k = 1;
    figure
    hold on
    subplot(3,1,k)
    plot(t, rpy(k,:) * 180/pi, 'r')
    title('Ground Truth: Roll (\phi^t_t_b)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
%     ylim([min(rpy(k,:) * 180/pi) - 0.1*min(rpy(k,:) * 180/pi), ...
%           max(rpy(k,:) * 180/pi) + 0.1*max(rpy(k,:) * 180/pi)])
    ylabel('\phi^t_t_b (\circ)')
    grid on
    
    % Pitch
    k = 2;
    subplot(3,1,k)
    plot(t, rpy(k,:) * 180/pi, 'g')
    title('Ground Truth: Pitch (\theta^t_t_b)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('\theta^t_t_b (\circ)')
%     ylim([min(rpy(k,:) * 180/pi) - 0.1*min(rpy(k,:) * 180/pi), ...
%           max(rpy(k,:) * 180/pi) + 0.1*max(rpy(k,:) * 180/pi)])
    grid on
    
    % Yaw
    k = 3;
    subplot(3,1,k)
    plot(t, rpy(k,:) * 180/pi, 'b')
    title('Ground Truth: Yaw (\psi^t_t_b)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('\psi^t_t_b (\circ)')
    ylim([min(rpy(k,:) * 180/pi) - 0.1*min(rpy(k,:) * 180/pi), ...
          max(rpy(k,:) * 180/pi) + 0.1*max(rpy(k,:) * 180/pi)])
    grid on
    
end
   
% Angular Velocity Truth Plot______________________________________________________
if (w_truth_flag == true)
    
    % Roll
    k = 1;
    figure
    hold on
    subplot(3,1,k)
    plot(t, out.w_t__t_b_true(:,k) * 180/pi, 'r')
    title('Ground Truth: Angular Velocity (\omega^t_t_b_,_x)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
%     ylim([min(rpy(k,:) * 180/pi) - 0.1*min(rpy(k,:) * 180/pi), ...
%           max(rpy(k,:) * 180/pi) + 0.1*max(rpy(k,:) * 180/pi)])
    ylabel('\omega^t_t_b_,_x (\circ/s)')
    grid on
    
    % Pitch
    k = 2;
    subplot(3,1,k)
    plot(t, out.w_t__t_b_true(:,k) * 180/pi, 'g')
    title('Ground Truth: Angular Velocity (\omega^t_t_b_,_y)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('\omega^t_t_b_,_y (\circ/s)')
%     ylim([min(rpy(k,:) * 180/pi) - 0.1*min(rpy(k,:) * 180/pi), ...
%           max(rpy(k,:) * 180/pi) + 0.1*max(rpy(k,:) * 180/pi)])
    grid on
    
    % Yaw
    k = 3;
    subplot(3,1,k)
    plot(t, out.w_t__t_b_true(:,k) * 180/pi, 'b')
    title('Ground Truth: Angular Velocity (\omega^t_t_b_,_z)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('\omega^t_t_b_,_z (\circ/s)')
%     ylim([min(rpy(k,:) * 180/pi) - 0.1*min(rpy(k,:) * 180/pi), ...
%           max(rpy(k,:) * 180/pi) + 0.1*max(rpy(k,:) * 180/pi)])
    grid on
    
end

end


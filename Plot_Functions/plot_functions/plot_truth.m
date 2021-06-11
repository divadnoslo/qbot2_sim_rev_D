function plot_truth(motion_3D_flag, p_truth_flag, v_truth_flag, a_truth_flag, out, P)
% Plots all plots related to Ground Truth, including
%    - 3D Motion Plot
%    - True Position
%    - True Velocity
%    - True Attitude

% Extract Time
t = out.tout;

% Extract Variables
[pos, vel, rpy] = extract_PVA(out.P_truth.Data, ...
    out.V_truth.Data, ...
    out.A_truth.Data);

% 3D Motion Plot___________________________________________________________
if (motion_3D_flag == true)
    
    % 3D Motion Plot
    figure
    hold on
    plot3(pos(1,:), pos(2,:), pos(3,:), 'r', 'LineWidth', 2)
    plot3(pos(1,:), pos(2,:), zeros(1,length(pos(1,:))), 'k')
    plot3(linspace(min(pos(1,:)), max(pos(1,:)), length(pos(1,:))), ...
        zeros(1,length(pos(2,:))), ...
        zeros(1,length(pos(3,:))), 'b', 'LineWidth', 0.5)
    plot3(zeros(1,length(pos(1,:))), ...
        linspace(min(pos(2,:)), max(pos(2,:)), length(pos(2,:))), ...
        zeros(1,length(pos(3,:))), 'b', 'LineWidth', 0.5)
    title('Figure Eight Motion')
    xlabel('X (m)')
    ylabel('Y (m)')
    zlabel('Z (m)')
    grid on
    view(10, 47)
    hold off
    
end

% Position Truth Plot______________________________________________________
if (p_truth_flag == true)
    
    % Position
    figure
    hold on
    plot(t, pos(1,:), 'r', t, pos(2,:), 'g',t, pos(3,:), 'b')
    title('TRUTH: Position (m)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('r^t_tb (m)')
    grid on
    legend('r_x (m)', 'r_y (m)', 'r_z (m)', 'Location', 'Best')
    hold off
    
end

% Velocity Truth Plot______________________________________________________
if (v_truth_flag == true)
    
    % Velocity
    figure
    hold on
    plot(t, vel(1,:), 'r', t, vel(2,:), 'g', t, vel(3,:), 'b')
    title('TRUTH: Velocity (m/s)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('vel (m/s)')
    grid on
    legend('v_x (m)', 'v_y (m)', 'v_z (m)', 'Location', 'Best')
    hold off
    
end

% Attitude Truth Plot______________________________________________________
if(a_truth_flag == true)
    
    % Attitude (Euler Angles)
    figure
    hold on
    subplot(3,1,1)
    plot(t, rpy(1,:), 'r')
    title('TRUTH: Roll')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('\phi (deg)')
    grid on
    subplot(3,1,2)
    plot(t, rpy(2,:), 'g')
    title('TRUTH: Pitch')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('\theta (deg)')
    grid on
    subplot(3,1,3)
    plot(t, rpy(3,:), 'b')
    title('TRUTH: Yaw')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('\psi (deg)')
    grid on
    hold off
    
end
    

end


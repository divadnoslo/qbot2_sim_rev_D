function plot_error(delta_p_flag, delta_v_flag, delta_a_flag, out, P)
%PLOT_ERROR Plots outputs of the Tan Error Mech including
%   - delta p
%   - delta v
%   - delta a

% Extract Time
t = out.tout;

%% Plot delta P
if (delta_p_flag == true)
    
    % Error in Position
    figure
    hold on
    subplot(3,1,1)
    plot(t, out.delta_r_t__t_b.Data(:,1), 'r')
    title('Error in X-Position:  \deltar^t_t_b')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('Position (m)')
    grid on
    subplot(3,1,2)
    plot(t, out.delta_r_t__t_b.Data(:,2), 'g')
    title('Error in Y-Position:  \deltar^t_t_b')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('Position (m)')
    grid on
    subplot(3,1,3)
    plot(t, out.delta_r_t__t_b.Data(:,3), 'b')
    title('Error in Z-Position:  \deltar^t_t_b')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('Position (m)')
    grid on
    
end


%% Plot delta V
if (delta_v_flag == true)
    
    % Error in Velocity
    figure
    hold on
    subplot(3,1,1)
    plot(t, out.delta_v_t__t_b.Data(:,1), 'r')
    title('Error in X-Velocity:  \deltav^t_t_b')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('Velocity (m/s)')
    grid on
    subplot(3,1,2)
    plot(t, out.delta_v_t__t_b.Data(:,2), 'g')
    title('Error in Y-Velocity:  \deltav^t_t_b')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('Velocity (m/s)')
    grid on
    subplot(3,1,3)
    plot(t, out.delta_v_t__t_b.Data(:,3), 'b')
    title('Error in Z-Velocity:  \deltav^t_t_b')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('Velocity (m/s)')
    grid on

end

%% Plot delta A
if (delta_a_flag == true)
    
    % Error in Attitude
    figure
    hold on
    subplot(3,1,1)
    plot(t, out.delta_psi_t__t_b.Data(:,1) * 180, 'r')
    title('Error in Attitude (Roll):  \delta\psi^t_t_b')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('Roll (deg)')
    grid on
    subplot(3,1,2)
    plot(t, out.delta_psi_t__t_b.Data(:,2) * 180, 'g')
    title('Error in Attitude (Pitch):  \delta\psi^t_t_b')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('Pitch (deg)')
    grid on
    subplot(3,1,3)
    plot(t, out.delta_psi_t__t_b.Data(:,3) * 180, 'b')
    title('Error in Attitude (Yaw):  \delta\psi^t_t_b')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('Yaw (deg)')
    grid on

end


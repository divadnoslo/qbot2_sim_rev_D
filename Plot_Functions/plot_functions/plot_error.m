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
    plot(t, out.Delta_r_t__t_b(:,1), 'r')
    title('Tan Error Mech:   (\Deltar^t_t_b_,_x)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('m')
    grid on
    subplot(3,1,2)
    plot(t, out.Delta_r_t__t_b(:,2), 'g')
    title('Tan Error Mech:   (\Deltar^t_t_b_,_y)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('m')
    grid on
    subplot(3,1,3)
    plot(t, out.Delta_r_t__t_b(:,3), 'b')
    title('Tan Error Mech:   (\Deltar^t_t_b_,_z)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('m')
    grid on
    
end


%% Plot delta V
if (delta_v_flag == true)
    
    % Error in Velocity
    figure
    hold on
    subplot(3,1,1)
    plot(t, out.Delta_v_t__t_b(:,1), 'r')
    title('Tan Error Mech:   (\Deltav^t_t_b_,_x)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('m/s')
    grid on
    subplot(3,1,2)
    plot(t, out.Delta_v_t__t_b(:,2), 'g')
    title('Tan Error Mech:   (\Deltav^t_t_b_,_y)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('m/s')
    grid on
    subplot(3,1,3)
    plot(t, out.Delta_v_t__t_b(:,3), 'b')
    title('Tan Error Mech:   (\Deltav^t_t_b_,_z)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('m/s')
    grid on

end

%% Plot delta A
if (delta_a_flag == true)
    
    % Error in Attitude
    figure
    hold on
    subplot(3,1,1)
    plot(t, out.Delta_euler_t__t_b(:,1) * 180, 'r')
    title('Tan Error Mech:   (\Delta\phi^t_t_b)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('\circ')
    grid on
    subplot(3,1,2)
    plot(t, out.Delta_euler_t__t_b(:,2) * 180, 'g')
    title('Tan Error Mech:   (\Delta\theta^t_t_b)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('\circ')
    grid on
    subplot(3,1,3)
    plot(t, out.Delta_euler_t__t_b(:,3) * 180, 'b')
    title('Tan Error Mech:   (\Delta\psi^t_t_b)')
    xlabel('Time (s)')
    xlim([0 P.t_end])
    ylabel('\circ')
    grid on

end


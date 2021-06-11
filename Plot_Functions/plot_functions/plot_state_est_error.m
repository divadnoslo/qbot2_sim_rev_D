function plot_state_est_error(delta_r_t__t_b_est_flag, ...
                              delta_v_t__t_b_est_flag, ...
                              delta_psi_t__t_b_est_flag, out, P)
% Plot the Kalman Filter State Outputs
t = out.tout;

if (delta_r_t__t_b_est_flag == true)
    
    figure
    hold on
    subplot(3,1,1)
    plot(t, out.delta_x_t__t_b_est.Data(:,1), 'r')
    title('\deltar^t_t_b_,_x estimate')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('Position (m)')
    grid on
    subplot(3,1,2)
    plot(t, out.delta_x_t__t_b_est.Data(:,2), 'g')
    title('\deltar^t_t_b_,_y estimate')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('Position (m)')
    grid on
    subplot(3,1,3)
    plot(t, out.delta_x_t__t_b_est.Data(:,3), 'b')
    title('\deltar^t_t_b_,_z estimate')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('Position (m)')
    grid on
    
end

if (delta_v_t__t_b_est_flag == true)
        
    figure
    hold on
    subplot(3,1,1)
    plot(t, out.delta_x_t__t_b_est.Data(:,4), 'r')
    title('\deltav^t_t_b_,_x estimate')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('Velocity (m/s)')
    grid on
    subplot(3,1,2)
    plot(t, out.delta_x_t__t_b_est.Data(:,5), 'g')
    title('\deltav^t_t_b_,_y estimate')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('Velocity (m/s)')
    grid on
    subplot(3,1,3)
    plot(t, out.delta_x_t__t_b_est.Data(:,6), 'b')
    title('\deltav^t_t_b_,_z estimate')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('Velocity (m/s)')
    grid on
    
end


if (delta_psi_t__t_b_est_flag == true)
    
    figure
    hold on
    subplot(3,1,1)
    plot(t, out.delta_x_t__t_b_est.Data(:,7) * 180/pi, 'r')
    title('\delta\psi^t_t_b_,_x estimate')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('Roll (\circ)')
    grid on
    subplot(3,1,2)
    plot(t, out.delta_x_t__t_b_est.Data(:,8) * 180/pi, 'g')
    title('\delta\psi^t_t_b_,_y estimate')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('Pitch (\circ)')
    grid on
    subplot(3,1,3)
    plot(t, out.delta_x_t__t_b_est.Data(:,9) * 180/pi, 'b')
    title('\delta\psi^t_t_b_,_z estimate')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('Yaw (\circ)')
    grid on
    
end


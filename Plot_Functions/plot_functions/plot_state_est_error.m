function plot_state_est_error(delta_r_t__t_b_est_flag, ...
                              delta_v_t__t_b_est_flag, ...
                              delta_psi_t__t_b_est_flag, out, P)
% Plot the Kalman Filter State Outputs
t = out.tout;

if (delta_r_t__t_b_est_flag == true)
    
    figure
    hold on
    subplot(3,1,1)
    plot(t, out.delta_r_t__t_b_est(:,1), 'r')
    title('\deltar^t_t_b_,_x estimate')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('Position (m)')
    grid on
    subplot(3,1,2)
    plot(t, out.delta_r_t__t_b_est(:,2), 'g')
    title('\deltar^t_t_b_,_y estimate')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('Position (m)')
    grid on
    subplot(3,1,3)
    plot(t, out.delta_r_t__t_b_est(:,3), 'b')
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
    plot(t, out.delta_v_t__t_b_est(:,1), 'r')
    title('\deltav^t_t_b_,_x estimate')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('Velocity (m/s)')
    grid on
    subplot(3,1,2)
    plot(t, out.delta_v_t__t_b_est(:,2), 'g')
    title('\deltav^t_t_b_,_y estimate')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('Velocity (m/s)')
    grid on
    subplot(3,1,3)
    plot(t, out.delta_v_t__t_b_est(:,3), 'b')
    title('\deltav^t_t_b_,_z estimate')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('Velocity (m/s)')
    grid on
    
end


if (delta_psi_t__t_b_est_flag == true)
    
    for ii = 1 : length(t)
        [yaw(ii), pitch(ii), roll(ii)] = dcm2ypr(out.delta_C_t__b_est(:,:,ii));
    end
    
    figure
    hold on
    subplot(3,1,1)
    plot(t, roll * 180/pi, 'r')
    title('\delta\phi^t_t_b estimate')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('Roll (\circ)')
    grid on
    subplot(3,1,2)
    plot(t, pitch * 180/pi, 'g')
    title('\delta\theta^t_t_b estimate')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('Pitch (\circ)')
    grid on
    subplot(3,1,3)
    plot(t, yaw * 180/pi, 'b')
    title('\delta\psi^t_t_b estimate')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('Yaw (\circ)')
    grid on
    
end


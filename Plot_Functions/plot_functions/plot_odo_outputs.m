function plot_odo_outputs(plot_wheel_vel, plot_ang_vel_odo, plot_body_speed_odo, plot_C_t__b_comp, plot_tan_speed_odo, out, P)

% Plot Putputs from Odometry as well as the Comp Filter Output

t = out.tout;

%% Plot Odometry Wheel Velocities

if (plot_wheel_vel == true)
    
    figure
    hold on
    plot(t, out.v_l, 'g', t, out.v_r, 'r')
    title('Odometry Wheel Velocities')
    xlabel('Time (s)')
    xlim([0, P.t_end])
    ylabel('m/s')
    legend('v_l', 'v_r', 'Location', 'Best')
    grid on
    hold off
    
end

%% Plot Odometry Angular Velocity Measurements

if (plot_ang_vel_odo == true)
    
    figure
    hold on
    plot(t, out.w_t__t_b_odo(:,3) * 180/pi, 'b') 
    plot(t, out.w_t__t_b_comp(:,3) * 180/pi, 'r')
    plot(t, out.w_t__t_b_true(:,3) * 180/pi, 'k')
    title('\omega_z_,_o_d_o vs. \omega_z_,_t_r_u_t_h')
    xlabel('Time (s)')
    xlim([0, P.t_end])
    ylabel('\circ/s')
    legend('Odo', 'Comp. Filter', 'Truth', 'Location', 'Best')
    grid on
    hold off
    
end

%% Plot Odometry Angular Velocity Measurements

if (plot_body_speed_odo == true)
    
    for k = 1 : length(t)
        body_speed_truth(k) = sqrt(out.V_truth(k,1)^2 + out.V_truth(k,2)^2);
    end
    
    figure
    hold on
    plot(t, out.v_b__t_b_odo(:,1), 'r')    
    plot(t, body_speed_truth, 'k')
    title('v^b_t_b_,_o_d_o vs. v^b_t_b_,_t_r_u_t_h')
    xlabel('Time (s)')
    xlim([0, P.t_end])
    ylabel('m/s')
    grid on
    hold off
    
end

%% Plot Odometry Angular Velocity Measurements

if (plot_C_t__b_comp == true)
    
    for k = 1 : length(t)
        [yaw_meas(k), pitch_meas(k), roll_meas(k)] = dcm2ypr(out.A_meas(:,:,k));
    end
    
    figure
    subplot(3,1,1)
    hold on
    plot(t, roll_meas * 180/pi, 'r')    
    plot(t, out.A_truth(:,1) * 180/pi, 'k')
    title('\phi_c_o_m_p vs. \phi_t_r_u_t_h')
    xlabel('Time (s)')
    xlim([0, P.t_end])
    ylabel('Roll (\circ)')
    grid on
    hold off
    subplot(3,1,2)
    hold on
    plot(t, pitch_meas * 180/pi, 'g')    
    plot(t, out.A_truth(:,2) * 180/pi, 'k')
    title('\theta_c_o_m_p vs. \theta_t_r_u_t_h')
    xlabel('Time (s)')
    xlim([0, P.t_end])
    ylabel('Pitch (\circ)')
    grid on
    hold off
    subplot(3,1,3)
    hold on
    plot(t, unwrap(yaw_meas) * 180/pi, 'b')    
    plot(t, out.A_truth(:,3) * 180/pi, 'k')
    title('\psi_c_o_m_p vs. \psi_t_r_u_t_h')
    xlabel('Time (s)')
    xlim([0, P.t_end])
    ylabel('Yaw (\circ)')
    grid on
    hold off
    
end

%% Plot Odometry v_t__t_b Measurements

if (plot_tan_speed_odo == true)
    
    figure
    subplot(3,1,1)
    hold on
    plot(t, out.v_t__t_b_odo(:,1), 'r')    
    plot(t, out.V_truth(:,1), 'k')
    title('v^t_t_b_,_x Odo vs. Truth')
    xlabel('Time (s)')
    xlim([0, P.t_end])
    ylabel('m/s')
    grid on
    hold off
    subplot(3,1,2)
    hold on
    plot(t, out.v_t__t_b_odo(:,2), 'g')    
    plot(t, out.V_truth(:,2), 'k')
    title('v^t_t_b_,_y Odo vs. Truth')
    xlabel('Time (s)')
    xlim([0, P.t_end])
    ylabel('m/s')
    grid on
    hold off
    subplot(3,1,3)
    hold on
    plot(t, out.v_t__t_b_odo(:,3), 'b')    
    plot(t, out.V_truth(:,3), 'k')
    title('v^t_t_b_,_z Odo vs. Truth')
    xlabel('Time (s)')
    xlim([0, P.t_end])
    ylabel('m/s')
    grid on
    hold off
    
end

end


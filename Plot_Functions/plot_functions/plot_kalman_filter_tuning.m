function plot_kalman_filter_tuning(r_KF_flag, v_KF_flag, psi_KF_flag, residuals_flag, meas_flag, out, P)
% Plots truth minus estimate for error, w/ Covariance Matrix

% Extract Time
t = out.tout;

% Format P
P = format_P(out.P_posteriori);

% Position_________________________________________________________________
if (r_KF_flag == true)
    
    % Calculate Truth minus Error
    r_error = (out.Delta_r_t__t_b - out.delta_r_t__t_b_est)';
    
    figure
    subplot(3,1,1)
    hold on
    plot(t, r_error(1,:), 'r')
    plot(t, P(7,:), 'k', t, -P(7,:), 'k')
    title('KF Tuning Check:  \Deltar^t_t_b_,_x - \deltar^t_t_b_,_x')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m')
%     legend('r_x error', '\sigma_7_,_7', '-\sigma_7_,_7', 'Location', 'Best')
    grid on
    
    subplot(3,1,2)
    hold on
    plot(t, r_error(2,:), 'g')
    plot(t, P(8,:), 'k', t, -P(8,:), 'k')
    title('KF Tuning Check:  \Deltar^t_t_b_,_y - \deltar^t_t_b_,_y')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m')
%     legend('r_y error', '\sigma_8_,_8', '-\sigma_8_,_8', 'Location', 'Best')
    grid on
    
    subplot(3,1,3)
    hold on
    plot(t, r_error(3,:), 'b')
    plot(t, P(9,:), 'k', t, -P(9,:), 'k')
    title('KF Tuning Check:  \Deltar^t_t_b_,_z - \deltar^t_t_b_,_z')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m')
%     legend('r_z error', '\sigma_9_,_9', '-\sigma_9_,_9', 'Location', 'Best')
    grid on
    
end


if (v_KF_flag == true)
    
    % Calculate Truth minus Error
    v_error = (out.Delta_v_t__t_b - out.delta_v_t__t_b_est)';
    
    figure
    subplot(3,1,1)
    hold on
    plot(t, v_error(1,:), 'r')
    plot(t, P(4,:), 'k', t, -P(4,:), 'k')
    title('KF Tuning Check:  \Deltav^t_t_b_,_x - \deltav^t_t_b_,_x')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m/s')
%     legend('v_x error', '\sigma_4_,_4', '-\sigma_4_,_4', 'Location', 'Best')
    grid on
    
    subplot(3,1,2)
    hold on
    plot(t, v_error(2,:), 'g')
    plot(t, P(5,:), 'k', t, -P(5,:), 'k')
    title('KF Tuning Check:  \Deltav^t_t_b_,_y - \deltav^t_t_b_,_y')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m/s')
%     legend('v_y error', '\sigma_5_,_5', '-\sigma_5_,_5', 'Location', 'Best')
    grid on
    
    subplot(3,1,3)
    hold on
    plot(t, v_error(3,:), 'b')
    plot(t, P(6,:), 'k', t, -P(6,:), 'k')
    title('KF Tuning Check:  \Deltav^t_t_b_,_z - \deltav^t_t_b_,_z')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m/s')
%     legend('v_z error', '\sigma_6_,_6', '-\sigma_6_,_6', 'Location', 'Best')
    grid on
    
end


if (psi_KF_flag == true)
    
    % Convert delta_C_t__b into YPR
    delta_ypr = zeros(3, length(t));
    for k = 1 : length(t)
        [delta_ypr(3,k), delta_ypr(2,k), delta_ypr(1,k)] = dcm2ypr(out.delta_C_t__b_est(:,:,k));
    end
    
    % Calculate Truth Minus Error
    psi_error = (out.Delta_euler_t__t_b - delta_ypr')';
    
    % Begin Plots
    figure
    subplot(3,1,1)
    hold on
    plot(t, psi_error(1,:) * 180/pi, 'r')
    plot(t, P(1,:) * 180/pi, 'k', t, -P(1,:) * 180/pi, 'k')
    title('KF Tuning Check:  \Delta\phi^t_t_b - \delta\phi^t_t_b')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('\circ')
%     legend('\phi error', '\sigma_1_,_1', '-\sigma_1_,_1', 'Location', 'Best')
    grid on
    
    subplot(3,1,2)
    hold on
    plot(t, psi_error(2,:) * 180/pi, 'g')
    plot(t, P(2,:) * 180/pi, 'k', t, -P(2,:) * 180/pi, 'k')
    title('KF Tuning Check:  \Delta\theta^t_t_b - \delta\theta^t_t_b')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('\circ')
%     legend('\theta error', '\sigma_2_,_2', '-\sigma_2_,_2', 'Location', 'Best')
    grid on
    
    subplot(3,1,3)
    hold on
    plot(t, psi_error(3,:) * 180/pi, 'b')
    plot(t, P(3,:) * 180/pi, 'k', t, -P(3,:) * 180/pi, 'k')
    title('KF Tuning Check:  \Delta\psi^t_t_b - \delta\psi^t_t_b')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('\circ')
%     legend('\psi error', '\sigma_3_,_3', '-\sigma_3_,_3', 'Location', 'Best')
    grid on
    
end

if (residuals_flag == true)
    
    
    figure
    hold on
    subplot(3,1,1)
    plot(t, out.residuals(:,1), 'r')
    title('Measurement Residuals (z_1 - H*x_1)')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m/s')
    grid on
    hold on
    subplot(3,1,2)
    plot(t, out.residuals(:,2), 'g')
    title('Measurement Residuals (z_2 - H*x_2)')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m/s')
    grid on
    subplot(3,1,3)
    plot(t, out.residuals(:,3), 'b')
    title('Measurement Residuals (z_3 - H*x_3)')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m/s')
    grid on
    hold off
    
end

if (meas_flag == true)
    
    figure
    subplot(3,1,1)
    hold on
    plot(t, out.z_k(:,1), 'r')
    title('KF Measurements:  z_1 = v^t_t_b_,_o_d_o_,_x - v^t_t_b_,_i_m_u_,_x')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m/s')
    grid on
    
    subplot(3,1,2)
    hold on
    plot(t, out.z_k(:,2), 'g')
    title('KF Measurements:  z_2 = v^t_t_b_,_o_d_o_,_y - v^t_t_b_,_i_m_u_,_y')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m/s')
    grid on
    
    subplot(3,1,3)
    hold on
    plot(t, out.z_k(:,3), 'b')
    title('KF Measurements:  z_3 = v^t_t_b_,_o_d_o_,_z - v^t_t_b_,_i_m_u_,_z')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m/s')
    grid on
    
end
    




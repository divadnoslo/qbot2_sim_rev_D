function plot_truth_vs_est(r_flag, v_flag, a_flag, out, P)
%PLOT_TRUTH_VS_EST Plots estimes of PVA against true PVA

t = out.tout;

if (r_flag == true)
    
    figure
    hold on
    subplot(3, 1, 1)
    plot(t, out.r_t__t_b_est(:,1), 'r', t, out.P_truth(:,1), 'k')
    title('Truth vs. Estimate:   r^t_t_b_,_x')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m')
    grid on
    legend('estimate', 'truth', 'Location', 'Best')
    subplot(3, 1, 2)
    plot(t, out.r_t__t_b_est(:,2), 'g', t, out.P_truth(:,2), 'k')
    title('Truth vs. Estimate:   r^t_t_b_,_y')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m')
    grid on
    legend('estimate', 'truth', 'Location', 'Best')
    subplot(3, 1, 3)
    plot(t, out.r_t__t_b_est(:,3), 'b', t, out.P_truth(:,3), 'k')
    title('Truth vs. Estimate:   r^t_t_b_,_z')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m')
    grid on
    legend('estimate', 'truth', 'Location', 'Best')
    
end

if (v_flag == true)
    
    figure
    hold on
    subplot(3, 1, 1)
    plot(t, out.v_t__t_b_est(:,1), 'r', t, out.V_truth(:,1), 'k')
    title('Truth vs. Estimate:   v^t_t_b_,_x')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m/s')
    grid on
    legend('estimate', 'truth', 'Location', 'Best')
    subplot(3, 1, 2)
    plot(t, out.v_t__t_b_est(:,2), 'g', t, out.V_truth(:,2), 'k')
    title('Truth vs. Estimate:   v^t_t_b_,_y')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m/s')
    grid on
    legend('estimate', 'truth', 'Location', 'Best')
    subplot(3, 1, 3)
    plot(t, out.v_t__t_b_est(:,3), 'b', t, out.V_truth(:,3), 'k')
    title('Truth vs. Estimate:   v^t_t_b_,_z')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('m/s')
    grid on
    legend('estimate', 'truth', 'Location', 'Best')
    
end
    
if (a_flag == true)
    
    % Convert DCM to YPR
    for k = 1 : length(t)
        [yaw(k), pitch(k), roll(k)] = dcm2ypr(out.C_t__b_est(:,:,k));
    end
     
    % Unwrap Yaw from Estimates
    yaw = unwrap(yaw);                                                  
                                                    
    figure
    hold on
    subplot(3, 1, 1)
    plot(t, roll * 180/pi, 'r', t, out.A_truth(:,1) * 180/pi, 'k')
    title('Truth vs. Estimate:   \phi^t_t_b')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('\circ')
    grid on
    legend('estimate', 'truth', 'Location', 'Best')
    subplot(3, 1, 2)
    plot(t, pitch * 180/pi, 'g', t, out.A_truth(:,2) * 180/pi, 'k')
    title('Truth vs. Estimate:   \theta^t_t_b')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('\circ')
    grid on
    legend('estimate', 'truth', 'Location', 'Best')
    subplot(3, 1, 3)
    plot(t, yaw * 180/pi, 'b', t, out.A_truth(:,3) * 180/pi, 'k')
    title('Truth vs. Estimate:   \psi^t_t_b')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('\circ')
    grid on
    legend('estimate', 'truth', 'Location', 'Best')
    
end

end


function plot_truth_vs_est(r_flag, v_flag, a_flag, out, P)
%PLOT_TRUTH_VS_EST Plots estimes of PVA against true PVA

t = out.tout;

if (r_flag == true)
    
    figure
    hold on
    subplot(3, 1, 1)
    plot(t, out.r_t__t_b_est.Data(:,1), 'r', t, out.P_truth.Data(:,1), 'k')
    title('r^t_t_b_,_x   Truth vs. Estimate')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('Position (m)')
    grid on
    legend('estimate', 'truth', 'Location', 'Best')
    subplot(3, 1, 2)
    plot(t, out.r_t__t_b_est.Data(:,2), 'g', t, out.P_truth.Data(:,2), 'k')
    title('r^t_t_b_,_y   Truth vs. Estimate')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('Position (m)')
    grid on
    legend('estimate', 'truth', 'Location', 'Best')
    subplot(3, 1, 3)
    plot(t, out.r_t__t_b_est.Data(:,3), 'b', t, out.P_truth.Data(:,3), 'k')
    title('r^t_t_b_,_z   Truth vs. Estimate')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('Position (m)')
    grid on
    legend('estimate', 'truth', 'Location', 'Best')
    
end

if (v_flag == true)
    
    figure
    hold on
    subplot(3, 1, 1)
    plot(t, out.v_t__t_b_est.Data(:,1), 'r', t, out.V_truth.Data(:,1), 'k')
    title('v^t_t_b_,_x   Truth vs. Estimate')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('Velocity (m/s)')
    grid on
    legend('estimate', 'truth', 'Location', 'Best')
    subplot(3, 1, 2)
    plot(t, out.v_t__t_b_est.Data(:,2), 'g', t, out.V_truth.Data(:,2), 'k')
    title('v^t_t_b_,_y   Truth vs. Estimate')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('Velocity (m/s)')
    grid on
    legend('estimate', 'truth', 'Location', 'Best')
    subplot(3, 1, 3)
    plot(t, out.v_t__t_b_est.Data(:,3), 'b', t, out.V_truth.Data(:,3), 'k')
    title('v^t_t_b_,_z   Truth vs. Estimate')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('Velocity (m/s)')
    grid on
    legend('estimate', 'truth', 'Location', 'Best')
    
end
    
if (a_flag == true)
    
    [~, ~, rpy] = extract_PVA(out.P_truth.Data, out.V_truth.Data, ...
                                                        out.A_truth.Data);
    
    % Convert k -> dcm -> ypr
    for k = 1 : length(out.psi_t__t_b_est.Data)
        [yaw(k), pitch(k), roll(k)] = dcm2ypr(k2dcm(out.psi_t__t_b_est.Data(k,:)'));
    end
                                                    
    rpy = rpy * pi/180;                                                  
                                                    
    figure
    hold on
    subplot(3, 1, 1)
    plot(t, roll * 180/pi, 'r', t, rpy(1,:) * 180/pi, 'k')
    title('\psi^t_t_b_,_\phi   Truth vs. Estimate')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('Roll (\circ)')
    grid on
    legend('estimate', 'truth', 'Location', 'Best')
    subplot(3, 1, 2)
    plot(t, pitch * 180/pi, 'g', t, rpy(2,:) * 180/pi, 'k')
    title('\psi^t_t_b_,_\theta   Truth vs. Estimate')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('Pitch (\circ)')
    grid on
    legend('estimate', 'truth', 'Location', 'Best')
    subplot(3, 1, 3)
    plot(t, unwrap(yaw * 180/pi), 'b', t, unwrap(rpy(3,:) * 180/pi), 'k')
    title('\psi^t_t_b_,_\psi   Truth vs. Estimate')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('Yaw (\circ)')
    grid on
    legend('estimate', 'truth', 'Location', 'Best')
    
end

end


function plot_fake(plot_fake_r, plot_fake_v, plot_fake_a, out, P)
%PLOT_FAKE Validation for Fake Aiding Sensor

t = out.tout;

if (plot_fake_r == true)
    
    figure
    subplot(3, 1, 1)
    plot(t, out.fake_r.Data(:,1), 'r', t, out.P_truth.Data(:,1), 'k')
    title('Fake Aiding Sensor: X Position')
    xlabel('Time (s)')
    ylabel('Position (m)')
    xlim([0 t(end)])
    grid on
    subplot(3, 1, 2)
    plot(t, out.fake_r.Data(:,2), 'g', t, out.P_truth.Data(:,2), 'k')
    title('Fake Aiding Sensor: Y Position')
    xlabel('Time (s)')
    ylabel('Position (m)')
    xlim([0 t(end)])
    grid on
    subplot(3, 1, 3)
    plot(t, out.fake_r.Data(:,3), 'b', t, out.P_truth.Data(:,3), 'k')
    title('Fake Aiding Sensor: Z Position')
    xlabel('Time (s)')
    ylabel('Position (m)')
    xlim([0 t(end)])
    grid on
    
end

if (plot_fake_v == true)
    
    figure
    subplot(3, 1, 1)
    plot(t, out.fake_v.Data(:,1), 'r', t, out.V_truth.Data(:,1), 'k')
    title('Fake Aiding Sensor: X Velocity')
    xlabel('Time (s)')
    ylabel('Velocity (m/s)')
    xlim([0 t(end)])
    grid on
    subplot(3, 1, 2)
    plot(t, out.fake_v.Data(:,2), 'g', t, out.V_truth.Data(:,2), 'k')
    title('Fake Aiding Sensor: Y Velocity')
    xlabel('Time (s)')
    ylabel('Velocity (m/s)')
    xlim([0 t(end)])
    grid on
    subplot(3, 1, 3)
    plot(t, out.fake_v.Data(:,3), 'b', t, out.V_truth.Data(:,3), 'k')
    title('Fake Aiding Sensor: Z Velocity')
    xlabel('Time (s)')
    ylabel('Velocity (m/s)')
    xlim([0 t(end)])
    grid on
    
end

if (plot_fake_a == true)
    
    [~, ~, rpy] = extract_PVA(out.P_truth.Data, out.V_truth.Data, ...
                                                        out.A_truth.Data);
    
    rpy = rpy * pi/180;    
    
    figure
    subplot(3, 1, 1)
    plot(t, out.fake_a.Data(:,1) * 180/pi, 'r', t, rpy(1,:) * 180/pi, 'k')
    title('Fake Aiding Sensor: X Velocity')
    xlabel('Time (s)')
    ylabel('Roll (\circ)')
    xlim([0 t(end)])
    grid on
    subplot(3, 1, 2)
    plot(t, out.fake_a.Data(:,2) * 180/pi, 'g', t, rpy(2,:) * 180/pi, 'k')
    title('Fake Aiding Sensor: Y Velocity')
    xlabel('Time (s)')
    ylabel('Pitch (\circ)')
    xlim([0 t(end)])
    grid on
    subplot(3, 1, 3)
    plot(t, out.fake_a.Data(:,3) * 180/pi, 'b', t, rpy(3,:) * 180/pi, 'k')
    title('Fake Aiding Sensor: Z Velocity')
    xlabel('Time (s)')
    ylabel('Yaw (\circ)')
    xlim([0 t(end)])
    grid on
    
end
%% Monte Carlo Simulation for IMU Error Propagation
% This allows the user to simulate how different IMU errors propagate
% through the Tangential Mechanization

%% Load the Simulation M-File

file_name = 'calibrated_IMU_king_hallway_run';
file_path = [file_name, '_monte_carlo.mat'];

load(file_path)

color_str = ['r', 'g', 'c', 'b', 'm'];

%% Plots of Position Monte Carlo Runs

figure(1)

% X Position Graph
subplot(3, 1, 1)
hold on
for k = 1 : num_runs
    plot(t, r_x(k,:), color_str(mod(k, length(color_str)) + 1))
end
r_x_avg_error = mean(abs(r_x(:,end)));
r_x_std_dev = std(r_x(:,end));
title('Monte Carlo: r^t_t_b_,_x')
xlabel('Time (s)')
xlim([0 t(end)])
ylabel('m')
str = ['|r^t_t_b_,_x| error avg = ', num2str(r_x_avg_error), ' m   std dev = '...
       num2str(r_x_std_dev), ' m'];
text(5, 2*min(r_x(:,end))/3, str, 'FontSize', 6)
grid on
hold off

% Y Position Graph
subplot(3, 1, 2)
hold on
for k = 1 : num_runs
    plot(t, r_y(k,:), color_str(mod(k, length(color_str)) + 1))
end
r_y_avg_error = mean(abs(r_y(:,end)));
r_y_std_dev = std(r_y(:,end));
title('Monte Carlo: r^t_t_b_,_y')
xlabel('Time (s)')
xlim([0 t(end)])
ylabel('m')
str = ['|r^t_t_b_,_y| error avg = ', num2str(r_y_avg_error), ' m   std dev = '...
       num2str(r_y_std_dev), ' m'];
text(5, 2*min(r_y(:,end))/3, str, 'FontSize', 6)
grid on
hold off

% Z Position Graph
subplot(3, 1, 3)
hold on
for k = 1 : num_runs
    plot(t, r_z(k,:), color_str(mod(k, length(color_str)) + 1))
end
r_z_avg_error = mean(abs(r_z(:,end)));
r_z_std_dev = std(r_z(:,end));
title('Monte Carlo: r^t_t_b_,_z')
xlabel('Time (s)')
xlim([0 t(end)])
ylabel('m')
str = ['|r^t_t_b_,_z| error avg = ', num2str(r_z_avg_error), ' m   std dev = '...
       num2str(r_z_std_dev), ' m'];
text(5, 2*min(r_z(:,end))/3, str, 'FontSize', 6)
grid on
hold off

%% Plots of Velocity Monte Carlo Runs

figure(2)

% X Velocity Graph
subplot(3, 1, 1)
hold on
for k = 1 : num_runs
    plot(t, v_x(k,:), color_str(mod(k, length(color_str)) + 1))
end
v_x_avg_error = mean(abs(v_x(:,end)));
v_x_std_dev = std(v_x(:,end));
title('Monte Carlo: v^t_t_b_,_x')
xlabel('Time (s)')
xlim([0 t(end)])
ylabel('m/s')
str = ['|v^t_t_b_,_x| error avg = ', num2str(v_x_avg_error), ' m/s   std dev = '...
       num2str(v_x_std_dev), ' m/s'];
text(5, 2*min(v_x(:,end))/3, str, 'FontSize', 6)
grid on
hold off

% Y Velocity Graph
subplot(3, 1, 2)
hold on
for k = 1 : num_runs
    plot(t, v_y(k,:), color_str(mod(k, length(color_str)) + 1))
end
v_y_avg_error = mean(abs(v_y(:,end)));
v_y_std_dev = std(v_y(:,end));
title('Monte Carlo: v^t_t_b_,_y')
xlabel('Time (s)')
xlim([0 t(end)])
ylabel('m/s')
str = ['|v^t_t_b_,_y| error avg = ', num2str(v_y_avg_error), ' m/s   std dev = '...
       num2str(v_y_std_dev), ' m/s'];
text(5, 2*min(v_y(:,end))/3, str, 'FontSize', 6)
grid on
hold off

% Z Velocity Graph
subplot(3, 1, 3)
hold on
for k = 1 : num_runs
    plot(t, v_z(k,:), color_str(mod(k, length(color_str)) + 1))
end
v_z_avg_error = mean(abs(v_z(:,end)));
v_z_std_dev = std(v_z(:,end));
title('Monte Carlo: v^t_t_b_,_z')
xlabel('Time (s)')
xlim([0 t(end)])
ylabel('m/s')
str = ['|v^t_t_b_,_z| error avg = ', num2str(v_z_avg_error), ' m/s   std dev = '...
       num2str(v_z_std_dev), ' m/s'];
text(5, 2*min(v_z(:,end))/3, str, 'FontSize', 6)
grid on
hold off

%% Plots of Attitude Monte Carlo Runs

figure(3)

% X Velocity Graph
subplot(3, 1, 1)
hold on
for k = 1 : num_runs
    plot(t, phi(k,:) * 180/pi, color_str(mod(k, length(color_str)) + 1))
end
phi_avg_error = mean(abs(phi(:,end)));
phi_std_dev = std(phi(:,end));
title('Monte Carlo: \phi^t_t_b')
xlabel('Time (s)')
xlim([0 t(end)])
ylabel('\circ')
str = ['|\phi^t_t_b| error avg = ', num2str(phi_avg_error * 180/pi), '\circ   std dev = '...
       num2str(phi_std_dev * 180/pi), '\circ'];
text(5, 2*min(phi(:,end))/3 * 180/pi, str, 'FontSize', 6)
grid on
hold off

% Y Velocity Graph
subplot(3, 1, 2)
hold on
for k = 1 : num_runs
    plot(t, theta(k,:) * 180/pi, color_str(mod(k, length(color_str)) + 1))
end
theta_avg_error = mean(abs(theta(:,end)));
theta_std_dev = std(theta(:,end));
title('Monte Carlo: \theta^t_t_b')
xlabel('Time (s)')
xlim([0 t(end)])
ylabel('\circ')
str = ['|\theta^t_t_b| error avg = ', num2str(theta_avg_error * 180/pi), '\circ   std dev = '...
       num2str(theta_std_dev * 180/pi), '\circ'];
text(5, 2*max(theta(:,end))/3 * 180/pi + 0.1, str, 'FontSize', 6)
grid on
hold off

% Z Velocity Graph
subplot(3, 1, 3)
hold on
for k = 1 : num_runs
    plot(t, unwrap(psi(k,:)) * 180/pi, color_str(mod(k, length(color_str)) + 1))
end
psi_avg_error = mean(abs(psi(:,end)));
psi_std_dev = std(psi(:,end));
title('Monte Carlo: \psi^t_t_b')
xlabel('Time (s)')
xlim([0 t(end)])
ylabel('\circ')
str = ['|\psi^t_t_b| error avg = ', num2str(psi_avg_error * 180/pi), '\circ   std dev = '...
       num2str(psi_std_dev * 180/pi), '\circ'];
text(5, -270 , str, 'FontSize', 6)
grid on
hold off


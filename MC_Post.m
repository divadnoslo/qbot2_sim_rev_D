%% Monte Carlo Simulation for IMU Error Propagation
% This allows the user to simulate how different IMU errors propagate
% through the Tangential Mechanization

%% Load the Simulation M-File

file_name = 'rest_10min_gyro_cal';
file_path = [file_name, '_monte_carlo.mat'];

load(file_path)

%% Subplots of X, Y, and Z position error

color_str = ['r', 'g', 'c', 'b', 'm'];

fig_num = 1;

figure(fig_num)
hold on
for ii = 1 : num_runs
    plot(t, delta_x(ii,:), color_str(mod(ii, length(color_str)) + 1))
end
title('Monte Carlo:  Error in X-Position')
xlabel('Time (s)')
ylabel('\deltar_x (m)')
grid on
hold off

fig_num = 2;

figure(fig_num)
hold on
for ii = 1 : num_runs
    plot(t, delta_y(ii,:), color_str(mod(ii, length(color_str)) + 1))
end
title('Monte Carlo:  Error in Y-Position')
xlabel('Time (s)')
ylabel('\deltar_y (m)')
grid on
hold off

fig_num = 3;

figure(fig_num)
hold on
for ii = 1 : num_runs
    plot(t, delta_z(ii,:), color_str(mod(ii, length(color_str)) + 1))
end
title('Monte Carlo:  Error in Z-Position')
xlabel('Time (s)')
ylabel('\deltar_z (m)')
grid on
hold off

%% Plotting the StdDev at each timestep
    
figure
subplot(3,1,1)
hold on
plot(t, (1/2)*abs(P.accel.b_a_FB(1))*t.^2, 'k:')
plot(t, sigma_x, 'r')
title('Std-Dev in X-Position Error')
xlabel('Time (s)')
ylabel('\sigma_x (m)')
grid on
hold off
subplot(3,1,2)
hold on
plot(t, (1/2)*abs(P.accel.b_a_FB(2))*t.^2, 'k:')
plot(t, sigma_y, 'g')
title('Std-Dev in Y-Position Error')
xlabel('Time (s)')
ylabel('\sigma_y (m)')
grid on
hold off
subplot(3,1,3)
hold on
plot(t, (1/2)*abs(P.accel.b_a_FB(3))*t.^2, 'k:')
plot(t, sigma_z, 'b')
title('Std-Dev in Z-Position Error')
xlabel('Time (s)')
ylabel('\sigma_z (m)')
grid on
legend('Expected Error Growth', 'Error Std Dev of 100 Sims', 'Location', 'Best')
hold off

%% Monte Carlo Sim Plot

figure
hold on
for kk = 1 : num_runs
    plot(t, delta_r(kk,:), color_str(mod(kk, length(color_str)) + 1))
end
line([t(1) t(end)], [avg_error avg_error], 'Color', 'red', 'LineStyle', '--')
text(0.5, avg_error + 0.1 * avg_error, 'Average Ending Position Error')
text(0.5, avg_error - 0.1 * avg_error, [num2str(avg_error), ' m'])
title('Monte Carlo:  \delta|r^t_t_b|  -- Position Error via Gyro Errors Only')
xlabel('Time (s)')
ylabel('\delta|r^t_t_b| (m)')
grid on
hold off
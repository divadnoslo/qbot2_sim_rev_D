function plot_KF_meas_PSD(zk1_psd_flag, zk2_psd_flag, out, P)

% Settings Needed for Z_k_1
% Drive forward for 100m
% Try again after rotating +90 deg

t = out.tout;

%% z_k_1 measurements

if (zk1_psd_flag == true)
    
    figure
    subplot(3,1,1)
    plot(t, out.z_k_1(:,1), 'r')
    title('z_k_,_1 x-direction')
    xlabel('Time (s)')
    ylabel('(m/s)')
    grid on
    subplot(3,1,2)
    plot(t, out.z_k_1(:,2), 'g')
    title('z_k_,_1 y-direction')
    xlabel('Time (s)')
    ylabel('(m/s)')
    grid on
    subplot(3,1,3)
    plot(t, out.z_k_1(:,3), 'b')
    title('z_k_,_1 z-direction')
    xlabel('Time (s)')
    ylabel('(m/s)')
    grid on
    
    %- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    % PSD Plot
    
    % Detrend Data
    z_k_1 = detrend(out.z_k_1);
    
    figure
    subplot(3,1,1)
    plot(t, z_k_1(:,1), 'r')
    title('z_k_,_1 x-direction after detrend')
    xlabel('Time (s)')
    ylabel('(m/s)')
    grid on
    subplot(3,1,2)
    plot(t, z_k_1(:,2), 'g')
    title('z_k_,_1 y-direction after detrend')
    xlabel('Time (s)')
    ylabel('(m/s)')
    grid on
    subplot(3,1,3)
    plot(t, z_k_1(:,3), 'b')
    title('z_k_,_1 z-direction after detrend')
    xlabel('Time (s)')
    ylabel('(m/s)')
    grid on
    
    % Plot PSD via P-Welch
    nfft = floor(2*P.Fs);
    
    % z_k_1 PSD
    figure
    
    subplot(3,1,1)
    [pxx_zk1_1, f] = pwelch(z_k_1(:,1), nfft, [], nfft, P.Fs);
    plot(f, sqrt(pxx_zk1_1), 'b')
    str = ['\sigma_zk1_1 = ', num2str(std(z_k_1(:,1))), 'm/s'];
    title(['z_k_1_,_1 PSD  ', str])
    xlabel('Frequency (Hz)')
    ylabel('m/s / sqrt(Hz)')
    %xlim([0.5, 50])
    grid on
    hold off
    
    subplot(3,1,2)
    [pxx_zk1_1, f] = pwelch(z_k_1(:,2), nfft, [], nfft, P.Fs);
    plot(f, sqrt(pxx_zk1_1), 'b')
    str = ['\sigma_zk1_2 = ', num2str(std(z_k_1(:,2))), 'm/s'];
    title(['z_k_1_,_2 PSD  ', str])
    xlabel('Frequency (Hz)')
    ylabel('m/s / sqrt(Hz)')
    %xlim([0.5, 50])
    grid on
    hold off
    
    subplot(3,1,3)
    [pxx_zk1_3, f] = pwelch(z_k_1(:,3), nfft, [], nfft, P.Fs);
    plot(f, sqrt(pxx_zk1_3), 'b')
    str = ['\sigma_zk1_3 = ', num2str(std(z_k_1(:,3))), 'm/s'];
    title(['z_k_1_,_3 PSD  ', str])
    xlabel('Frequency (Hz)')
    ylabel('m/s / sqrt(Hz)')
    %xlim([0.5, 50])
    grid on
    hold off
    
end

%% z_k_2 measurements

if (zk2_psd_flag == true)
    
    % Pull Measurements that occur at 1 Hz
    mask = mod(t,1) == 0;
    t = t(mask);
    z_k_2 = out.z_k_2(mask, :);
    
    figure
    subplot(3,1,1)
    plot(t, z_k_2(:,1), 'r*')
    title('z_k_,_2 k_1')
    xlabel('Time (s)')
    ylabel('k_1')
    grid on
    subplot(3,1,2)
    plot(t, z_k_2(:,2), 'g*')
    title('z_k_,_2 k_2')
    xlabel('Time (s)')
    ylabel('k_2')
    grid on
    subplot(3,1,3)
    plot(t, z_k_2(:,3), 'b*')
    title('z_k_,_2 k_3')
    xlabel('Time (s)')
    ylabel('k_3')
    grid on
    
    %- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
    % PSD Plot
    
    % Detrend Data
    z_k_2 = detrend(z_k_2);
    
    figure
    subplot(3,1,1)
    plot(t, z_k_2(:,1), 'r*')
    title('z_k_,_2 k_1')
    xlabel('Time (s)')
    ylabel('k_1')
    grid on
    subplot(3,1,2)
    plot(t, z_k_2(:,2), 'g*')
    title('z_k_,_2 k_2')
    xlabel('Time (s)')
    ylabel('k_2')
    grid on
    subplot(3,1,3)
    plot(t, z_k_2(:,3), 'b*')
    title('z_k_,_2 k_3')
    xlabel('Time (s)')
    ylabel('k_3')
    grid on
    
    % Plot PSD via P-Welch
    nfft = floor(2*P.Fs);
    
    % z_k_1 PSD
    figure
    
    subplot(3,1,1)
    [pxx_zk2_1, f] = pwelch(z_k_2(:,1), nfft, [], nfft, P.Fs);
    plot(f, sqrt(pxx_zk2_1), 'b')
    str = ['\sigma_zk2_1 = ', num2str(std(z_k_2(:,1)))];
    title(['z_k_2_,_1 PSD  ', str])
    xlabel('Frequency (Hz)')
    ylabel('rad / sqrt(Hz)')
    %xlim([0.5, 50])
    grid on
    hold off
    
    subplot(3,1,2)
    [pxx_zk2_2, f] = pwelch(z_k_2(:,2), nfft, [], nfft, P.Fs);
    plot(f, sqrt(pxx_zk2_2), 'b')
    str = ['\sigma_zk2_2 = ', num2str(std(z_k_2(:,2)))];
    title(['z_k_2_,_2 PSD  ', str])
    xlabel('Frequency (Hz)')
    ylabel('rad / sqrt(Hz)')
    %xlim([0.5, 50])
    grid on
    hold off
    
    subplot(3,1,3)
    [pxx_zk2_3, f] = pwelch(z_k_2(:,3), nfft, [], nfft, P.Fs);
    plot(f, sqrt(pxx_zk2_3), 'b')
    str = ['\sigma_zk2_3 = ', num2str(std(z_k_2(:,3)))];
    title(['z_k_2_,_3 PSD  ', str])
    xlabel('Frequency (Hz)')
    ylabel('rad / sqrt(Hz)')
    %xlim([0.5, 50])
    grid on
    hold off
    
end


end
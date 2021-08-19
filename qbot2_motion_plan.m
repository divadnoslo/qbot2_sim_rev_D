%% Qbot 2 Motion Plan

%**************************************************************************
%
% Uncomment/comment the motion profile you wish to use, or write your own
% using the examples below.  
%
% 3 Modes of Travel
% 'Mode 1' = stationary -> amount of time paused (sec)
% 'Mode 2' = angular    -> amount of angle psi to turn (rad) (NED Frame)
% 'Mode 3' = linear     -> distance forward to drive (meters)
%
%**************************************************************************

%*** Debugging Cases ***
%__________________________________________________________________________
% % Staying Still for an amount of time
% P.motion_plan = {"Mode 1", 120};

% % Moving Forward for 100 meters
% P.motion_plan = {"Mode 3", 100};

% % Rotate in Place 16 Times
% P.motion_plan = {"Mode 2", 16*(2*pi)};

% % Rotate in 45 Deg
% P.motion_plan = {"Mode 1", 1; ...
%                  "Mode 3", 1; ...
%                  "Mode 1", 1; ...
%                  "Mode 2", pi/4; ...
%                  "Mode 1", 1; ...
%                  "Mode 3", 1; ...
%                  "Mode 1", 1};

% % Clock Wise Box
% P.motion_plan = {"Mode 3", 4; ...
%                  "Mode 1", 1; 
%                  "Mode 2", pi/2; ...
%                  "Mode 3", 4; ...
%                  "Mode 1", 1; 
%                  "Mode 2", pi/2; ...
%                  "Mode 3", 4; ...
%                  "Mode 1", 1; 
%                  "Mode 2", pi/2; ...
%                  "Mode 3", 4; ...
%                  "Mode 1", 1; 
%                  "Mode 2", pi/2};

% % Counter Clock Wise Box
% P.motion_plan = {"Mode 3", 1; ...
%                  "Mode 2", -pi/2; ...
%                  "Mode 3", 1; ...
%                  "Mode 2", -pi/2; ...
%                  "Mode 3", 1; ...
%                  "Mode 2", -pi/2; ...
%                  "Mode 3", 1; ...
%                  "Mode 2", -pi/2};
%
%
%
% % Simple Test Case 2 -- CW --- Repeated 5 times
% P.motion_plan = {"Mode 3",     2.8; ...
%                  "Mode 2",     pi/2; ...
%                  "Mode 3",     2.8; ...
%                  "Mode 2",     pi/2;...
%                  "Mode 3",     2.8; ...
%                  "Mode 2",     pi/2; ...
%                  "Mode 3",     2.8; ...
%                  "Mode 2",     pi/2; ...
%                  "Mode 1",     10};
% 
% P.motion_plan = [P.motion_plan; P.motion_plan;  P.motion_plan;  P.motion_plan;  P.motion_plan];             
%__________________________________________________________________________



%*** Hardware Test Cases ***
%__________________________________________________________________________
% % Simple Test Case 1 -- CCW
% P.motion_plan = {"Mode 1",     10; ...
%                  "Mode 3",     2.8; ...
%                  "Mode 2",    -pi/2; ...
%                  "Mode 3",     2.8; ...
%                  "Mode 2",    -pi/2;...
%                  "Mode 3",     2.8; ...
%                  "Mode 2",    -pi/2; ...
%                  "Mode 3",     2.8; ...
%                  "Mode 2",    -pi/2; ...
%                  "Mode 1",     10};

% Simple Test Case 2 -- CW
P.motion_plan = {"Mode 1",     10; ...
                 "Mode 3",     2.8; ...
                 "Mode 2",     pi/2; ...
                 "Mode 3",     2.8; ...
                 "Mode 2",     pi/2;...
                 "Mode 3",     2.8; ...
                 "Mode 2",     pi/2; ...
                 "Mode 3",     2.8; ...
                 "Mode 2",     pi/2; ...
                 "Mode 1",     10};

% % King Building Hallway Mock-up
% P.motion_plan = {"Mode 1",     10; ...
%                  "Mode 3",     15.5448; ...
%                  "Mode 1",     10; ...
%                  "Mode 2",     -pi/4; ...
%                  "Mode 3",     11.3919; ...
%                  "Mode 1",     10; ...
%                  "Mode 2",     -pi/4;...
%                  "Mode 3",     18.796; ...
%                  "Mode 1",     10; ...
%                  "Mode 2",     -pi/2; ...
%                  "Mode 3",     23.6728; ...
%                  "Mode 1",     10; ...
%                  "Mode 2",     -pi/4; ...
%                  "Mode 3",     4.3307; ...
%                  "Mode 1",     10; ...
%                  "Mode 2",     -pi/4; ...
%                  "Mode 3",     23.8252; ...
%                  "Mode 1",     10; ...
%                  "Mode 2",     -pi/2; ...
%                  "Mode 3",     3.2385; ...
%                  "Mode 1",     10};
%__________________________________________________________________________

%% Build Motion Plan

% Initialze Position, Heading, and Odometry Start Points
[num_steps, ~] = size(P.motion_plan);
r_t__t_b_old = [0; 0; 0];
psi_t__t_b_old = 0;
r_wheel_old = [0; 0];

% For Each Step of the Motion Plan
for ii = 1 : num_steps
    
    % Generate body frame motion according to mode of travel
    if (P.motion_plan{ii,1} == "Mode 1")
        [t_k, r_w, r_b__t_b, v_b__t_b, a_b__t_b, psi, w_b__t_b] = ...
           qbot2_stationary_motion_gen(P.motion_plan{ii,2}, P);
    elseif (P.motion_plan{ii,1} == "Mode 2")
        [t_k, r_w, r_b__t_b, v_b__t_b, a_b__t_b, psi, w_b__t_b] = ...
              qbot2_angular_motion_gen(P.motion_plan{ii,2}, P);
    elseif (P.motion_plan{ii,1} == "Mode 3")
        [t_k, r_w, r_b__t_b, v_b__t_b, a_b__t_b, psi, w_b__t_b] = ...
               qbot2_linear_motion_gen(P.motion_plan{ii,2}, P);
    else
        error('Mode of Motion not recognized, check your spelling')
    end
    
    % Build indexes and time vectors
    if (ii == 1)
        t = t_k;
        k = 1 : length(t_k);
        k_next = k;
        k_prev = 0;
    else
        k_prev = k(end);
        k_next = k_prev + (1 : length(t_k));
        k = [k, k_next];
        t = [t, (t(end) + P.dt + t_k)];
    end
    
    % Convert Body Motions into the Tangential Frame
    for jj = k_next
        psi_t__t_b(1,jj) = psi(1,jj-k_prev) + psi_t__t_b_old;
        a_t__t_b(1:3,jj) = rotate_z(psi_t__t_b(1,jj)) * a_b__t_b(:,jj-k_prev);
        v_t__t_b(1:3,jj) = rotate_z(psi_t__t_b(1,jj)) * v_b__t_b(:,jj-k_prev);
        r_t__t_b(1:3,jj) = rotate_z(psi_t__t_b(1,jj)) * r_b__t_b(:,jj-k_prev) + r_t__t_b_old;
        w_t__t_b(1:3,jj) = rotate_z(psi_t__t_b(1,jj)) * w_b__t_b(:,jj-k_prev);
        r_wheel(1:2,jj)  = r_w(:,jj-k_prev) + r_wheel_old;
        
        % Passing Mode
        if (P.motion_plan{ii,1} == "Mode 1")
            mode(jj) = 1;
        elseif (P.motion_plan{ii,1} == "Mode 2")
            mode(jj) = 2;
        elseif (P.motion_plan{ii,1} == "Mode 3")
            mode(jj) = 3;
        end
    end
    
    % Capture End State for next instruction
    psi_t__t_b_old = psi_t__t_b(1,k_next(end));
    r_t__t_b_old = r_t__t_b(:,k_next(end));
    r_wheel_old = [r_wheel(1,end); r_wheel(2,end)];
    
end

%% Save Results into Structure P
% These structure fields are passed into the simulation "Body-in-Tan" block

P.ind = k;
P.r_t__t_b = r_t__t_b;
P.v_t__t_b = v_t__t_b;
P.a_t__t_b = a_t__t_b;
P.psi_t__t_b = psi_t__t_b;
P.w_t__t_b = w_t__t_b;
P.t_end = t(end);
P.r_wheel = r_wheel;
P.mode = mode;

%% Plot Resulting Path of the Robot

if (P.plot_motion_plan_flag == true)
    
    C_v__t = rotate_x(pi);
    r_v__t_b = C_v__t * r_t__t_b;
    
    % Bird's Eye View
    figure
    hold on
    plot3(r_v__t_b(1,:), r_v__t_b(2,:), r_v__t_b(3,:))
    plot_frame(C_v__t, [0; 0; 0], 't', []);
    view(-69, 76)
    xlim([min(r_v__t_b(1,:)) - 1,  max(r_v__t_b(1,:)) + 1])
    ylim([min(r_v__t_b(2,:)) - 1,  max(r_v__t_b(2,:)) + 1])
    zlim([-1 1])
    title('Qbot 2 Motion Plan')
    xlabel('X')
    ylabel('Y')
    grid on
    
    % Position, Velocity, and Acceleration in X-Direction
    figure
    subplot(3,1,1)
    plot(t, r_t__t_b(1,:), 'r')
    title('Motion Plan:  r^t_t_b_,_x')
    ylabel('r_x (m)')
    grid on
    xlim([0 t(end)])
    subplot(3,1,2)
    plot(t, v_t__t_b(1,:), 'r')
    title('Motion Plan:  v^t_t_b_,_x')
    ylabel('v_x (m/s)')
    grid on
    xlim([0 t(end)])
    subplot(3,1,3)
    plot(t, a_t__t_b(1,:), 'r')
    title('Motion Plan:  a^t_t_b_,_x')
    xlabel('Time (s)')
    ylabel('a_x (m/s^2)')
    grid on
    xlim([0 t(end)])
    
    % Position, Velocity, and Acceleration in Y-Direction
    figure
    subplot(3,1,1)
    plot(t, r_t__t_b(2,:), 'g')
    title('Motion Plan:  r^t_t_b_,_y')
    ylabel('r_y (m)')
    grid on
    xlim([0 t(end)])
    subplot(3,1,2)
    plot(t, v_t__t_b(2,:), 'g')
    title('Motion Plan:  v^t_t_b_,_y')
    ylabel('v_y (m/s)')
    grid on
    xlim([0 t(end)])
    subplot(3,1,3)
    plot(t, a_t__t_b(2,:), 'g')
    title('Motion Plan:  a^t_t_b_,_y')
    xlabel('Time (s)')
    ylabel('a_y (m/s^2)')
    grid on
    xlim([0 t(end)])
    
    % Heading & Angular Velocity
    figure
    subplot(2,1,1)
    plot(t, psi_t__t_b * 180/pi, 'b')
    title('Motion Plan:  \psi^t_t_b')
    ylabel('\psi (\circ)')
    grid on
    xlim([0 t(end)])
    subplot(2,1,2)
    plot(t, w_t__t_b(3,:) * 180/pi, 'b')
    title('Motion Plan:  \omega^t_t_b_,_z')
    ylabel('\omega_z (\circ/s)')
    grid on
    xlim([0 t(end)])
    
    % Odometry True Measurements
    figure
    hold on
    plot(t, r_wheel(1,:), 'g')
    plot(t, r_wheel(2,:), 'r')
    title('Qbot2 Wheel Position')
    xlabel('Time (s)')
    xlim([0 t(end)])
    ylabel('Arc Length Turned (m)')
    legend('Left Wheel', 'Right Wheel', 'Location', 'Best')
    grid on

end
    
%% Clear unneeded variables from the workspace

clear a_b__t_b a_t__t_b C_b__b_1 C_t__b C_t__b_old ii jj k k_next k_prev kk 
clear num_steps plot_motion_flag r_b__t_b r_t__t_b r_t__t_b_old t t_k
clear v_b__t_b v_t__t_b w_b__t_b w_t__t_b yaw ans C_v__t r_v__t_b r_w
clear r_wheel r_wheel_old mode
P = rmfield(P, 'motion_plan');
clear psi psi_t__t_b psi_t__t_b_old

%% Stationary Motion Generation Function

function [t_k, r_w, r_b__t_b, v_b__t_b, a_b__t_b, psi, w_b__t_b] = ...
                     qbot2_stationary_motion_gen(time_pause, P)

t_k = 0 : P.dt : time_pause;                 
r_b__t_b = zeros(3,1,length(t_k));
v_b__t_b = zeros(3,1,length(t_k));
a_b__t_b = zeros(3,1,length(t_k));
psi = zeros(1, length(t_k));
w_b__t_b = zeros(3,1,length(t_k));
r_w = zeros(2, length(t_k));

end

%% Linear Motion Generation

function [t_k, r_w, r_b__t_b, v_b__t_b, a_b__t_b, psi, w_b__t_b] = ...
                              qbot2_linear_motion_gen(r_des, P)

dt = P.dt;
                          
% Set Traveling Parameters
v_travel = 0.3; % m/s
a_travel = 3/2; % m/s

% Begin Setting t1
t_travel = r_des / v_travel;
t1 = (pi*v_travel) / (2*a_travel);

% Show Down Travel Parameters if t1 is greater than 1/3 the avg time
while (t1 > ((1/3)*t_travel))
    v_travel = v_travel - 0.05;
    a_travel = a_travel - 0.1;
    
    t_travel = r_des / v_travel;
    t1 = (pi*v_travel) / (2*a_travel);
    
    if ((v_travel <= 0) || (a_travel <= 0))
        error('Requested Distance of Travel too small, v_travel or a_travel is negative')
    end
end

% Compute Distance Covered from 0 < t < t1
t = 0 : dt : t1;
a_l = a_travel*sin((pi/t1)*t);

v_l = zeros(1, length(a_l));
r_l = zeros(1, length(a_l));
for k = 2 : length(a_l)
    v_l(k) = a_l(k)*dt + v_l(k-1);
    r_l(k) = v_l(k)*dt + r_l(k-1);
end

r_t1 = r_l(end);

% How long should t1 < t < t2 be?
r_remain = r_des - (2*r_t1);
t2 = r_remain / v_travel;

if (mod(t2, dt) > 0)
    
    new_t2 = 0;
    while (new_t2 < t2)
        new_t2 = new_t2 + dt;
    end
    t2 = new_t2;
end

% Now actually calculate the entire time of travel

% Build Acceleration Cuve

a_l = [a_travel*sin((pi/t1)*t), zeros(1, length(dt:dt:t2-dt)), -a_travel*sin((pi/t1)*t)];

% Integrate to Velocity and Position
t_k = zeros(1, length(a_l));
v_l = zeros(1, length(a_l));
r_l = zeros(1, length(a_l));

for k = 2 : length(a_l)
    t_k(k) = dt * (k - 1);
    v_l(k) = a_l(k)*dt + v_l(k-1);
    r_l(k) = v_l(k)*dt + r_l(k-1);
end

% Build Function Outputs
r_b__t_b = [r_l; zeros(2,length(t_k))];
v_b__t_b = [v_l; zeros(2,length(t_k))];
a_b__t_b = [a_l; zeros(2,length(t_k))];
psi = zeros(1, length(t_k));
w_b__t_b = zeros(3, length(t_k));
r_w = [r_l; r_l];

end

%% Angular Motion Generation

function [t_k, r_w, r_b__t_b, v_b__t_b, a_b__t_b, psi, w_b__t_b] = ...
                          qbot2_angular_motion_gen(psi_des, P)

dt = P.dt;
                      
% Qbot 2 Parameters
diameter = P.diameter;
radius = diameter / 2;

% Desired Angular Rate
ang_rate = 0.1 / radius;  % rad / s

% Determine Angular Rate & Time
psi = 0 : (sign(psi_des) * ang_rate * dt) : psi_des;
t_k = 0 : dt : ((length(psi)-1) * dt);
w_b__t_b = repmat([0; 0; sign(psi_des) * ang_rate], 1, length(t_k));

% Determine Attitude
for ii = 1 : length(t_k)
    C_t__b(1:3,1:3,ii) = rotate_z(psi(ii));
end

% Determine Position, Velocity, Acceleration
r_b__t_b = zeros(3, length(t_k));
v_b__t_b = zeros(3, length(t_k));
a_b__t_b = zeros(3, length(t_k));

% Determine Wheel Position
r_w = [(psi * radius); ...
      (-psi * radius)];

% Old Method
%__________________________________________________________________________
% sign_psi = psi_des / abs(psi_des);
% r_des = radius * abs(psi_des);
% 
% % Set Traveling Parameters
% v_travel = 0.1; % m/s
% a_travel = 0.5; % m/s
% 
% % Begin Setting t1
% t_travel = r_des / v_travel;
% t1 = (pi*v_travel) / (2*a_travel);
% 
% % Show Down Travel Parameters if t1 is greater than 1/3 the avg time
% while (t1 > ((1/3)*t_travel))
%     v_travel = v_travel - 0.05;
%     a_travel = a_travel - 0.1;
%     
%     t_travel = r_des / v_travel;
%     t1 = (pi*v_travel) / (2*a_travel);
%     
%     if ((v_travel <= 0) || (a_travel <= 0))
%         error(['Requested Angle ', num2str(psi_des*180/pi), ' is too small'])
%     end
% end
% 
% % Compute Distance Covered from 0 < t < t1
% t = 0 : dt : t1;
% a_l = a_travel*sin((pi/t1)*t);
% 
% v_l = zeros(1, length(a_l));
% r_l = zeros(1, length(a_l));
% for k = 2 : length(a_l)
%     v_l(k) = a_l(k)*dt + v_l(k-1);
%     r_l(k) = v_l(k)*dt + r_l(k-1);
% end
% 
% r_t1 = r_l(end);
% 
% % How long should t1 < t < t2 be?
% r_remain = r_des - (2*r_t1);
% t2 = r_remain / v_travel;
% 
% if (mod(t2, dt) > 0)
%     
%     new_t2 = 0;
%     while (new_t2 < t2)
%         new_t2 = new_t2 + dt;
%     end
%     t2 = new_t2;
% end
% 
% % Now actually calculate the entire time of travel
% 
% % Build Acceleration Cuve
% 
% a_l = [a_travel*sin((pi/t1)*t), zeros(1, length(dt:dt:t2-dt)), -a_travel*sin((pi/t1)*t)];
% 
% % Integrate to Velocity and Position
% t_k = zeros(1, length(a_l));
% v_l = zeros(1, length(a_l));
% r_l = zeros(1, length(a_l));
% 
% for k = 2 : length(a_l)
%     t_k(k) = dt * (k - 1);
%     v_l(k) = a_l(k)*dt + v_l(k-1);
%     r_l(k) = v_l(k)*dt + r_l(k-1);
% end
% 
% w_z = sign_psi*(abs(psi_des)/r_des) .* v_l;
% psi = sign_psi*(abs(psi_des)/r_des) .* r_l;
% 
% % Build Function Outputs
% r_b__t_b = zeros(3, length(t_k));
% v_b__t_b = zeros(3, length(t_k));
% a_b__t_b = zeros(3, length(t_k));
% for k = 1 : length(t_k)
%     C_t__b(:,:,k) = rotate_z(psi(k));
% end
% w_b__t_b = [zeros(2,length(t_k)); w_z];
% 
% if (psi(k) > 0)
%     r_w = [r_l; -r_l];
% else
%     r_w = [-r_l; r_l];
% end

end
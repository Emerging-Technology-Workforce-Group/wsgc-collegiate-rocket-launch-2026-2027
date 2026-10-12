clear; clc; close all;

%% 1. Vapor Rocket Parameter Definitions
g = 9.8;                   % Gravity (m/s^2)
rho = 1.225;               % Sea level air density (kg/m^3)
rocket_dry_mass = 0.09922; % Dry airframe (kg)
drag_coeff = 0.617;        % from example problem #2 Cd
body_diameter = 0.0414;    % Vapor diameter (m)
motor_total_mass = 0.0456; % Initial motor mass (kg)
motor_prop_mass = 0.0242;  % Propellant mass (kg)
cross_section = pi * (body_diameter / 2)^2; 
dry_mass = rocket_dry_mass + (motor_total_mass - motor_prop_mass);

%% 2. Thrust Curve for D12-5 engine
thrust_time_points  = [0.00, 0.05, 0.180,  0.28,  0.32,  0.39, 0.55, 1.07, 1.44, 1.59, 1.61, 1.65];
thrust_force_points = [0.00, 2.57, 17.28, 29.73, 17.99, 12.10, 9.88, 8.90, 8.31, 8.29, 4.61, 0.00];
burn_time = max(thrust_time_points);         % Update a final timestamp for thrust cutoff

%% 3. Time Step Configuration
dt = 0.1;               % simulation time step
max_time = 10;          % total flight time 
time = 0:dt:max_time;
% Variable Allocation
height = zeros(1, length(time));
velocity = zeros(1, length(time));
acceleration = zeros(1, length(time));
mass = zeros(1, length(time));
thrust_profile = zeros(1, length(time));
% Initial Conditions
height(1) = 0;            
velocity(1) = 0;          
mass(1) = rocket_dry_mass + motor_total_mass;

%% 4. Numerical Integration Loop
actual_steps = 1;
for i = 1:(length(time)-1)
    actual_steps = i;
    current_time = time(i);
% Step A: Interpolate thrust and deplete mass
    if current_time <= burn_time
        % Linearly interpolate
        thrust = interp1(thrust_time_points, thrust_force_points, current_time, 'linear');
        % Propellant burns off linearly over the total burn time
        mass(i) = (rocket_dry_mass + motor_total_mass) - (motor_prop_mass * (current_time / burn_time));
    else
        thrust = 0;
        mass(i) = dry_mass;
    end
    thrust_profile(i) = thrust;
% Step B: Compute instantaneous force components
    weight_force = mass(i) * g;
    drag_force = 0.5 * rho * drag_coeff * cross_section * (velocity(i)^2) * sign(velocity(i));
% Step C: Derive Acceleration from the net force curve
    net_force = thrust - drag_force - weight_force;
    acceleration(i) = net_force / mass(i);
% Step D: Integrate Acceleration to find the next Speed value
    velocity(i+1) = velocity(i) + acceleration(i) * dt;
% Step E: Integrate Speed to find the next Height value
    height(i+1) = height(i) + velocity(i) * dt;
% Termination condition (Impact)
    if height(i+1) <= 0 && current_time > 0.5
        height(i+1) = 0;
        velocity(i+1) = 0;
        acceleration(i+1) = 0;
        thrust_profile(i+1) = 0;
        break;
    end
end
% Trim vectors to flight timeline
time = time(1:actual_steps+1);
height = height(1:actual_steps+1);
velocity = velocity(1:actual_steps+1);
acceleration = acceleration(1:actual_steps+1);
thrust_profile = thrust_profile(1:actual_steps+1);
fprintf('Apogee height = %.2f m, after %.1f s of launching\n', max(height), dt*find(height == max(height), 1));

%% 5. Multi-Panel Trajectory Plotting
figure('Name', 'Dynamic Thrust Integration', 'NumberTitle', 'off');
% Panel 1: Input Thrust Curve
subplot(4,1,1);
plot(time, thrust_profile, 'm', 'LineWidth', 2); grid on;
ylabel('Thrust (N)');
title('1. Input Dynamic Thrust Curve (Estes D12-5 Profile)');
% Panel 2: Acceleration
subplot(4,1,2);
plot(time, acceleration, 'r', 'LineWidth', 2); grid on;
ylabel('Acceleration (m/s^2)');
title('2. Resulting Acceleration Curve (\SigmaF / Mass)');
% Panel 3: Velocity
subplot(4,1,3);
plot(time, velocity, 'g', 'LineWidth', 2); grid on;
ylabel('Velocity (m/s)');
title('3. Speed Curve (Integrated Acceleration)');
% Panel 4: Height
subplot(4,1,4);
plot(time, height, 'b', 'LineWidth', 2); grid on;
ylabel('Height (m)');
xlabel('Time (seconds)');
title('4. Estimated Height Curve (Integrated Speed)');
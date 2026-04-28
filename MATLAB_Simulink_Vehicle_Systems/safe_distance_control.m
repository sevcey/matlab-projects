clc;
clear;
close all;

% Vehicle Safe Distance Control Simulation

time = 0:0.1:20;              % simulation time in seconds
ego_speed = zeros(size(time)); % our vehicle speed
lead_speed = zeros(size(time));% front vehicle speed
distance = zeros(size(time));  % distance between vehicles

ego_speed(1) = 90;             % km/h
lead_speed(:) = 70;            % km/h
distance(1) = 40;              % meters

safe_distance = 30;            % meters

for i = 2:length(time)

    % Convert speed from km/h to m/s
    ego_speed_ms = ego_speed(i-1) / 3.6;
    lead_speed_ms = lead_speed(i-1) / 3.6;

    % Distance update
    distance(i) = distance(i-1) + (lead_speed_ms - ego_speed_ms) * 0.1;

    % Control logic
    if distance(i) < safe_distance
        ego_speed(i) = ego_speed(i-1) - 1;   % reduce speed
    else
        ego_speed(i) = ego_speed(i-1);       % keep speed
    end

    % Speed limit
    if ego_speed(i) < lead_speed(i)
        ego_speed(i) = lead_speed(i);
    end
end

% Plot results
figure;
plot(time, distance, 'LineWidth', 2);
hold on;
yline(safe_distance, '--', 'Safe Distance');
xlabel('Time (s)');
ylabel('Distance (m)');
title('Vehicle Following Distance');
grid on;

saveas(gcf, 'simulation_distance.png');

figure;
plot(time, ego_speed, 'LineWidth', 2);
hold on;
plot(time, lead_speed, '--', 'LineWidth', 2);
xlabel('Time (s)');
ylabel('Speed (km/h)');
title('Vehicle Speed Control');
legend('Ego Vehicle Speed', 'Lead Vehicle Speed');
grid on;

saveas(gcf, 'simulation_speed.png');
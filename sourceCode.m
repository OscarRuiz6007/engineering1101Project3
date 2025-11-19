disp("Mind Goblin") % Oscar
67 % Mich
% Bazinga
% process. --- Nolan 

clear, clc, close all;
a = arduino('COM3', 'Uno'); % Make an arduino object to use it

% Variables
i = 1; % for looping
Time = []; % Create a vector to store time data
Voltage = []; % Create a vector to store data of read voltage
X_LIMIT = 100; % Default plot x-axis range
Y_LIMIT = 7; % Default plot y-axis range
on = true; % Default boolean value that automatically starts program
ohms = 1000;  % The expected ohms used in the project
DEFAULT_PAUSE_TIME = .1; % Default pause time for verification noise
BUZZER_VOLTAGE_CHECK = 1; % Default variable for the amount of times buzzer is activated

% Plot Initiation
figure; % create a plot area
xlim([0 X_LIMIT]);%set limit for plot
ylim([0 Y_LIMIT]);%set limit for plot
title('Voltage Measurements Collected'); % Add a Title
xlabel('Time (Time) [s]'); % Add Horizontal Axis Labeling
ylabel('Voltage (Voltage) [m]'); % Add Vertical Axis Labeling
grid on; % Add Grid Lines
hold on;

% Active Data Collection
while on == true % start of loop
    
    % Start of loop setup
    if i == 1
    disp("Start") % Notiy user of Start 
    pause(2); % Starting period grace
    tic(); % Begins a clock to keep track of time
    end

    % Displaying loop iteration
    disp(i)

    % Graphical updates
    Time(i) = toc(); % Save the time elasped in seconds for each measurement
    Voltage(i) = readVoltage(a, 'A0'); % Collect/Save the Measurement Data
    plot(Time(i), Voltage(i), 'b*') % Point Plotting
    drawnow % Making point plotting live

    % Power Calculation
    power(i) = voltage(i) * (voltage(i)/ohms);

    % Display requirement
    if Voltage(i) >= 5 % conditional statement for buzzer turning on and off
        playTone(a, 'D3', 0, 1); % buzz off
        BUZZER_VOLTAGE_CHECK = 1; % reset the buzzer speed
    elseif Measurement(i) <= 0.3 % conditional statement for buzzer turning off
        playTone(a, 'D3', 900 + BUZZER_VOLTAGE_CHECK * 50, 1); % buzz on
        pause(DEFAULT_PAUSE_TIME / BUZZER_VOLTAGE_CHECK);
        playTone(a, 'D3', 0, 1); % buzz off
        pause(DEFAULT_PAUSE_TIME / BUZZER_VOLTAGE_CHECK);
        BUZZER_VOLTAGE_CHECK = BUZZER_VOLTAGE_CHECK + .25;
    end

    % Program shutdown after 100 loops
    if i >= 100 
        on = false;
    end
    i = i + 1; % adds to loop counter i

    % Text display to user
    disp("Current Loop Iteration: " + i)
    disp("Current Voltage Read for Current Loop " + Voltage(i))
    disp("Power Calculated for Current Loop: " + power(i))
end

disp("end") % tells user program has endedr that the program has ended

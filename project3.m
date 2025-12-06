% Project 3
% OSCAR CIPRIANO FLORES

clear, clc, close all;
a = arduino('COM3', 'Uno'); % Make an arduino object to use it

% Variables
i = 1; % for looping
Time = []; % Create a vector to store time data
Voltage = []; % Create a vector to store data of read voltage
X_LIMIT = 100; % Default plot x-axis range
Y_LIMIT = 8; % Default plot y-axis range
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
    % disp(i)

    % Graphical updates
    Time(i) = toc(); % Save the time elasped in seconds for each measurement
    Volt(i) = readVoltage(a, 'A0'); % Collect/Save the Measurement Data
    plot(Time(i), Volt(i), 'b*') % Point Plotting
    drawnow % Making point plotting live

    % Power Calculation
    power(i) = Volt(i) * (Volt(i)/ohms);

    % Display requirement
    if Volt(i) < 4 % conditional statement for buzzer turning on and off
        playTone(a, 'D3', 0, 1); % buzz off
        BUZZER_VOLTAGE_CHECK = 1; % reset the buzzer speed
    elseif Volt(i) >= 4  % conditional statement for buzzer turning off
        playTone(a, 'D3', 900 + BUZZER_VOLTAGE_CHECK * 50, 1); % buzz on
        pause(DEFAULT_PAUSE_TIME / BUZZER_VOLTAGE_CHECK);
        playTone(a, 'D3', 0, 1); % buzz off
        pause(DEFAULT_PAUSE_TIME / BUZZER_VOLTAGE_CHECK);
        BUZZER_VOLTAGE_CHECK = BUZZER_VOLTAGE_CHECK + .25;
    end

    % Program shutdown after 100 loops
    if i >= 700 
        on = false;
    end
    

    % Text display to user
    sprintf("Current Loop Iteration: %0.2f", i)
    sprintf("Current Voltage Read for Current Loop: %0.2f", Volt(i))
    sprintf("Power Calculated for Current Loop: %0.2f", power(i))
    
    i = i + 1; % adds to loop counter i
end

save([datestr(now, 'yyyy.mm.dd.HH.MM.SS'), '.Recorded.mat'], "Time", "Volt")
disp("end") % tells user program has ended
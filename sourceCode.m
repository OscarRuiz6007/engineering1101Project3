disp("Mind Goblin") % Oscar
67 % Mich
% Bazinga
% process. --- Nolan 

clear, clc, close all;
a = arduino('COM3', 'Uno'); % Make an arduino object to use it

% Variables
i = 0; % for looping
Time = []; % Create a vector to store time data
Voltage = []; % Create a vector to store data of read voltage
X_LIMIT = 100; % Default plot x-axis range
Y_LIMIT = 1; % Default plot y-axis range
on = true; % Default boolean value that automatically starts program

% Plot Initiation
figure; % create a plot area
xlim([0 X_LIMIT]);%set limit for plot
ylim([0 Y_LIMIT]);%set limit for plot
title('Ultrasonic Distance Measurements Collected'); % Add a Title
xlabel('Time (Time) [s]'); % Add Horizontal Axis Labeling
ylabel('Distance (Measurement) [m]'); % Add Vertical Axis Labeling
grid on; % Add Grid Lines
hold on;

% Active Data Collection to be Graphed
while on == true % Start of loop for data collection

    if i == 0
    disp("Start") % Notiy user of Start 
    pause(2); % Starting period grace
    tic(); % Begins a clock to keep track of time
    end

    % Displaying loop iteration
    disp(i)

    % Graphical updates
    Time(i) = toc(); % Save the time elasped in seconds for each measurement
    Voltage(i) = readVoltage(a, 'A0'); % Collect/Save the Measurement Data
    plot(Time(i), Measurement(i), 'b*') % Point Plotting
    drawnow % Making point plotting live

    if i >= 100 % program shutdown after 100 loops
        on = false;
    end
    
    i = i + 1; % adds to loop counter i
end

disp("end") % notify user that the program has ended

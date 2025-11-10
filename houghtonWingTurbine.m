% S20 Houghton Wind Turbine Data
% Measures how well turbine is performing
% OSCAR CIPRIANO FLORES
% Section: L27 Team: 3

p = 1.225; % this is p or rho or air density
[v, Pe] = readvars('Wind_Data.xlsx'); % v is wind speed while exp is the Pe is experimental data
A = pi*3.25^2; % A is the swept area

for i = 1:length(v) % loop to create theoretical data vector
    Pt(i) = (p*A*v(i)^3)/2; 
end

% Graphing
plot(v, Pe, 'b.')
xlabel("Wind Speed (v) [m/s]")
ylabel("Experimental Power (Pe) [Watts]")
title("Houghton Wind Turbine Data Experimental and Theoretical")
hold on
plot(v, Pt, 'r--')
xlabel("Wind Speed (v) [m/s]")
ylabel("Theoretical Power (Pt) [Watts]")
legend("Experimental Power", "Theoretical Power")

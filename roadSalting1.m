% S22 Road Salting Problem
% OSCAR CIPRIANO FLORES
% Section: L27 Team: 3

clear;
[days, month, dom, temp] = readvars("HoughtonCountyTempsNov20thruJan21.xlsx");

for i = 1:length(temp) % Cleaning out sensor data errors
    if temp(i) == -999
        temp(i) = temp(i - 1);
    end
end

for i = 1:length(temp) - 1 % Moving average of vector x (this one is better because it gives us the exact number of elements there should be
    avg(i) = (temp(i + 1) + temp(i)) / 2;
end

for i = 1:length(avg) % Vector listing 1 for days that need to be salted
    if avg(i) <= 32
        salt(i) = 1;
    else
        salt(i) = 0;
    end
end

total = 0;
for i = 1:length(salt) % The total amount of days that need to be salted
    if salt(i) == 1
        total = total + 1;
    end
end

for i = 1:length(salt) % seperating salted and unsalted days
    if salt(i) == 1
        salted(i + 1) = i; 
    end
end

sprintf("Salt is needed a total of %.0f days", total)

plot(days, temp, 'b.')
xlabel("Days since November 1st (d) [days]")
ylabel("Temperature (t) [degF]")
title("Daily Average Temperature for Nov 2020 - Jan 2021")
hold on
plot(salted, temp, 'r.')
legend("Days Recorded", "Days to be Salted")


I = 60;
V = 28;
duty = 0.545;

% Creating the array
% Resistance, t_on, t_off
constants = [0.0583, 35e-9, 26e-9;
             0.0059, 72e-9, 43e-9;
             0.0049, 67e-9, 19e-9;
             0.0223, 29e-9, 27e-9];

thermal_res_jc = 1.21;
thermal_res_cs = 0.5;
T_j = 175;

x_values = 1000:1000:80000; % Creating the list of x values

num_constants = size(constants, 1); % Number of constants/situations

% Initializing the y_values array
y_values = zeros(num_constants, numel(x_values));

% Looping through each row of the constants array
conduction_loss = [];
switching_loss = {};
for i = 1:num_constants
    % Initializing temporary y_values array for the current situation
    y_temp = zeros(1, numel(x_values));
    
    y_cond = 0;
    y_switch = 0;
    switching_loss_single = [];
    % Calculating y values for each x value
    for j = 1:numel(x_values)
        y_cond = constants(i, 1) .* (I^2) .* duty;
        y_switch = ((constants(i, 2) + constants(i, 3)) .* I .* V .* x_values(j)) .* 0.5;
        switching_loss_single(end+1) = y_switch;
        y_temp(j) = y_cond + y_switch;
    end
    conduction_loss(end+1) = y_cond;
    switching_loss{end+1} = switching_loss_single;
    % Storing the calculated y values in the y_values array
    y_values(i, :) = y_temp;
    
    % Plotting the situation
    plot(x_values, y_values(i, :));
    hold on;

end

% Adding labels and title to the plot
xlabel('Switching Frequency (Hz)');
ylabel('Power Loss (W)');
title('Plot of Different Situations');

% Adding a legend to the plot
legend('Transistor 2', 'Transistor 5', 'Transistor 8', 'Transistor  9');
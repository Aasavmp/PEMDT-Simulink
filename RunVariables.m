% clear all
% clc

%% 

% Voltage input of converter
Vin = 25;
Vinmax = 28;
Vinmin = 22;

% voltage output of converter
Voutmax = 12;
Voutmin = 9;

% Current output of converter
Ioutmax = 60;
Ioutmin = 40;
fs = 1e4;

%efficency of converter
E = 1;

% Resistance of Inductor in Converter
R_L = 0.001;

% Resistance of field
R_f = 0.223;

% Inductance of field
L_f = 0.0138;

% Calculate the required capacitor and inductor
[L, C, D_avg] = CapacitorInductorCalc(Vinmax, Vinmin, Vin, Voutmax, Voutmin, Ioutmax, Ioutmin, fs, E);

%% Getting current controller
% we want a critically damp system at a quick settling time t_s
% so if we say t_s is 5T then T = t_s/5
test_settling_times = 0.2;

legend_entries = {};
for i = test_settling_times

    settling_time = i;
    Time_period = settling_time/5;
    coeff_a = (2/Time_period);
    coeff_b = (1/Time_period)^2;
    
    % Treating the convertor constant it is 25
    converter_const = 25;
    
    % Cons between machine input and output
    R_const = R_f;
    
    kp = (coeff_a-(L_f/R_f))*(L_f/(R_const*converter_const));
    ki = (L_f/(R_const*converter_const))*coeff_b;
    
    numerator = ((R_f*converter_const)/L_f).*[kp ki];
    denominator = [1 ((L_f/R_f)+((kp*R_f*converter_const)/L_f)) ((ki*R_f*converter_const)/L_f)];
    
    % system_tf = tf(numerator, denominator);
    % bode(system_tf)
    % whole_system_fb = feedback(system_tf, 1);
    % rlocus(whole_system_fb)
    
%     sim("exam_model_converter_R2020a_final_V2.slx")
%     hold on
%     plot(out.simout.Time, out.simout.Data, LineWidth=3)
%     legend_entries{end+1} = ['\(t_s = ',num2str(i),', K_p = ', num2str(kp),', K_i = ', num2str(ki),'\)'];
end

% plot(out.simout.Time, out.simout.Data, LineWidth=3)
% hold on
% plot(out.simout1.Time, out.simout1.Data, LineWidth=3)
% legend('\(Provided Machine at t_s = 0.2\)', '\(Derived Function at t_s = 0.2\)', '\(Provided Machine at t_s = 0.4\)', '\(Derived Function at t_s = 0.4\)')

%% Torque Calculation
omega = 0:1:12000;
omega_rad = (pi/30).*omega;

% assume angular accel of 80 throughout
T_pre = 0.5.*80 + 0.05.*omega_rad(omega < 8000);
T_post = 0.5.*80 + 0.05.*omega_rad(omega >= 8000) - 30;
Torque = [T_pre, T_post];

plot(omega, Torque)
hold on
yline(max(T_pre))
% close all
% clear all
% 
% %Input
% %Voltage 22V-28V
% 
% %Output
% %voltage 9V-12V
% %Current 40A-60A
% 
% 
% %pre defined variables
% Vinmax = 28;
% Vinmin = 22;
% Vin = 25;
% 
% Voutmax = 12;
% Voutmin = 9;
% 
% Ioutmax = 60;
% Ioutmin = 40;
% fs = 2e4;
% 
% %efficency
% E = 1;

function [L, Cout, D_avg] = CapacitorInductorCalc(Vinmax, Vinmin, Vin, Voutmax, Voutmin, Ioutmax, Ioutmin, fs, E)
%     fsmin = fs/2;
    fsmin = fs;

    Ioutavg = (Ioutmax + Ioutmin)/2;
    
    %Max duty cycle
    Dmax = Voutmax/(Vinmin*E);
    
    %min duty cycle
    Dmin = Voutmin/(Vinmax*E);

    % Average Duty cycle
    D_avg = (Dmax+Dmin)/2;
    
    %inductor ripple
    IL = 0.1*Ioutmax;
    
    %Inductor
    L = (Voutmax*(Vin-Voutmax))/(IL*fsmin*Vin);
    
    %average forward current
    If = Ioutmax*(1-Dmax);

    delta_V = 0.01*Vin;
    
    %Capacitor 
    Cout = IL/(8*fsmin*delta_V);
end
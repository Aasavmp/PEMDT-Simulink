close all
clear all

%Input
%Voltage 22V-28V

%Output
%voltage 9V-12V
%Current 40A-60A


%pre defined variables
Vinmax = 28;
Vinmin = 22;
Vin = 25;

Voutmax = 12;
Voutmin = 9;

Ioutmax = 60;
Ioutmin = 40;
fs = 1000;
fsmin = fs/2;

%efficency
E = 0.9;

%Max duty cycle
D = Voutmax/(Vinmax*E);

%min duty cycle
Dmin = Voutmin/(Vinmax*E);

%inductor ripple
IL = 0.2*Ioutmax;

%Inductor
L = (Voutmax*(Vin-Voutmax))/(IL*fsmin*Vin);

%average forward current
If = Ioutmax*(1-D);

%Capacitor 
Cout = IL/(8*fsmin*Voutmax);
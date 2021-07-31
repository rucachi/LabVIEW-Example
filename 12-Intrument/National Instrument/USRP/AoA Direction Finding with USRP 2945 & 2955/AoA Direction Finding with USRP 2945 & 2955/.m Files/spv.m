function S=spv(array,direction,fc)
% Degree to radian conversion.
SOURCES=frad(direction);
% https://en.wikipedia.org/wiki/Wavenumber
% Conversion of radians to half wavelength wavenumber
% frequency * wavelength = speed of light(3e8)
%wavenumber is the number of waves in a unit distance.
%The number of radians per unit distance, sometimes termed the angular wavenumber 
%or circular wavenumber, but more often simply wavenumber (2*pi/wavelength)
%here we are calculating in terms of half wavelength.
KI = 2*fc/3e8*fki(SOURCES(:,1),SOURCES(:,2));
%array is a vector of antenna distances.
%e.g. [0 0.5 * lambda lambda 1.5 * lambda]
S = exp(-1j*(array*KI));
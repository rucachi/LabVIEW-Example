function KI=fki(az,el)
%https://en.wikipedia.org/wiki/Wavenumber
%wavenumber vector in half wavelengths;
%wavenumber is the number of waves in a unit distance.
%The number of radians per unit distance, sometimes termed the angular wavenumber 
%or circular wavenumber, but more often simply wavenumber (2*pi/wavelength)
%here we are calculating in terms of half wavelength.
KI = pi*[cos(az).*cos(el)   sin(az).*cos(el)    sin(el)]';
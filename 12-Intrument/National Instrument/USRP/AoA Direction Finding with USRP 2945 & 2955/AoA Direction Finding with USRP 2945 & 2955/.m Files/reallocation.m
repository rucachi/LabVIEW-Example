%MuSIC algorithm
function [D M az el Z]=reallocation(array,fc,x,L,threshold)
%Correlation Matrix.
Rxx=x*x'/L;
%Eigen value decomposition. E matrix with columns as eigenvectors of Rxx.
%Diagonal elements of D are eigenvalues of Rxx.
[E D]=eig(Rxx);
%Diagonal elements are the eigenvalues.
eigen=diag(D);
ne=[];
%Construct vectors of strong eigenvalues.
N=size(array,1);
for i=1:N
    if real(eigen(i))<threshold
        ne=[ne i];
    end
end
%Number of sources (M) is equal to number of strong eigenvalues.
M=N-length(ne);
%Collect eigenvectors of the noise subspace which correspond to weak eigenvalues
En=E(:,ne);
%Vector of angle of arrivals with 0.5 deg resolution.
az=0:0.5:180;
az=az';
el=zeros(size(az));
%Calculation of Azimuth(az) and Elevation/Altitude(el)
S=spv(array,[az,el],fc);
Z=zeros(1,length(az));
for i=1:length(az)
Z(i)=-10*log10(abs(S(:,i)'*En*En'*S(:,i)));
end

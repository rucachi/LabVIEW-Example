%Make the phases of receiving boards synchronized
function [L direct2 dirphase dphcali m2 mphase mphcali]=phasesyn(m,B1,A1,B2,A2,L,phases,userefsignal)
cut=1000;
direct=filter(B1,A1,m.').';%Lowpass;Get the direct wave
direct(:,L-cut+1:L)=[];
direct(:,1:cut)=[];
% N is the number of antennae/boards.
N=size(m,1);
dirphase=angle(direct)/pi*180;%Direct wave phase
xc=ones(N,L-2*cut);
direct2=zeros(N,L-2*cut);
% Extract first antenna/board data.
direct2(1,:)=direct(1,:);
%For all other channels calculate the phase relative to the first antenna/board.
for n=2:N
	%Divide two complex numbers to get a complex number whose phase is the phase difference between the two.
    xc(n,:)=direct(1,:)./direct(n,:);
    %Phase difference between the reference receiving board and other ones
    direct2(n,:)=exp(1i*angle(xc(n,:))).*direct(n,:);
    %Direct wave after phase synchronized
end
dphcali=angle(direct2)/pi*180;%Direct wave phase after phase synchronized
m=filter(B2,A2,m.').';%Highpass;Get the signal through the air
m(:,L-cut+1:L)=[];
m(:,1:cut)=[]; 
mphase=angle(m)/pi*180;%Signal phase
m2=m;
if userefsignal == 1
for n=1:N 
    m2(n,:)=m2(n,:).*exp(-1i*angle(direct(n,:)));%.*abs(xc(n,:));
    %Phase synchronized
end
else
for n=1:N 
    m2(n,:)=m2(n,:).*exp(-1i*phases(n));%.*abs(xc(n,:));
    %Phase synchronized
end
end
mphcali=angle(m2)/pi*180;%Signal phase after phase synchronised
L=L-2*cut;%The length of signal

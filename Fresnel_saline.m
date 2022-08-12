m_salt=35; %grams
m_water=1000; %grams
S=m_salt/m_water*1000; %Salinity in ppt
T=25; %degrees celsius
z=1000; %deepth of solution in meters
a1=1448.96; a2=4.591; a3=-5.304*10^-2; a4=2.374*10^-4; a5=1.340; a6=1.630*10^-2; a7=1.675*10^-7; a8=-1.025*10^-2; a9=-7.135*10^-13; %MacKenzie params
v=a1+a2.*T+a3.*T^2+a4.*T^3+a5.*(S-35)+a6.*z+a7.*z^2+a8.*T.*(S-35)+a9.*T.*z^3; %velocity of wave
c=1480; %velocity of sound in water
f=65*10^6; %frequency of wave
lam=v/f;
F=500*10^-6; %focal distance
n=10;

for k=1:n
    r(k)=sqrt(2.*k.*lam.*(F+(k.*lam)/2))*10^6; %outer radii of ring
    R(k+1)=sqrt(r(k)^2+r(1)^2);
    %R(k)=sqrt(2.*(k-0.5).*lam.*(F+((k-0.5).*lam)/2))*10^6; %inner radii of ring
end

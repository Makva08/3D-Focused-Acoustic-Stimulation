S=0.000169; %area of chunk
%density in kg/m^3
pSi=2329;
pLN=4650; %LiNbO3 36° Rotated Y-cut
pParyleneC=1289;
pSU8=1200; %raw
pITO=7140;
pAu=19300;
%pSiO=2.65; % α-quartz

%Longitudal sound velocity m/s
vSi=8433;
vLN=7340;
vParyleneC=2200;
vSU8=2860;
vITO=4400;
vAu=2030;
%vSiO=5797;

%Impedances
ZSi=pSi*vSi;
ZLN=pLN*vLN;
ZParyleneC=pParyleneC*vParyleneC;
ZSU8=pSU8*vSU8;
ZITO=pITO*vITO;
ZAu=pAu*vAu;
%ZSiO=pSiO*vSiO;

%thicknesses
dSi=400*10^-6;
dLN=45*10^-6; %40-50 in datasheet
syms dParyleneC dSU8 dITO dAu;

%[33] - Electric field and stress are in one direction
e0=8.854*10^-12; %dielectric permittivity
erLN=38; %relative permittivity
eLN=erLN*e0;
epsT33LN=28.7;
e33LN=1.3; %piezoelectric constant - C/m^2   
h33LN=5.1*10^9; %piezo pressure constant - N/C
CE33LN=2.424*10^11; %elastic constant - N/m^2 
kt2=0.485;
kt2_c=((e33LN)^2)/(CE33LN*e0*epsT33LN);

C0=epsT33LN*S/dLN; %intrinsic capacitance of LN
Z0=50; %standart normalized impedance of network analyzer

F=50*10^6:0.1*10^6:80*10^6;

for i=1:length(F)
    f=F(i);
    %wavenumbers
    kSi=2*pi*f/vSi;
    kLN=2*pi*f/vLN;
    kParyleneC=2*pi*f/vParyleneC;
    kSU8=2*pi*f/vSU8;
    kITO=2*pi*f/vITO;
    kAu=2*pi*f/vAU;

    Zb3=1i*ZParyleneC*tan(kParyleneC*dParyleneC); 
    Zt3=1i*ZParyleneC*tan(kParyleneC*dParyleneC);
    Zb2=1i*((ZParyleneC*tan(kParyleneC*dParyleneC)+ZITO*tan(kITO*dITO))/(1-(ZParyleneC/ZITO)*tan(kParyleneC*dParyleneC)*tan(kITO*dITO)));
    Zt2=1i*((ZParyleneC*tan(kParyleneC*dParyleneC)+ZSU8*tan(kSU8*dSU8))/(1-(ZParyleneC/ZSU8)*tan(kParyleneC*dParyleneC)*tan(KSU8*dSU8)));
    Zb1=((Zb2+1i*ZSi*tan(kSi*dSi))/(1+1i*(Zb2/ZSi)*tan(kSi*dSi)));
    Zt1=((Zt2+1i*ZITO*tan(kITO*dITO))/(1+1i*(Zt2/ZITO)*tan(kITO*dITO)));
    
    z1=(Zt1+Zb1)*sin(kLN*dLN)+1i*2*(1-cos(kLN*dLN));
    z2=(Zt1+Zb1)*cos(kLN*dLN)+1i*(1+Zt1+Zb1)*sin(kLN*dLN);
    Zin=(1/(1i*pi*f*C0))*(1-(kt2/(kLN*dLN))*(z1/z2));
    S11(i)=(Z0-abs(Zin))/(Z0+abs(Zin));
end
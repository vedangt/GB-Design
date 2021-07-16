Ka=1;                                                                      %spline clculation factor
Km=1;                                                                      %load distribution factor
Kf=1.5;                                                                    %fatigue life factor
Ys=470;                                                                    %yield strength
tau=Ys/1.6;                                                                %allowable shear stress
sigmac=20;                                                                 %allowable compressive stress
T=40000;                                                                   %input torqe
M=[0 0 0 0 0 0];
for m=1:0.1:1.5                                                              %module
  for N=15:1:30                                                            %no of spline
    Dp=m*N;                                                                %pitch dia
    Dr=Dp-(2*0.9*m);                                                       %root dia
    t=0.5*pi*m;                                                            %spline thickness
    h=m;                                                                   %(0.5+0.6-0.1)m engagement depth
    Le=0.741*Dp;                                                           %effective length
    Sr=16*T*Ka/(pi*power(Dr,3)*Kf);
    Fosr=tau/Sr;                                                           %fos at root
    Sp=4*T*Ka*Km/(Dp*N*Le*t*Kf);
    Fosp=tau/Sp;                                                           %fos at pitch  dia
    sigmacr=2*T*Ka*Km/(9*Dp*N*Le*h*Kf);
    Fosc=sigmac/sigmacr;                                                   %crushing at the splineroot
    M=[M;m N Le Fosr Fosp Fosc];
  end
end  
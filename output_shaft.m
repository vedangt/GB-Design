N = [0 0 0 0 0 0 0];
inputT=40*1000;
redu1=4.636;
redu2=2.024;
T=inputT*redu1*redu2;
module=3;
nofteeth=83;
r1=(module*nofteeth)/2;
                                                                              %r=radius of gear in mm
Ft=(T/r1);                                                                   %Ft=force tangential in N
Fr=Ft*tan(pi/9);
r1=22.43;                                                                     %r1,r2 are in mmr
r2=46.67;                                                                       %Fr=force radial in N

R2=(Fr*r1)/(r2+r1);                                                          %R2=reaction force 2
R1=(Fr*r2)/(r2+r1);                                                          %R1=reaction force 1
R2dash=(Ft*r1)/(r2+r1);
R1dash=(Ft*r2)/(r2+r1);
M2=R1dash*r1;
M1=R1*r1;
M=power(((M1*M1)+(M2*M2)),1/2);
Ma=M;
Tm=T;
Sy=470;                                                                       %Sy in Mpa
Sut=745;                                                                      %Sut in Mpa
if(Sut<=1400)                               %Sut in mpa
    Sedash = 0.5*Sut;
elseif(Sut>1400)
    Sedash=700;
end

for din = 20:1:30
n=1.5;
Kt1=1.7;
Kts1=1.5;
Kf1=Kt1;
Kfs1=Kts1;
Kb1=0.9;
Kc=1;
Kd=1;
Ke=0.753;
a=4.51;b=-0.265;                                                              %for Sut in Mpa    %machined 
Ka= a*(Sut^b);                                                                %ka = surface condition modification factor
Se1=Ka*Kb1*Kc*Kd*Ke*Sedash;                                                     %Se'= rotary-beam test specimen endurance limit
C1=(2*Kf1*Ma)/Se1;D1=power(3*power(Kfs1*Tm,2),1/2)/Sut;
d1=power(((16*n)/pi)*(C1+D1),1/3);
c=d1;
p=[1 0 0 -power(c,3) -power(din,4)];
root=roots(p);
d1=root(1,1);

for q=0.85:0.01:0.89
for qshear=0.87:0.01:0.89
Kt2=1.65;
Kts2=1.42;
Kf2=1+q*(Kt2-1);
Kfs2=1+qshear*(Kts2-1);

if(2.79<=d1 && d1<51)
  Kb2=1.24*(power(d1,-0.107));                                                  %kb = size modification factor           
elseif(51<= d1 && d1 <=254)
        Kb2=(power(d1,-0.157));                 %in mm 
end    
d2pow3=(power(d1,3))*(1-(power((din/d1),4)));
Se2=Ka*Kb2*Kc*Kd*Ke*Sedash;
C2=(2*Kf2*Ma)/Se2;D2=power(3*power(Kfs2*Tm,2),1/2)/Sut;
nf=(d2pow3)*(pi)*(power(16*(C2+D2),-1));
N = [N;q qshear Kf2 Kfs2 d1 din nf];
end
end
end




%if(18<=d1&&d1<20)
    %d1=18;
%elseif(20<=d1&&d1<22)
   % d1=20; 
%elseif(22<=d1&&d1<25)
 %   d1=22;
%elseif(25<=d1&&d1<28)
 %   d1=25;
%elseif(28<=d1&&d1<30)
 %   d1=28;
%elseif(30<=d1&&d1<32)
 %   d1=30;
%elseif(32<=d1&&d1<35)
 %   d1=32;
%elseif(35<=d1&&d1<40)
 %   d1=35;
%end
%D=(1.2)*d1;
%if(18<=D&&D<20)
 %   D=20;
%elseif(20<=D&&D<22)
 %   D=22; 
%elseif(22<=D&&D<25)
 %   D=25;
%elseif(25<=D&&D<28)
 %   D=28;
%elseif(28<=D&&D<30)
 %   D=30;
%elseif(30<=D&&D<32)
 %   D=32;
%elseif(32<=D&&D<35)
 %   D=35;
%elseif(35<=D&&D<40)
 %   D=40;
%end
%Dbyd1=D/d1;
%rbyd1=0.1;
%r=(0.1)*d1;
%there will be a matrix but for now lets ignore
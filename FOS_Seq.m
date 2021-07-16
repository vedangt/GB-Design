function[fos_b, fos_c] = FOS_Seq(n1,n2,m,F,T,rpm,N)

%% Tangential Load
D = m*n1/1000;
Wt = 2*T/D;

%% Overload Factor
Ko = 1.25;

%% Dynamic Factor
Q = 8;
v = pi*D*rpm/60;
B = 0.25*power((12-Q),2/3);
A = 50 + 56*(1-B);
Kv = power((A+sqrt(200*v))/A, B);

%% Size Factor
load 'Y.mat';
Y = Yn(n1-14);
Ks = 0.8433*power((m*F*sqrt(Y)),0.0535);

%% Load Distribution Factor
Cmc = 1;            % Uncrowned Gears
if F<25.4                               % Facewidth Misallignment Magnification
    Cpf = F/(10000*D)-0.025;
else
    Cpf = F/(10000*D) - 0.0375 + 0.0125*F/25.4;
end
Cpm = 1;            % Mounting Position
A = 0.0675;
B = 0.0125;
C = -0.926E-4;
Fi = F/25.4;
Cma = A + B*Fi + C*Fi*Fi;       % Manufacturing Accuracy
Ce = 1;                 % Extra Adjustment;
Kh = 1 + Cmc*(Cpf*Cpm + Cma*Ce);

%% Rim Thickness Factor
Kb = 1;                 % For all practical purposes, Tr/Ht>1.2

%% Geometric Factor
load 'J.mat';
Yj = J(n2-14,n1-14);

%% Bending Stress
B_Stress = Wt*Ko*Kv*Ks*(1/(F*m))*(Kh*Kb/Yj);

%% Elasticity Coefficient
Ze = 191;                       % table 14.8, steel pinion steel gear

%% Surface Condition Factor
Zr = 1;                         % should be taken >1 for detrimental surface finish effect

%% Surface Strength Geometry Factor
phi = 20;
mg = n2/n1;
mn = 1;                         % for spur gears
Zi = (cosd(phi)*sind(phi)/(2*mn))*(mg/(mg+1));       % mg-1 for internal gear

%% Contact Stress
C_Stress = Ze*sqrt((Wt*Ko*Kv*Ks*Kh*Zr/(1000*D*F*Zi)));

%% Strength
Hbc = 363;                       % Nitrided AISI 4140 core Brinell Hardness
St = 0.749*Hbc + 110;            % Grade 2 Nitrided Through Hardened
Yn = 1.3558*power(N,-0.0178);   % Ctress Cycle Factor;
Kt = 1;
Kr = 1.25;                      % Reliability = 0.999
B_Strength = St*Yn/(Kt*Kr);

Hbs = 700;               % Nitralloy Case brinell hardness
Sc = 2.41*Hbs + 237;
Zn = 1.4488*power(N,-0.023);
Zw = 1;
Kt = 1;
Kr = 1.25;                      % Reliability = 0.999
C_Strength = Sc*Zn*Zw/(Kt*Kr);

fos_b = B_Strength/B_Stress;
fos_c = C_Strength/C_Stress;
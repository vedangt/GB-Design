rpm_sun = 5000;
torque_inp = 88;
load toothdata

rpm_carier = rpm_sun./N(:,5);
rpm_planet = (rpm_sun-rpm_carier).*(N(:,2)./N(:,1));
torque_carier = torque_inp*N(:,5);
torque_planet = torque_inp*(N(:,2)./N(:,1))/3;


% fos_sun, fos_planet
FOS_10=[0,0,0,0,0];
FOS_20=[0,0,0,0,0,0];
FOS_30=[0,0,0,0,0];

for i = 2:169
    [sunb,sunc] = FOS_Seq(N(i,1),N(i,2),N(i,4),10,torque_inp/3,rpm_sun-rpm_carier(i),1e7);
    [planetb,planetc] = FOS_Seq(N(i,2),N(i,1),N(i,4),10,torque_planet(i),rpm_planet(i),2e7);
    FOS_10 = [FOS_10; sunb sunc planetb planetc N(i,5)];
    
    [sunb,sunc] = FOS_Seq(N(i,1),N(i,2),N(i,4),19,torque_inp/3,rpm_sun-rpm_carier(i),1e7);
    [planetb,planetc] = FOS_Seq(N(i,2),N(i,1),N(i,4),20,torque_planet(i),rpm_planet(i),2e7);
    FOS_20 = [FOS_20; sunb sunc planetb planetc N(i,5) N(i,4)];
    
    [sunb,sunc] = FOS_Seq(N(i,1),N(i,2),N(i,4),30,torque_inp/3,rpm_sun-rpm_carier(i),1e7);
    [planetb,planetc] = FOS_Seq(N(i,2),N(i,1),N(i,4),30,torque_planet(i),rpm_planet(i),2e7);
    FOS_30 = [FOS_30; sunb sunc planetb planetc N(i,5)];
end
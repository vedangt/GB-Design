N = zeros(1,6);           % a,b,s,p,r,R,m1,m2,d,Rp,Rs,l(distance btw shafts)
    for module_pln = 1.5:0.5:2
        for ring = 60:120
            for planet = 20:ring/2
                sun = ring - 2*planet;
                Reduction_pln = 1+ring/sun;
                if (floor(sun*Reduction_pln/3)==sun*Reduction_pln/3)&&(sun>14)
                if planet+2<(sun+planet)*sin(pi/3)
                if Pin_Min(sun,planet) < sun
                if (gcd(sun,planet)==1&&(gcd(planet,ring)==1))
                    ring_od = ring*module_pln+25;
                if ring_od<200
                    N = [N; sun,planet,ring,module_pln,Reduction_pln,ring_od];
                end
                end
                end
                end
                end
            end
        end
     end
save toothdata N

           
    



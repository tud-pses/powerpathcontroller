

%%

Cl = 1e-6;%470e-6;
Uout0 = 9;
Uuv1 = 10.5;

Cv1 = @(U1) Cl * ( (U1 - Uout0) ./ (U1 - Uuv1) - 1 );


vU1 = (10.6:0.1:14.5).';

plot(vU1, Cv1(vU1) * 1e6);

%ylabel('Cv1 [uF]');
ylabel('Cv1 / Cl');

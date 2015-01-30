% pH vs Höhen
% einlesen pH und ml
% relative Höhen berechnen
relheight1= heights1/maxPeak1;
relheight2= heights2/maxPeak2;
relheight3= heights3/maxPeak3;
% Glätten & Interpolieren 
 xi= linspace(min(pH), max(pH), 1000);
[polyheight1] = polyinterp(pH, relheight1, xi, 9,2,0);
[polyheight2] = polyinterp(pH, relheight2, xi, 5,2,0);
[polyheight3] = polyinterp(pH, relheight3, xi, 6,1,0);
%figur interpolation überprüfen
figure()
hold on 
plot(xi,polyheight1);
plot (xi, polyheight2, 'r');
plot (xi, polyheight3, 'g');
hold off

[sgrh1] = savgol(relheight1,9,2,0);
[sgrh2] = savgol(relheight2,9,2,0);
[sgrh3] = savgol(relheight3,9,2,0)

%Für legende
figure()
hold on 
plot(2,1,'b')
plot(2,1,'r')
plot(2,1,'g')
legend('C_4H_6O_6', 'C_4H_5O_6^-','C_4H_4O_6^2^-')
% figur pH vs Höhe
plot(pH,relheight1,'x','color','b')
plot(pH,sgrh1,'b')
plot(pH,relheight2,'x','color','r')
plot(pH,sgrh2,'r')
plot(pH,relheight3,'x','color','g')
plot(pH,sgrh3,'g')
%Beschriftung
xlabel('pH')
ylabel('relative peak height')
title('Correlation of pH and Raman-peak-height (C_4H_6O_6)');
hold off
%Schnittpunkt pkS
d= abs(polyheight1(:,100)-polyheight2); 
ind= find (d==min(d));
pks1= xi(ind);
d2= abs(polyheight1-polyheight3);
ind1= find(d2==min(d2));
pks2= xi(ind1);


%% Titrationskurve pH vs ml NaOH
figure()
plot(ml, pH,'-bo')
xlabel('mL NaOH')
ylabel('pH')
title('Titration curve of 0.1 M tataric acid and 1 M NaOH');

%%Höhe vs ml NaOH
% Glätten
figure()
hold on 
plot(ml,sgrh1,'-bo')
plot(ml,sgrh2,'-ro')
plot(ml,sgrh3,'-go')
hold off
xlabel('mL NaOH')
legend('C_4H_6O_6', 'C_4H_5O_6^-','C_4H_4O_6^2^-')
title('Correlation of mL NaOH and Raman-peak-height tartaric acid')

% Corelation betwwen pH and Raman to get pKs
%
% Pia Eberhardt
% Creation date (27-01-2015)
%
% Copyright Metrohm AG. Switzerland, all rights reserved
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIRST USE SKRIPT ACETIC_ACID_2_PEAKS to get the heights
        %1)baseline correction
        %2)smoothing SG 
        %3)interpolation spline pH vs Höhen 
        
%Parameter:		
		
		% relheight = relative peak height to the max peak			
		% polyheight = curve fitting 		
		% d = point of interception out of the two peak-heights curves
%%

%load in pH and ml

%%
% calculation of relative heights
relheight1= heights1/maxPeak1;
relheight2= heights2/maxPeak2;

% smoothing & interpolation 
xi= linspace(min(pH), max(pH), 1000);
[polyheight1] = polyinterp(pH, relheight1, xi, 9,2,0);
[polyheight2] = polyinterp(pH, relheight2, xi, 9,2,0);

%for legend
figure()
hold on 
plot(2,1,'b')
plot(2,1,'r')
legend('CH_3COOH', 'CH_3COO^-')

% figur pH vs height
hold on 
plot(pH,relheight1,'x','color','b')
plot(xi,polyheight1,'b')
plot(pH,relheight2,'x','color','r')
plot(xi,polyheight2,'r')

%label
xlabel('pH')
ylabel('relative peak height')
title('Correlation of pH and Raman-peak-height (CH_3COOH)');
hold off

%pkS
d= abs(polyheight1-polyheight2); 
ind= find (d==min(d));
pks= xi(ind);

%% titration curve pH vs ml NaOH
figure()
plot(ml, pH,'-bo')
xlabel('mL NaOH')
ylabel('pH')
title('Titration curve of 0.05 M CH_3COOH and 1.00 M NaOH');

%%heights vs ml NaOH
% smoothing
[sgrh1] = savgol(relheight1,9,2,0);
[sgrh2] = savgol(relheight2,9,2,0);
figure()
hold on 
plot(ml,sgrh1,'-bo')
plot(ml,sgrh2,'-ro')
hold off
xlabel('mL NaOH')
legend('CH_3COOH', 'CH_3COO^-')
title('Correlation of mL NaOH and Raman-peak-height (CH_3COOH)')
legend('CH_3COOH', 'CH_3COO^-')

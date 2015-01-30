% super script essigsäure
% Peak hight out of RamanData
%% Here comes the description of your class
%
% Cooperation Münir Besli & Pia Eberhardt
% Creation date (09-01-2015)
%
% Copyright Metrohm AG. Switzerland, all rights reserved
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		% Here comes the description of your constructor
		%
		% spCO = RamanData			
		% wn = Wavenumber			
		% wnE = extracted Wavenumber (focus of changing Peak-area)
		% peak1= area peak 1
        % peak2= area peak 2
        % height 1= heights peak1
        % height2= heights peak2
        % maxP1 = max height peak1
        % maxP2 = max height peak2
        % maxP1 and maxP2 line fix heights 
%
%% declaration of intresting peaks
%wavenumber range wnE for changing peaks
%baseline correction
%smoothing SG 
% interpolation spline
spcO= ans
spcE = spcO(:, 530:620);
wn = 200:1:2000;
wnE = wn(530:620);
[bldata,wts,baseline,vweights] = wlsbaseline(spcE,4);
plot(800,0,'r')
hold on
plot(800,0,'b')
G1= plot(wnE, bldata', '-', 'color', 'r');
[y_hat, cm] = savgol(bldata,9,2,0);
wnEint = min(wnE):0.1:max(wnE);
ySpline = spline(wnE,y_hat,wnEint);
hold on;
G2= plot(wnEint, ySpline, 'color', 'b');
xlabel('wavenumber [cm^-^1]')
ylabel('arbitrary intensity')
legend({'non smoothed', 'smoothed'});
title('Extract from the Raman spectrum of interesting acid peaks')
hold off;
peak1 = ySpline(:,100:400)';
peak2 = ySpline(:,350:600)';
peak3= ySpline(:,650:860)'; 
%Peak 1
figure(14);
wnP1 = wnEint(100:400);
plot(wnP1, peak1);
xlabel('wavenumber [cm^-^1]');
ylabel('arbitrary intensity');
title('C_4H_6O_6');
% Peak 2
figure(15);
wnP2 = wnEint(350:600);
plot(wnP2, peak2);
xlabel('wavenumber [cm^-^1]');
ylabel('arbitrary intensity');
title('C_4H_5O_6^-')
%Peak 3
figure(16);
wnP3 = wnEint(650:860);
plot(wnP3, peak3);
xlabel('wavenumber [cm^-^1]');
ylabel('arbitrary intensity');
title('C_4H_4O_6^2^-')
%%
[maxP1, maxInd1] = max(max(peak1));
[maxP2, maxInd2] = max(max(peak2));
[maxP3, maxInd3] = max(max(peak3));
[maxP1, indP1] = max(peak1(:,maxInd1));
[maxP2, indP2] = max(peak2(:,maxInd2));
[maxP3, indP3] = max(peak3(:,maxInd3));
indP1D = wnP1(indP1);
indP2D = wnP2(indP2);
indP3D = wnP3(indP3);
% get heights
heights1 = peak1(indP1,:);
heights2 = peak2(indP2,:);
heights3 = peak3(indP3,:);
% round to be able to get right position
% max Peak 1 und 2 einlesen 
maxPeak1 = round(maxP1 * 10) / 10;
maxPeak2 = round(maxP2 * 10) /10;
maxPeak3 = round(maxP3 * 10) /10;
% plot line through heights
figure(16)
hold on
plot([indP3D indP3D], [0 maxP3]);
hold off
figure(14)
hold on 
plot([indP1D indP1D], [0 maxP1]);
hold off
figure(15)
hold on 
plot([indP2D indP2D], [0 maxP2]);
hold off
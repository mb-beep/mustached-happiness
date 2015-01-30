% Peak hight out of RamanData
%%
% Cooperation Münir Besli & Pia Eberhardt
% Creation date (09-01-2015)
%
% Copyright Metrohm AG. Switzerland, all rights reserved
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		% Parameter:
		%
		% spCO = raw RamanData		
		% wn = wavenumber			
		% wnE = extracted Wavenumber (focus of changing peak-area)
		% peak1= area peak 1
        % peak2= area peak 2
        % height 1= heights peak1
        % height2= heights peak2
        % maxP1 = max height peak1
        % maxP2 = max height peak2
        % maxP1 and maxP2 line fix heights 

%% Woriking flow
%declaration of intresting peaks
    %wavenumber range wnE for changing peaks
    %baseline correction
    %smoothing SG 
    % interpolation (spline)
%% 

%declaration of interesting peaks    
spcO= ans
spcE = spcO(:, 650:750);
wn = 200:1:2000;
wnE = wn(650:750);
% baseline corretion
[bldata,wts,baseline,vweights] = wlsbaseline(spcE,4); 

plot(900,0,'r') %for legend
hold on
plot(900,0,'b') %for legend
G1= plot(wnE, bldata', '-', 'color', 'r'); % baseline correted data
% smoothed Data with Savitzky Golay
[y_hat, cm] = savgol(bldata,9,2,0);
wnEint = min(wnE):0.1:max(wnE);
ySpline = spline(wnE,y_hat,wnEint);
hold on;
G2= plot(wnEint, ySpline, 'color', 'b'); % smoothed 
xlabel('wavenumber [cm^-^1]')
ylabel('arbitrary intensity')
legend({'non smoothed', 'smoothed'});
title('Extract from the Raman spectrum of interesting acid peaks')
hold off;
% Seperate peaks: start calculation of heights
peak1 = ySpline(:,200:600)';
peak2 = ySpline(:,600:1000)';

%Peak 1
figure(14);
wnP1 = wnEint(200:600);
plot(wnP1, peak1);
xlabel('wavenumber [cm^-^1]');
ylabel('arbitrary intensity');
title('CH_3COOH');

% Peak 2
figure();
wnP2 = wnEint(600:1000);
plot(wnP2, peak2);
xlabel('wavenumber [cm^-^1]');
ylabel('arbitrary intensity');
title('CH_3COO^-')
%% get maxima out of the spectrum for the heighest peak
[maxP1, maxInd1] = max(max(peak1));
[maxP2, maxInd2] = max(max(peak2));
[maxP1, indP1] = max(peak1(:,maxInd1));
[maxP2, indP2] = max(peak2(:,maxInd2));
indP1D = wnP1(indP1);
indP2D = wnP2(indP2);

% get heights
heights1 = peak1(indP1,:);
heights2 = peak2(indP2,:);

% round to be able to get right position

maxPeak1 = round(maxP1 * 10) / 10;
maxPeak2 = round(maxP2 * 10) /10;

% plot line through heights 
hold on
plot([indP2D indP2D], [0 maxP2]);
hold off
figure(14)
hold on 
plot([indP1D indP1D], [0 maxP1]);
hold off
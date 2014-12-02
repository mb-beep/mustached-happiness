% read spectral data from .mat files which were collected with bruker's
%  opus software using one of the bruker devices
% 01.12.2014
%%
path = uigetdir();
content = dir(path);
absorbance = [];
for i = 1:length(content)
    tmp = content(i);
    if(~tmp.isdir && ~isempty(strfind(tmp.name, '.mat')))
        tmpPath = [path filesep tmp.name];
        load(tmpPath, 'AB');
        wn = AB(:,1);
        absorbance = [absorbance AB(:,2)];
    end
end
plot(wn,absorbance);
xlabel('Wavenumbers [cm-1]');
ylabel('Absorbance');
axis([min(wn) max(wn) min(min(absorbance)) max(max(absorbance))]);
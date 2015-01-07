path='C:\Users\p-jroe\Documents\Measurements\ND_filter\MPA\19.11. Transmission\Neue Einstellung (gain=1)\ND_Filter_0.3_19.11._transm\MatLab'

%path= uigetdir();
files=dir(path);
nfiles=size(files,1);

spec = nan*ones(nfiles, 1685)';
for i=1:nfiles
    if(sum(strfind(files(i).name,'.mat'))>0)
        tmp=load([path filesep files(i).name]);
        tmp=tmp.AB;
        spec(:,i)=tmp(:,2);
    end
end
spec = spec(:,~isnan(spec(1,:)));
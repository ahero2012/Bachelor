clear all;clc
files=dir('*.tif');
a=imread(files(1).name);
minimg=uint16(4095*ones(size(a)));
anzahl=25; %Anzahl Bilder zu mitteln
n=numel(files)/anzahl; %Anzahl Mittelungen

for k=25:numel(files)-2
    if k==25
    min1=imread(files(k).name);
    end
    min1=min(min1,imread(files(k).name));
end
clear k

parfor k=1:numel(files)
    am{k}=imread(files(k).name)-min1;
    a1{k}=am{k}(1:1024,:);
    a2{k}=am{k}(1025:2048,:);
end

parfor k=1:numel(files)
    a1{k}=medfilt2(a1{k});
    a2{k}=medfilt2(a2{k});
end
%PIV_base
clear k
for i=0:(anzahl-1)
for k=(1+i):anzahl:numel(files)
    if k==1+i
    [xgrid,ygrid,uvecs,vvecs,peaks,valid,cmaps] = PIV_base (a1{k},a2{k},1,[64,64],[10,10],[0,0],[32,32],[],0);
    else
    [xgrid,ygrid,uvecs,vvecs,peaks,valid,cmaps] = PIV_base (a1{k},a2{k},1,[64,64],[10,10],[0,0],[32,32],cmaps,0);
    end
    
end
    uvec{i+1}=uvecs;vvec{i+1}=vvecs;peak{i+1}=peaks;val{i+1}=valid;cmap{i+1}=cmaps;
end
clear i k
for i=1:numel(peak)
   peak{i}=peak{i}./n; 
end
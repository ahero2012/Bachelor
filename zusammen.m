clear all;clc
file1='C:\Users\Alex\Documents\MATLAB\Sweep\s300\analyse300.mat';
file2='C:\Users\Alex\Documents\MATLAB\Sweep\s500\analyse500.mat';
file3='C:\Users\Alex\Documents\MATLAB\Sweep\s1\analyse1.mat';


m1=matfile(file1);
m2=matfile(file2);
m3=matfile(file3);

peak=m1.peak; peak2=m2.peak; peak3=m3.peak;
uvec=m1.uvec; uvec2=m2.uvec; uvec3=m3.uvec;
vvec=m1.vvec; vvec2=m2.vvec; vvec3=m3.vvec;
xgrid=m1.xgrid; ygrid=m1.ygrid;
sol={1,25};
for b=1:numel(peak) 
for i=1:size(peak{1},1)
    for l=1:size(peak{1,1},2)
         if peak{b}(i,l) >= peak3{b}(i,l)
             sol{b}(i,l)=peak3{b}(i,l);
%              uvec(b,l)=displ{1,3}(1,b,l)/0.3;
%              vvec(b,l)=displ{1,3}(2,b,l)/0.3;
         else
             sol{b}(i,l)=peak(i,l);
%              uvec(b,l)=displ{1,2}(1,b,l)/2;
%              vvec(b,l)=displ{1,2}(2,b,l)/2;
         end
    end
  
end
end
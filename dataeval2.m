clear all; clc; close all
% Load netCDF data
files=dir('*.nc');
for i = 1:numel(files)
    ncid(i)=netcdf.open(files(i).name);
end
clear i

%Get Displacementvectors(displ) and Correlationvalues(corval)
for i = 1:numel(files)
    displ{i} = double(netcdf.getVar(ncid(i),0));
    peaks{i} = double(netcdf.getVar(ncid(i),5));
end

for l=1:numel(files)
for i=1:length(displ{1}(1,1,:))
    
    for k=1:length(displ{1}(1,:,1))
        tot{l}(k,i)=sqrt(displ{l}(2,k,i).^2+displ{l}(1,k,i).^2);
        phase{l}(k,i)=atan2(displ{l}(1,k,i),displ{l}(2,k,i));
    end
    
end
end

for l=1:numel(files)
   for i=2:30
       for k=2:38
%            if tot{l}(k,i)>=2*max(mean(tot{l}))
            tot{l}(k,i)=median(median([tot{l}(k-1,i-1) tot{l}(k-1,i) tot{l}(k-1,i+1);...
            tot{l}(k,i-1) tot{l}(k,i) tot{l}(k,i+1);tot{l}(k+1,i-1) tot{l}(k+1,i) tot{l}(k+1,i-1)]));
%            end
%            if abs(phase{l}(k,i))~=abs(mean())
            phase{l}(k,i)=median(median([phase{l}(k-1,i-1) phase{l}(k-1,i) phase{l}(k-1,i+1);...
            phase{l}(k,i-1) phase{l}(k,i) phase{l}(k,i+1);phase{l}(k+1,i-1) phase{l}(k+1,i) phase{l}(k+1,i-1)]));
%            end
            displ{l}(2,k,i)=tot{l}(k,i).*cos(phase{l}(k,i));
            displ{l}(1,k,i)=tot{l}(k,i).*sin(phase{l}(k,i));
       end
   end
end
%Display results
clear i
figure(1)
for i = 1:numel(files)
    subplot(2,2,i)
    surf(peaks{1,i})
    view(2)
    colorbar
    axis([1 31 1 39])
    title(files(i).name)
end
clear i
figure(2)
for i = 1:numel(files)
    subplot(2,2,i)
    quiver(squeeze(displ{1,i}(2,:,:)),squeeze(displ{1,i}(1,:,:)))
    axis([1 31 1 39])
    title(files(i).name)
end
g=[zeros(12,39); ones(14,39); zeros(5,39)]';
for i=13:26
    peaks{2}(:,i)=zeros(1,39);
end
peaks{3}=peaks{3}.*g;
% Merging of 2 netCDF files
for i=1:size(peaks{1,1},1)
    for l=1:size(peaks{1,1},2)
         if peaks{1,3}(i,l) >= peaks{1,2}(i,l)
             sol(i,l)=peaks{1,3}(i,l);
             uvec(i,l)=displ{1,3}(1,i,l)/0.3;
             vvec(i,l)=displ{1,3}(2,i,l)/0.3;
         else
             sol(i,l)=peaks{1,2}(i,l);
             uvec(i,l)=displ{1,2}(1,i,l)/2;
             vvec(i,l)=displ{1,2}(2,i,l)/2;
         end
    end
  
end


%Plotting Merge
figure(3)
subplot(122)
surf(sol)
colorbar
view(2)
axis([1 31 1 39])
subplot(121)
x=linspace(1,39,39);
y=linspace(1,31,31);
quiver(y,x,vvec,uvec)
axis([1 31 1 39])
% quiver(vvec,uvec,10)
% figure(4)
% u=uvec;
% v=vvec;
% 
% quiver(v,u,7)
% figure(5)
% for k=[1 3 4]     
%         
%     if k==1
%         c=displ{1,k}(1,:,:);
%         d=displ{1,k}(2,:,:);
%     else
%         
%     c=c+displ{1,k}(1,:,:);
%     d=d+displ{1,k}(2,:,:);
%     
% %     else
% %         c=c;
%     end
% end
% c=c/.4;
% d=d/.4;
% quiver(squeeze(d),squeeze(c),7,'r')
% 
% xgrid=1:size(u,2);
% ygrid=1:size(u,1);
% vecs_tot=abs(uvec+vvec);
% 
% [vvec,uvec] = gradient(F)
% contourf(xgrid,ygrid,vecs_tot,'LineStyle','none')
% contourf(vec_tot)
% [x,y] = meshgrid(1:31,1:39);
% 
% startx = 0.1:0.1:1;
% starty = ones(size(startx));
% streamline(x,y,u,v,startx,starty)
% figure(6)
% streamslice(v,u,2)
% y = filter2(uvec,vvec);
% y1 = imfilter(vvec,uvec);
% for k=1:31
%     for m=1:39
%        y(k,l)=median((uvec(k,l-1),uvec(k,l),uvec(k,l+1));
%     end
% % end

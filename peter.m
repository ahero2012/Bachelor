clear all;clc;close all

files=dir('*.nc');
for i = 1:numel(files)
    ncid(i)=netcdf.open(files(i).name);
end
clear i
for i = 1:numel(files)
    displ{i} = double(netcdf.getVar(ncid(i),0));
    peaks{i} = double(netcdf.getVar(ncid(i),5));
end

clear i
for m=1:numel(files)
    for i=length(displ{m}(2,1,:))
        for k=length(displ{m}(2,:,1))
            if displ{m}(2,k,i)>=0.1*mean(max(displ{m}(2,:,:)))
                a(k,i)=displ{m}(2,k,i);
                a(k,i)=0;
                displ{m}(2,k,i)=a(k,i);
            else
            end
        end  
    end
end
clear i
x=linspace(1,199,199);
t=linspace(0,99.5,199);
for i = 1:length(x)
     
     quiver(medfilt2(squeeze(displ{1,i}(2,:,:))),medfilt2(squeeze(displ{1,i}(1,:,:))),5)
%      subplot(122)
%      quiver(conv2(squeeze(displ{1,i}(2,:,:)),h,'same'),conv2(conv2(displ{1,i}(1,:,:)),h,'same'),5)
%     contourf(sqrt(medfilt2(squeeze(displ{1,i}(2,:,:))).^2+medfilt2(squeeze(displ{1,i}(1,:,:)).^2)))
%     k=linspace(0,100*pi,2000);
%     y = sin(2*pi*5*(k-t(i)));
%     plot(k,y)
    
    drawnow update
    pause(1/6)

%     subplot(1,2,i)
%     
%     
%     plot(k,y)
%     
%     drawnow
%     pause(1/8)
end

% run karl
% filename = 'analyse1.mat';
% m = matfile(filename);
% uvec=m.uvec;
% vvec=m.vvec;
% peak=m.peak;
% xgrid=m.xgrid;
% ygrid=m.ygrid;
anzahl=m.anzahl;
x=xgrid(1,length(xgrid(1,:)));
y=ygrid(length(ygrid(:,1)),1);
a=545/40; %[px/mm]
dt=1; %[ms]

clear l i k 
%Pixel in Velocity [m/s]
for i=1:numel(peak)
   uv{i}=uvec{i}/dt/a;
   vv{i}=vvec{i}/dt/a;
end
clear l i k
%Total Displacement
for l=1:numel(peak)
for i=1:length(uv{1}(1,:))
    
    for k=1:length(uv{1}(:,1))
        tot{l}(k,i)=sqrt(uv{l}(k,i).^2+vv{l}(k,i).^2);
        phase{l}(k,i)=atan2(vv{l}(k,i),uv{l}(k,i));
    end
    
end
end
clear l i k
%Filtering Vectordata
% for l=1:numel(peak)
%    for i=2:38
%        for k=2:30
% %            if tot{l}(k,i)>=2*max(mean(tot{l}))
%             tot{l}(k,i)=median(median([tot{l}(k-1,i-1) tot{l}(k-1,i) tot{l}(k-1,i+1);...
%             tot{l}(k,i-1) tot{l}(k,i) tot{l}(k,i+1);tot{l}(k+1,i-1) tot{l}(k+1,i) tot{l}(k+1,i-1)]));
% %            end
%             
%             phase{l}(k,i)=median(median([phase{l}(k-1,i-1) phase{l}(k-1,i) phase{l}(k-1,i+1);...
%             phase{l}(k,i-1) phase{l}(k,i) phase{l}(k,i+1);phase{l}(k+1,i-1) phase{l}(k+1,i) phase{l}(k+1,i-1)]));
% 
%             uv{l}(k,i)=tot{l}(k,i).*cos(phase{l}(k,i));
%             vv{l}(k,i)=tot{l}(k,i).*sin(phase{l}(k,i));
%        end
%    end
% end

figure('units','normalized','outerposition',[0 0 1 1])

for i=1:numel(peak)
    md(i)=max(median(tot{i},2));
    mp(i)=mean(mean(phase{i}));
%     subplot(121)
    quiver(xgrid,ygrid,uv{i},vv{i})
    axis([0 x 0 y])
%     drawnow
    F1(i)=getframe;
%     subplot(122)
    surf((tot{i}))
    view(2)
    colorbar
    colormap jet
%     drawnow
    F2(i)=getframe;
%     F3(i)=getframe;
    
end
figure('units','normalized','outerposition',[0 0 1 1])
% subplot(121)
t=0:0.0067/(anzahl):0.0067;
s=-0.045*cos(2*pi*150*(t+0.005))+1.085;
plot(s)
hold on
plot(1:numel(peak),smooth(smooth(md)))
% subplot(122)

avel=mean(md); %[m/s]

figure('units','normalized','outerposition',[0 0 1 1])
 movie(F1,1,4)
 movie(F2,1,4)
% movie(F3,1,3)
clear i l k
% for i=1:numel(peak)
%     [phi{i},psi{i}]=flowfun(uv{i},vv{i});
%     imshow(cmap{i},[])
% %     surf(peak{i}./5)
%     view(2)
%     drawnow
% end
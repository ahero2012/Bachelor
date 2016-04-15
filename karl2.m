% run karl
x=xgrid(1,length(xgrid(1,:)));
y=ygrid(length(ygrid(:,1)),1);
clear l i k
%Total Displacement
parfor l=1:numel(peak)
for i=1:length(uvec{1}(1,:))
    
    for k=1:length(uvec{1}(:,1))
        tot{l}(k,i)=sqrt(uvec{l}(k,i).^2+vvec{l}(k,i).^2);
        phase{l}(k,i)=atan2(vvec{l}(k,i),uvec{l}(k,i));
    end
    
end
end
clear l i k
h=fspecial('gaussian',[3 3],0.3);

for i=1:numel(peak)
    
    phase{i}=filter2(h,phase{i});
    
end
clear i
parfor l=1:numel(peak)
   for i=2:38
       for k=2:30
           if tot{l}(k,i)>=2*max(mean(tot{l}))
            tot{l}(k,i)=median(median([tot{l}(k-1,i-1) tot{l}(k-1,i) tot{l}(k-1,i+1);...
            tot{l}(k,i-1) tot{l}(k,i) tot{l}(k,i+1);tot{l}(k+1,i-1) tot{l}(k+1,i) tot{l}(k+1,i-1)]));
           end
%            if abs(phase{l}(k,i))~=abs(mean())
%             phase{l}(k,i)=median(median([phase{l}(k-1,i-1) phase{l}(k-1,i) phase{l}(k-1,i+1);...
%             phase{l}(k,i-1) phase{l}(k,i) phase{l}(k,i+1);phase{l}(k+1,i-1) phase{l}(k+1,i) phase{l}(k+1,i-1)]));
%            end
            uvec{l}(k,i)=tot{l}(k,i).*cos(phase{l}(k,i));
            vvec{l}(k,i)=tot{l}(k,i).*sin(phase{l}(k,i));
       end
   end
end

%Filter
% parfor l=1:numel(peak)
% for i=2:38
%     for k=2:30
% %         if tot{l}(k,i)>=2*max(mean(tot{l}))
%             uvec{l}(k,i)=median(median([uvec{l}(k-1,i-1) uvec{l}(k-1,i) uvec{l}(k-1,i+1);...
%             uvec{l}(k,i-1) uvec{l}(k,i) uvec{l}(k,i+1);uvec{l}(k+1,i-1) uvec{l}(k+1,i) uvec{l}(k+1,i-1)]));
%             vvec{l}(k,i)=median(median([vvec{l}(k-1,i-1) vvec{l}(k-1,i) vvec{l}(k-1,i+1);...
%             vvec{l}(k,i-1) vvec{l}(k,i) vvec{l}(k,i+1);vvec{l}(k+1,i-1) vvec{l}(k+1,i) vvec{l}(k+1,i-1)]));
% %             tot{l}(k,i)=max(mean(tot{l}));
% %         end
%     end
% end
% end
figure('units','normalized','outerposition',[0 0 1 1])
[x,y] = meshgrid(1:39,1:31);

    startx = 0.1:0.1:1;
    starty = ones(size(startx));
for i=1:numel(peak)
   
%     subplot(121)
    quiver(xgrid,ygrid,uvec{i},vvec{i})
%     axis([0 x 0 y])
    F1(i)=getframe;
%     subplot(122)
    contourf(medfilt2(tot{i}))
    F2(i)=getframe;
%     refreshdata
%   drawnow
    
    streamline(x,y,uvec{i},vvec{i},startx,starty)
    F3(i)=getframe;
    
end
% subplot(121)
movie(F1,1,3)
% subplot(122)
movie(F2,1,3)
movie(F3,1,3)
% clear all;clc

%     for i=length(displ{2}(2,1,:))
%         for k=length(displ{2}(2,:,1))
%             a(k,i)=displ{2}(2,k,i);
%             if displ{2}(2,k,i)>=2*mean(max(displ{2}(2,:,:)))
%                 
%                 a(k,i)=0;
%                 
%             else
%             end
%         end  
%     end
%     clear i k
% % ureal=displ{1,i}(2,:,:)./130;
%     for i=length(displ{2}(1,1,:))
%         for k=length(displ{2}(1,:,1))
%             b(k,i)=displ{2}(1,k,i);
%             if displ{2}(1,k,i)>=2*mean(max(displ{2}(1,:,:)))
%                 
%                 b(k,i)=0;
%                 
%             else
%             end
%         end  
%     end
% quiver(a,b)

  u = d(phi)/dx;   v = d(phi)/dy;  %for potential flows,
  u = -d(psi)/dy;  v = d(psi)/dx;  %for solenoidal flows.
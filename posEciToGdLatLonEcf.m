function [latGdLonHgt]=posEciToGdLatLonEcf(tUtc,posEci)
%function [latGdLonHgt]=posEciToGdLatLonEcf(tUtc,posEci)

n=length(tUtc);
latGdLonHgt=zeros(n,3);
eox=initEox(tUtc(1));

if isvector(posEci)
   tEcfToEci = eox.Q * eox.R * eox.W;
   posEcf = tEcfToEci' * posEci(:);
   latGdLonHgt = posEcfToGdLLHKernal(posEcf);
else
   for k=1:n
      eox=refreshEox(eox,tUtc(k));
      tEcfToEci = eox.Q * eox.R * eox.W;
      posEcf = tEcfToEci' * posEci(k,1:3)';
      latGdLonHgt1 = posEcfToGdLLHKernal(posEcf);
      latGdLonHgt(k,:)=latGdLonHgt1(:)';
   end %end for
end %end if


end %function


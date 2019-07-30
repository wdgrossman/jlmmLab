function [latGdLonHgt] = posEcfToGdLLHKernal(posEcf)
%function [latGdLonHgt] = posEcfToGdLatLonHgtKernal(posEcf)
%
%http://clynchg3c.com/Technote/geodesy/coordcvt.pdf

eSqr = 0.006694385000; %from vallado

poleThreshold=1;  %one meter from pole
X=posEcf(1);
Y=posEcf(2);
Z=posEcf(3);

convergenceThreshold=1e-9;

p=norm([X Y]);
if p < poleThreshold
    latGd=pi*sign(Z);
    lon=nan;
    Rn=RnCalc(latGd);
    L=Z+eSqr*Rn;
    hgt=norm([L Z])-Rn;
else
    lat0=atan2(Z,p);
    for k=1:10
       lon=atan2(Y,X);
       Rn=RnCalc(lat0);
       h=(p/cos(lat0))-Rn;
       lat1=atan2(Z/p,(1.0-eSqr*Rn/(Rn+h)));
       delta=abs(lat1-lat0);
       if delta<convergenceThreshold
           latGd=lat1;
           hgt=p/cos(latGd)-Rn;
           break
       else
           lat0=lat1;
       end
    end
end
latGdLonHgt =[latGd lon hgt]';

end %function

%%
function Rn=RnCalc(lat)
eSqr = 0.006694385000;
a=6378137;
sLat=sin(lat);
Rn=a/sqrt(1.0-eSqr*sLat*sLat);
end
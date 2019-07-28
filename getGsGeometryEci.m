function [gsPosEci,gSgeodeticNormalEci]=getGsGeometryEci(tUtc,gs)

%Allocate output
n=length(tUtc);
gsPosEci=zeros(n,3);
gSgeodeticNormalEci=zeros(n,3);

%geocentric Position On Earth Surface
gsGeocentricPosEcf=getGsGeocentricPosEcf(gs);
geodeticNormalEcf=getGeodeticNormalEcf(gs);

eox=initEox(tUtc(1));
for k=1:n
    %geocentric Position On Earth Surface
    eox=refreshEox(eox,tUtc(k));
    tEcfToEci=eox.Q*eox.R*eox.W;
    gsPosEci1=tEcfToEci*gsGeocentricPosEcf;
    gsPosEci(k,:)=gsPosEci1(:)';
    gSgeodeticNormalEci(k,:)=tEcfToEci*geodeticNormalEcf;
end

end %function

% gs.lat = nan;
% gs.lon = nan;
% gs.hgt=nan;
% gs.name=missing;
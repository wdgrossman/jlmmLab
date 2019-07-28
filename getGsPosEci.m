function gsPosEci=getGsPosEci(tUtc,gs)
              
n=length(tUtc);
%geocentric Position On Earth Surface
gsGeocentricPosEcf=getGsGeocentricPosEcf(gs);
eox=initEox(tUtc(1));
for k=1:n
    %geocentric Position On Earth Surface
    eox=refreshEox(eox,tUtc(k));
    tEcfToEci=eox.Q*eox.R*eox.W;
    gsPosEci1=tEcfToEci*gsGeocentricPosEcf;
    gsPosEci=gsPosEci1(:)';
end
end %function

% gs.lat = nan;
% gs.lon = nan;
% gs.hgt=nan;
% gs.name=missing;
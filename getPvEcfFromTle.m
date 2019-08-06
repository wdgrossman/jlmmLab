function [t,satPvEcf]=getPvEcfFromTle(tle,clProps,resolution,t0,tf)
%Get t0 for TLE epoch
tTleEpoch = getTleTime(tle);

if nargin<4
   t0 = tTleEpoch;
end

if nargin<5
   tf=t0+seconds(clProps.maxFutureProjectionTime);
end

if nargin<3
    resolution='coarse';
end

switch upper(resolution)
    case 'COARSE'
        dt = seconds(clProps.aosLosCoarseResolution);
        
    case 'FINE'
        dt = seconds(clProps.aosLosFineResolution);
        
end %case

t=(t0:dt:tf)';
n=length(t);
satPvEcf=zeros(n,6);

typerun='c';
typeinput='e';
opsmode=2;
whichconst=84; %WGS84 gravity

[~, ~, ~, tle.satrec] = twoline2rv(tle.line1, tle.line2, typerun, typeinput, opsmode, whichconst);
% dtInMinutes=seconds(dt)/60;
eox=initEox(t0);
for k=1:n
    elapsedTimeInMinutes=minutes(t(k)-tTleEpoch);
   [tle.satrec, r0temeKm, v0temeKmPerSec] = sgp4(tle.satrec, elapsedTimeInMinutes);
   r0teme=r0temeKm(:)*1000;
   v0teme=v0temeKmPerSec(:)*1000;
   eox=refreshEox(eox,t(k));
   tm = temeToeciDcm(t(k),eox);  %eox input not necessary but greatly speeds up calculation
   tEcfToEci=eox.Q*eox.R*eox.W;
   tEcfToEciDot=eox.Q*eox.Rdot*eox.W;
   satPeci=(tm*r0teme);
   satVeci=(tm*v0teme);
   satPEcf1=tEcfToEci'*satPeci;
   satVEcf1=tEcfToEci'*satVeci + tEcfToEciDot'*satPeci;
   satPvEcf(k,:)=[satPEcf1' satVEcf1'];
end



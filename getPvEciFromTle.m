function [t,satPvEci]=getPvEciFromTle(tle,clProps)

t0= getTleTime(tle);
tf=t0+seconds(clProps.futureProjectionTime);
dt=seconds(clPropsminUsefulContactDuration);
t=(t0:dt:tf)';
n=length(t);
satPvEci=zeros(n,6);

typerun='c';
typeinput='e';
opsmode=2;
whichconst=84; %WGS84 gravity

[~, ~, ~, satrec] = twoline2rv(longstr1, longstr2, typerun, typeinput, opsmode, whichconst);
dtInMinutes=seconds(dt)/60;
for k=1:n
   [satrec, r0, v0] = sgp4(satrec, dtInMinutes);
   tm = temeToeciDcm(t(k));
   satPvEci(k,1:3)=(tm*r0(:))';
   satPvEci(k,4:6)=(tm*v0(:))';
end



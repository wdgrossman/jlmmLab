function h=plotPasses(tle,gs)

clProps = getContactListProperties;
[tUtc,satPvEci]=getPvEciFromTle(tle,clProps);
gsPosEci=getGsGeometryEci(tUtc,gs);

satLLH=posEciToGdLatLonEcf(tUtc,satPvEci(:,1:3));
gsLLH=posEciToGdLatLonEcf(tUtc(1),gsPosEci);
rToD=180/pi;


satLatDeg=satLLH(:,1)*rToD;
satLonDeg=satLLH(:,2)*rToD;

gsLatDeg=gsLLH(1,1)*rToD;
gsLonDeg=gsLLH(1,2)*rToD;

[satLatDeg,satLonDeg] = blankRetrace(satLatDeg,satLonDeg);

isInView=isInViewKernal(tle,gs, clProps);
isNotInView=~isInView;
% [0.87 0.49 0]

n=length(satLonDeg);
inViewSelector=ones(n,1);
inViewSelector(isNotInView)=nan;

satLatDegInView=satLatDeg.*inViewSelector;
satLonDegInView=satLonDeg.*inViewSelector;


plot(satLonDeg,satLatDeg,'b')
hold on
plot(satLonDegInView,satLatDegInView,'r','LineWidth',2)
plot(gsLonDeg, gsLatDeg ,'ks','LineWidth',2);
hold off

end %function

%%

function [satLatDeg,satLonDeg] = blankRetrace(satLatDeg,satLonDeg)

dLat=abs(diff(satLatDeg));
dLon=abs(diff(satLonDeg));
i=dLat>60 | dLon>60;
satLatDeg(i)=nan;
satLonDeg(i)=nan;

end %function
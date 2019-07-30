function isInView=isInViewKernal(tle,gs, clProps)
%Extract synonyms


%create list of satellite positions, J2000

%Allocate Output

[t,satPvEci]=getPvEciFromTle(tle,clProps);
 
%Allocate Output
numSatPos=length(t);
isInView=false(numSatPos,1);

%get ground station zenith-looking vectors eci
[gsPosEci,gsGeodeticNormalEci]=getGsGeometryEci(t,gs);

for k=1:numSatPos
    satVisibility1=satIsVisible(satPvEci(k,1:3)',...
                                gsPosEci(k,:)',...
                                gsGeodeticNormalEci(k,:)',...
                                clProps.minElevationAngle);
                            
    isInView(k) = satVisibility1;
end

end %function

% contact.aos=NaT;
% contact.los=NaT;
% contact.gsName=missing;
% contact.satName=missing;
       
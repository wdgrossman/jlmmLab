function contactList=getContactTimesKernal(tle,gs, clProps,resolution,t0,tf)
if nargin < 5
    t0 = getTleTime(tle);
end

if nargin < 6
    tf = t0+seconds(clProps.maxFutureProjectionTime);
end

%Allocate Output
contactList(1:clProps.maxContactListLength)=dummyContactStructure;
clWorkingEntry=dummyContactStructure;

%[t,satPvEci]=getPvEciFromTle(tle,clProps,resolution,t0,tf);
 [t,satPvEcf]=getPvEcfFromTle(tle,clProps,resolution,t0,tf);
 
%get ground station zenith-looking vectors eci
%[gsPosEci,gsGeodeticNormalEci]=getGsGeometryEci(t,gs);
gsPosEcf=getGsGeocentricPosEcf(gs);
gsGeodeticNormalEcf=getGeodeticNormalEcf(gs);


contactListPointer=0;
numSatPos=length(t);
satVisibility0=false;
for k=1:numSatPos
    [satVisibility1,~,~]=satIsVisible(satPvEcf(k,1:3)',...
                                        gsPosEcf,...
                                        gsGeodeticNormalEcf,...
                                        clProps.minElevationAngle);
                            
    courseAosState = ~satVisibility0 &&  satVisibility1;
    courseLosState =  satVisibility0 && ~satVisibility1;
    
    satVisibility0=satVisibility1;
        
    if courseAosState
        clWorkingEntry.aos=t(k);
        %[tFineAos,tFineLos]=getFineAosLos(k,t,satPvEci,gsPosEci,clProps.minElevationAngle);
        %contactList(contactListPointer) = makeContactEntry(tFineAos,tFineLos,tle(k),gs(k));
    end
    
    if courseLosState
      clWorkingEntry.los=t(k);
    end
    
    %If you have both aos and los
    contactPassFound = ~isnat(clWorkingEntry.aos) && ~isnat(clWorkingEntry.los);
    if contactPassFound
        contactListPointer=contactListPointer+1;
        contactList(contactListPointer)=clWorkingEntry;
        
        %clear times
        clWorkingEntry.aos=NaT;
        clWorkingEntry.los=NaT;
    end
end
if contactListPointer==0
    contactList=[];
else
    contactList=contactList(1:contactListPointer);
end

end %function

% contact.aos=NaT;
% contact.los=NaT;
% contact.gsName=missing;
% contact.satName=missing;
       
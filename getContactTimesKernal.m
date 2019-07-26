function contactList=getContactTimesKernal(tle,gs,futureProjectionTime,minUsefulContactDuration,maxContactListLength,minElevationAngle)
%create list of satellite positions, J2000

%Allocate Output
contactList(1:maxContactListLength)=dummyContactStructure;

[t,satPvEci]=getPvEciFromTle(tle,...
                          minUsefulContactDuration,...
                          futureProjectionTime,...
                          minUsefulContactDuration);
% numSatPos=length(t);                      

%Calculate satellite position unit vector, eci
% satPosEci=PVeci(:,1:3);
% OrbitRadius=sqrt(sum(satPosEci.*satPosEci,2));
% satPosUnitVectorEci=satPosEci./repmat(OrbitRadius,1,3);
%                    
%get ground station zenith-looking vectors eci
gsPosEci=getGsPosEci(t,gs);


contactListPointer=0;
numSatPos=length(t);
satVisibility0=false;
for k=1:numSatPos
    satVisibility1=satIsVisible(satPvEci(k,1:3)',gsPosEci(k,1:3)',minElevationAngle);
    courseAosState = ~satVisibility0 &&  satVisibility1;
    %courseLosState =  satVisibility0 && ~satVisibility1;
    
    if courseAosState
        contactListPointer=contactListPointer+1;
        [tFineAos,tFineLos]=getFineAosLos(k,t,satPvEci,gsPosEci,minElevationAngle);
        contactList(contactListPointer) = makeContactEntry(tFineAos,tFineLos,tle(k),gs(k));
    end
end
    
contactList=contactList(1:contactListPointer);





end %function
       
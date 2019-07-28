function contactList=getContactTimesKernal(tle,gs, clProps)
%Extract synonyms


%create list of satellite positions, J2000

%Allocate Output
contactList(1:maxContactListLength)=dummyContactStructure;

[t,satPvEci]=getPvEciFromTle(tle,clProps);
 
%get ground station zenith-looking vectors eci
gsPosEci=getGsPosEci(t,gs);

contactListPointer=0;
numSatPos=length(t);
satVisibility0=false;
for k=1:numSatPos
    satVisibility1=satIsVisible(satPvEci(k,1:3)',gsPosEci(k,1:3)',clProps.minElevationAngle);
    courseAosState = ~satVisibility0 &&  satVisibility1;
    %courseLosState =  satVisibility0 && ~satVisibility1;
    
    if courseAosState
        contactListPointer=contactListPointer+1;
        %[tFineAos,tFineLos]=getFineAosLos(k,t,satPvEci,gsPosEci,clProps.minElevationAngle);
        %contactList(contactListPointer) = makeContactEntry(tFineAos,tFineLos,tle(k),gs(k));
    end
end
    
contactList=contactList(1:contactListPointer);





end %function
       
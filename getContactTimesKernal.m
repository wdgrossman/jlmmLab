function contactList=getContactTimesKernal(tle,gs, clProps)
%Extract synonyms


%create list of satellite positions, J2000

%Allocate Output
contactList(1:clProps.maxContactListLength)=dummyContactStructure;
clWorkingEntry=dummyContactStructure;


[t,satPvEci]=getPvEciFromTle(tle,clProps);
 
%get ground station zenith-looking vectors eci
[gsPosEci,gsGeodeticNormalEci]=getGsGeometryEci(t,gs);


contactListPointer=0;
numSatPos=length(t);
satVisibility0=false;
for k=1:numSatPos
%     if ~mod(k-1,60)
%         disp([k numSatPos])
%     end
    satVisibility1=satIsVisible(satPvEci(k,1:3)',...
                                gsPosEci(k,:)',...
                                gsGeodeticNormalEci(k,:)',...
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
    
contactList=contactList(1:contactListPointer);

end %function

% contact.aos=NaT;
% contact.los=NaT;
% contact.gsName=missing;
% contact.satName=missing;
       
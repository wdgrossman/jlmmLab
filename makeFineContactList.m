function contactList=makeFineContactList(coarseContactList,tle, gs, clProps)
numContacts=length(coarseContactList);
contactList(1:numContacts)=dummyContactStructure;

for k=1:numContacts
    clWorkingEntry=coarseContactList(k);
    t0 = clWorkingEntry.aos-seconds(clProps.aosLosCoarseResolution);
    tf = clWorkingEntry.los+seconds(clProps.aosLosCoarseResolution);
    contactList(k)=getContactTimesKernal(tle,gs, clProps,'fine',t0,tf);  
end
end



% contact.aos=NaT;
% contact.los=NaT;
% contact.gsName=missing;
% contact.satName=missing;

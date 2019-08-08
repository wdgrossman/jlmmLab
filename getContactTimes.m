function contactList = getContactTimes(tleList,gsList,t0)
% function contactList = getContactTimes(tleList,gsList,t0)

if nargin < 3
    t0=[];
end
    

clProps = getContactListProperties;

%Allocate Output
contactList(1:clProps.maxContactListLength)=dummyContactStructure;

numSat=length(tleList);
numGs=length(gsList);

numContacts=0;
for j=1:numSat
    for k=1:numGs
        coarseContactList=makeCoarseContactList(tleList(j), gsList(k), clProps,t0);
        numCoarseContacts=length(coarseContactList);
        if numCoarseContacts==0
            continue
        else 
            fineContactList=makeFineContactList(coarseContactList,tleList(j), gsList(k), clProps);
            contactListStartPointer=numContacts+1;
            numContacts=numContacts+numCoarseContacts;
            contactList(contactListStartPointer:numContacts)=fineContactList;
        end
        
    end
end
contactList=contactList(1:numContacts);

end %function

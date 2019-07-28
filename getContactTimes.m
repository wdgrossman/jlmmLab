function contactList = getContactTimes(tleList,gsList)
% function contactList = getContactTimes(tleList,gsList)

clProps = getContactListProperties;

%Allocate Output
contactList(1:maxContactListLength)=dummyContactStructure;

numSat=length(tleList);
numGs=length(gsList);

contactListPointer=1;
for j=1:numSat
    for k=1:numGs
       contactList1=getContactTimesKernal(tleList(j), gsList(k), clProps);
       n=length(contactList1);
       if n>0
           contactListLength=contactListPointer+n;
           contactList(contactListPointer:contactListLength)=contactList1;
           contactListPointer=contactListLength+1;  %advance pointer
       end
    end
end
contactList=contactList(1:contactListLength);

end %function

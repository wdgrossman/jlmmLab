function contactList = getContactTimes(tleList,gsList,maxFutureProjectionTime,minUsefulContactDuration,maxContactListLength,minElevationAngle)
% function contactList = getContactTimes(tleList,gsList,maxFutureProjectionTime,minUsefulContactDuration,maxContactListLength,minElevationAngle)

if nargin<6
    minElevationAngle=10*pi/180;  %default minimum elevation angle is 10 deg
end

if nargin<5
    maxContactListLength=100;
end

if nargin<4
    minUsefulContactDuration= 4*60;
end

if nargin<3
    numSecInDay=86400;
    maxFutureProjectionTime = 1 * numSecInDay;
end


%Allocate Output
contactList(1:maxContactListLength)=dummyContactStructure;

numSat=length(tleList);
numGs=length(gsList);

contactListPointer=1;
for j=1:numSat
    for k=1:numGs
       contactList1=getContactTimesKernal(tleList(j),...
                                          gsList(k),...
                                          maxFutureProjectionTime,...
                                          minUsefulContactDuration,...
                                          maxContactListLength,...
                                          minElevationAngle);
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

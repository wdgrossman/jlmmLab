function S = getContactListProperties
%constants
numSecInDay=86400;
numDaysToPropagate=1;

S.minElevationAngle=10*pi/180;  %default minimum elevation angle is 10 deg
S.maxContactListLength=100;
S.minUsefulContactDuration= 4*60;
S.maxFutureProjectionTime = numDaysToPropagate * numSecInDay;
S.maxContactListLengthPerSat=10;
S.aosLosTimeResolution=1;


end
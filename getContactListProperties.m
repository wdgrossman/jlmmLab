function S = getContactListProperties
%constants
numSecInDay=86400;
numDaysToPropagate=1;

S.minElevationAngle=0*pi/180;  %default minimum elevation angle is 10 deg
S.maxContactListLength=100;
S.minUsefulContactDuration= 4*60;
S.maxFutureProjectionTime = numDaysToPropagate * numSecInDay;
S.maxContactListLengthPerSat=10;
S.aosLosFineResolution=0.5;
S.aosLosCoarseResolution=S.minUsefulContactDuration;

end
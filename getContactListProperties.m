function S = getContactListProperties
%constants
numSecInDay=86400;

S.minElevationAngle=10*pi/180;  %default minimum elevation angle is 10 deg
S.maxContactListLength=100;
S.minUsefulContactDuration= 4*60;
S.maxFutureProjectionTime = 1 * numSecInDay;
end
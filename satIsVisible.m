function [visibilityFlag,az,el]=satIsVisible(satPos,gsPos,geodeticNormal,minElevationAngle)
%For now, ignor satellite height
az=0;  %TBD
el=0;  %TBD
lineOfSight=satPos(:)-gsPos(:);
lineOfSightUnitVector=lineOfSight/norm(lineOfSight);
visibilityFlag = lineOfSightUnitVector'*geodeticNormal>=sin(minElevationAngle);


end
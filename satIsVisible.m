function visibilityFlag=satIsVisible(satPosEci,gsPosEci,geodeticNormalEci,minElevationAngle)
%For now, ignor satellite height

lineOfSight=satPosEci(:)-gsPosEci(:);
lineOfSightUnitVector=lineOfSight/norm(lineOfSight);
visibilityFlag = lineOfSightUnitVector'*geodeticNormalEci>=sin(minElevationAngle);


end
function t=getTleTime(tle)
% See: http://celestrak.com/columns/v04n03/#FAQ01

timestring=tle.line1(19:32);
t=tleTimeToDatetime(timestring);
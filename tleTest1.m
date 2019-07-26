function [satrec, r0, v0, r1, v1]=tleTest1
% TLE Line1: 1 01158U 00001A   19178.54166667  .00000000  00000-0  99885-4 0    09 
% TLE Line2: 2 01158  97.7960 110.3528 0011579 245.8871 114.1179 14.91363939    05 
% TLE Line1: 1 01158U 00001A   19178.66666667  .00000000  00000-0  10021-3 0    01 
% TLE Line2: 2 01158  97.7956 155.4761 0011581 245.8949 114.1102 14.91363925    09 

typerun='c';
typeinput='e';

%opsmode definition ?
%https://www.celestrak.com/NORAD/documentation/spacetrk.pdf
% 1=SGP
% 2 = SGP4
% 3 = SDP4
% 4 = SGP8
% 5 = SDP8

opsmode=2;
whichconst=84; %WGS84 gravity
longstr1='1 01158U 00001A   19178.54166667  .00000000  00000-0  99885-4 0    09';
longstr2='2 01158  97.7960 110.3528 0011579 245.8871 114.1179 14.91363939    05';

tFromEpochMinutes = 3*60;
[startmfe, stopmfe, deltamin, satrec] = twoline2rv(longstr1, longstr2, typerun, typeinput, opsmode, whichconst);
[satrec, r0, v0] = sgp4(satrec, tFromEpochMinutes);

%two hours later
longstr1='1 01158U 00001A   19178.66666667  .00000000  00000-0  10021-3 0    01';
longstr2='2 01158  97.7956 155.4761 0011581 245.8949 114.1102 14.91363925    09';
tFromEpochMinutes = 0;
[startmfe, stopmfe, deltamin, satrec] = twoline2rv(longstr1, longstr2, typerun, typeinput, opsmode, whichconst);
[satrec, r1, v1] = sgp4(satrec, tFromEpochMinutes);
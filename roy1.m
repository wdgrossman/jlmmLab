function cl=roy1
gs=dummyGsStructure;
tle=dummyTleStructure;

gs.lat = 42.945077*pi/180;
gs.lon = -71.629419*pi/180;
gs.hgt=204.62;
gs.name="BOSS, NEPTUNE";

tle.line1='1 01158U 99999    19067.00000000  .00000000  00000-0  13629-3 0    00';
tle.line2='2 01158  51.5777 325.9204 0011832 254.0855  82.4635 15.40925754    08';

%getting contact times
cl = getContactTimes(tle,gs);

%plotting
plotPasses(tle,gs);
end %function

%% ==================================

% BOSS,NEPTUNE,42.945077,-71.629419,204.62,TDTU
% 
% 
% 
% Walter, 
% 
% Below please see a TLE for S/C 1158 and the Ground Station AOS/LOS.
% Our simulation (attached) shows AOS (edge of footprint) at 17:31:27, and LOS
% (edge of footprint) at 17:42:25.  AOS is at least 3 minutes too soon and LOS 
% is at least 3 minutes too soon.  Please note that the TLE we received from Neptune
% for the given Ground Station Contacts is Julian Day 67, which is March 10, 
% several months behind the Contact date (7/10).
% 
% I have also attached a timeline view.
% 
% Thoughts?
% 
% Thanks,
% 
% Roy
% 
% 
% 
% tles.setLINE1("1 01158U 99999    19067.00000000  .00000000  00000-0  13629-3 0    00");
% tles.setLINE2("2 01158  51.5777 325.9204 0011832 254.0855  82.4635 15.40925754    08");
% 
% <Contact>
%     <ContactID>0x5085D514</ContactID>
%     <AOS readable="2019-07-10T17:34:12Z">1562780052.0</AOS>
%     <LOS readable="2019-07-10T17:45:22Z">1562780722.0</LOS>
%     <REV>01926</REV>
%     <SITE>BOSS-A</SITE>
%     <MAXEL>86.7</MAXEL>
%     <EQX>245.6</EQX>
%     <PercentSun>100</PercentSun>
%     <RiseAZ>234.5</RiseAZ>
%     <RiseRange>2392.1</RiseRange>
%     <Active>YES</Active>
% </Contact>
% 
% 
% Roy Donehower
% (O): 303-577-2636
% (M): 303-475-5733
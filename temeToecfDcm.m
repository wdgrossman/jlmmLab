% ----------------------------------------------------------------------------
%
%                           function teme2ecef
%
%  this function trsnforms a vector from the true equator mean equniox frame
%    (teme), to an earth fixed (ITRF) frame.  the results take into account
%    the effects of sidereal time, and polar motion.
%
%  author        : david vallado                  719-573-2600   30 oct 2017
%
%  revisions
%
%  inputs          description                    range / units
%    rteme       - position vector teme           km
%    vteme       - velocity vector teme           km/s
%    ateme       - acceleration vector teme       km/s2
%    ttt         - julian centuries of tt         centuries
%    jdut1       - julian date of ut1             days from 4713 bc
%    lod         - excess length of day           sec
%    xp          - polar motion coefficient       rad
%    yp          - polar motion coefficient       rad
%    eqeterms    - use extra two terms (kinematic) after 1997  0, 2
%
%  outputs       :
%    tm       - teme-to-ecf transformation matrix
%    tmDot    - derivative, teme-to-ecf transformation matrix
%
%  locals        :
%    st          - matrix for pef - tod 
%    pm          - matrix for ecef - pef 
%
%  coupling      :
%   gstime       - greenwich mean sidereal time   rad
%   polarm       - rotation for polar motion      pef - ecef
%
%  references    :
%    vallado       2013, 231-233
%
% [recef, vecef, aecef] = teme2ecef( rteme, vteme, ateme, ttt, jdut1, lod, xp, yp, eqeterms );
% ----------------------------------------------------------------------------

function [tm,tmDot] = temeToecfDcm(tUtc)
deg2rad = pi/180.0;

eox=initEox(tUtc);
eop=eox.eop;
xp=eop(5);
yp=eop(6);
dUt1=eop(7);
lod=eop(8);

j2000EpochJd=2451545.0;
julianCenturyInDays=36525;
TT=tUtc+seconds(eox.dAt+32.184);
ttt=(datetimeToJd(TT)-j2000EpochJd)/julianCenturyInDays;

jdut1 = datetimeToJd(tUtc+seconds(dUt1));
% ------------------------ find gmst --------------------------
gmst= gstime( jdut1 );

% find omega from nutation theory
omega=  125.04452222  + (   -6962890.5390 *ttt + ...
                7.455 *ttt*ttt + 0.008 *ttt*ttt*ttt )  / 3600.0;
omega= rem(omega,360.0) * deg2rad;
        
% ------------------------ find mean ast ----------------------
% teme does not include the geometric terms here
% after 1997, kinematic terms apply
if 1 %(jdut1 > 2450449.5 ) && (eqeterms > 0)
            gmstg = gmst ...
                   + 0.00264*pi /(3600*180)*sin(omega) ...
                   + 0.000063*pi /(3600*180)*sin(2.0 *omega);
% else
%             gmstg = gmst;
end

gmstg = rem(gmstg, 2.0*pi);

st = [cos(gmstg) -sin(gmstg) 0
      sin(gmstg)  cos(gmstg) 0
      0           0          1 ];
  
thetasa    = 7.29211514670698e-05 * (1.0  - lod/86400.0 );
stDot = thetasa*[-sin(gmstg) -cos(gmstg) 0
                  cos(gmstg) -sin(gmstg) 0
                   0          0          0 ];  
  
pm = polarm(xp,yp,ttt,'80');

tm = pm'*st';
tmDot=pm'*stDot';

end
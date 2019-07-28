function tm = temeToeciDcm(tUtc,eox)
%function tm = temeToeciDcm(tUtc,eox)
%
%
%                           function teme2eci
%
%  this function transforms a vector from the true equator mean equinox system,
%    (teme) to the mean equator mean equinox (j2000) system.
%
%  author        : david vallado                  719-573-2600   30 oct 2017
%
%  inputs          description                    range / units
%    ttt         - julian centuries of tt         centuries
%    ddpsi       - delta psi correction to gcrf   rad
%    ddeps       - delta eps correction to gcrf   rad
%
%  outputs       :
%    tm          - DCM to transform teme frame (TLE output) to J2000 frame

%
%  locals        :
%    prec        - matrix for eci - mod
%    nutteme     - matrix for mod - teme - an approximation for nutation
%    eqeg        - rotation for equation of equinoxes (geometric terms only)
%    tm          - combined matrix for teme2eci
%
%  coupling      :
%   precess      - rotation for precession        eci - mod
%   nutation     - rotation for nutation          eci - tod
%
%  references    :
%    vallado       2013, 231-233

%Adapted from Vallado code by:
% Walter Grossman
% NASK
% 12 July 2019
if nargin<2
  eox=initEox(tUtc);
else
    eox=refreshEox(eox,tUtc);
end

ddpsi=eox.eop(9);
ddeps=eox.eop(10);
j2000EpochJd=2451545.0;
julianCenturyInDays=36525;
TT=tUtc+seconds(eox.dAt+32.184);
ttt=(datetimeToJd(TT)-j2000EpochJd)/julianCenturyInDays;

prec = precess ( ttt, '80' );

[deltapsi, ~, meaneps, ~, nut] = nutation  (ttt, ddpsi, ddeps );
        
% ------------------------ find eqeg ----------------------
% rotate teme through just geometric terms 
eqeg = deltapsi* cos(meaneps);

eqeg = rem(eqeg, 2.0*pi);

eqe =[ cos(eqeg) sin(eqeg) 0.0
      -sin(eqeg) cos(eqeg) 0.0
       0.0       0.0       1.0  ];

% eqe(1,1) =  cos(eqeg);
% eqe(1,2) =  sin(eqeg);
% eqe(1,3) =  0.0;
% eqe(2,1) = -sin(eqeg);
% eqe(2,2) =  cos(eqeg);
% eqe(2,3) =  0.0;
% eqe(3,1) =  0.0;
% eqe(3,2) =  0.0;
% eqe(3,3) =  1.0;

tm = prec * nut * eqe';

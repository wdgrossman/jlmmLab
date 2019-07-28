function gsGeocentricPosEcf=getGsGeocentricPosEcf(gs)

%from http://clynchg3c.com/Technote/geodesy/coordcvt.pdf
%WGS-84 constants
f=1.0/298.257223563; % WGS-84
a=6378137;  %earth Equatorial Radius

b=a*(1-f);
eSqr=1.0-(b*b/(a*a));

%Trig function of geodetic lat/lon
cLat=cos(gs.lat);
sLat=sin(gs.lat);
cLon=cos(gs.lon);
sLon=sin(gs.lon);
h=gs.hgt;

Rn=a/sqrt(1-eSqr*sLat*sLat);

gsGeocentricPosEcf=[(Rn+h)*cLat*cLon
                    (Rn+h)*cLat*sLon
                    ((1.0-eSqr)*Rn+h)*sLat];

end
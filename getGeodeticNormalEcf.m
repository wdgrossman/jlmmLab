function geodeticNormalEcf=getGeodeticNormalEcf(gs)

cLat=cos(gs.lat);
sLat=sin(gs.lat);
cLon=cos(gs.lon);
sLon=sin(gs.lon);

geodeticNormalEcf=[cLat*cLon
                   cLat*sLon
                   sLat];




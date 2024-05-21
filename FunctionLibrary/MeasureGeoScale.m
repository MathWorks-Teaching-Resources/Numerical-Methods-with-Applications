function longScale = MeasureGeoScale
    fig = uifigure("Name","Measure 2 km");
    gx = geoaxes("Parent",fig);
    geoplot(gx,48.7,-121.658)
    geolimits(gx,[48.63,48.75],[-121.665 -121.65])
    geobasemap(gx,'satellite')
    roi = drawpolygon(gx);
    longVals = roi.Position(:,2);

    longScale = 2/(longVals(2)-longVals(1));

end
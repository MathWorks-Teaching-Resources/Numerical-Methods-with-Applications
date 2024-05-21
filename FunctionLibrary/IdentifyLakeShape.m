function roi = IdentifyLakeShape
    fig = uifigure("Name","Trace the outline of the lake");
    gx = geoaxes("Parent",fig);
    geoplot(gx,48.7,-121.658)
    geolimits(gx,[48.63,48.75],[-121.665 -121.65])
    geobasemap(gx,'satellite')
    roi = drawpolygon(gx);
end
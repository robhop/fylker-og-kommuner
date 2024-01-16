import * as fs from 'node:fs';
import * as turf from '@turf/turf';
import * as polyclip from "polyclip-ts"

const fylker = JSON.parse(fs.readFileSync('temp/fylker2021.geojson'));

var clipped = polyclip.union(
    fylker.features[0].geometry.coordinates,
    fylker.features[1].geometry.coordinates,
    fylker.features[2].geometry.coordinates,
    fylker.features[3].geometry.coordinates,
    fylker.features[4].geometry.coordinates,
    fylker.features[5].geometry.coordinates,
    fylker.features[6].geometry.coordinates,
    fylker.features[7].geometry.coordinates,
    fylker.features[8].geometry.coordinates,
    fylker.features[9].geometry.coordinates,
    fylker.features[10].geometry.coordinates
);

var poly = turf.multiPolygon(clipped, { "name": "Norge" });

fs.writeFileSync(
    "temp/full/Norge.geojson",
    JSON.stringify(turf.featureCollection([poly])));
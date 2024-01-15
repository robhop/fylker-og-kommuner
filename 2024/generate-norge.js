import * as fs from 'node:fs';
import * as turf from '@turf/turf';
import * as polyclip from "polyclip-ts"

const mask_string = fs.readFileSync('temp/fylker2021-WGS84.geojson', 'utf8');
const maskn = JSON.parse(mask_string);

var clipped = polyclip.union(
    maskn.features[0].geometry.coordinates,
    maskn.features[1].geometry.coordinates,
    maskn.features[2].geometry.coordinates,
    maskn.features[3].geometry.coordinates,
    maskn.features[4].geometry.coordinates,
    maskn.features[5].geometry.coordinates,
    maskn.features[6].geometry.coordinates,
    maskn.features[7].geometry.coordinates,
    maskn.features[8].geometry.coordinates,
    maskn.features[9].geometry.coordinates,
    maskn.features[10].geometry.coordinates
);

var poly = turf.multiPolygon(clipped, { "name": "Norge" });

fs.writeFileSync(
    "temp/full/Norge.geojson",
    JSON.stringify(turf.featureCollection([poly])));
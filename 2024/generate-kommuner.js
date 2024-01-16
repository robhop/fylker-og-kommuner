import * as fs from 'node:fs';
import * as turf from '@turf/turf';
import utf8 from 'utf8';

const kommuner = JSON.parse(fs.readFileSync('temp/kommuner2024.geojson', 'utf8'));
const norge = JSON.parse(fs.readFileSync('temp/full/Norge.geojson', 'utf8'));

var outFeatures = kommuner.features.map(element => {
        var intersect = turf.intersect(element, norge.features[0]);
        intersect.properties = {
            "id": element.properties.kommunenummer,
            "kommunenummer": element.properties.kommunenummer,
            "name": utf8.decode(element.properties.kommunenavn),
            "kommunenavn": utf8.decode(element.properties.kommunenavn),
        };
        console.log(intersect.properties.kommunenavn + " " + intersect.properties.kommunenummer);
        return intersect
});
fs.writeFileSync("temp/full/Kommuner.geojson", JSON.stringify(turf.featureCollection(outFeatures)));
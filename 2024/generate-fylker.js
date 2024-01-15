
import * as fs from 'node:fs';
import * as turf from '@turf/turf';
import * as polyclip from "polyclip-ts"

const fylker = JSON.parse(fs.readFileSync('temp/Basisdata_0000_Norge_25833_Fylker_GeoJSON-WGS84.geojson', 'utf8'));
const norge = JSON.parse(fs.readFileSync('temp/full/Norge.geojson', 'utf8'));

var outFeatures = fylker.features.map(element => {
    var polygon = turf.multiPolygon(polyclip.intersection(
        element.geometry.coordinates,
        norge.features[0].geometry.coordinates));
    polygon.properties = {
        "id": element.properties.fylkesnummer,
        "name": element.properties.administrativenhetnavn.find(i => i.sprak == 'nor').navn,
        "fylkesnummer": element.properties.fylkesnummer,
        "fylkesnavn": element.properties.fylkesnavn,
    };
    fs.writeFileSync("temp/full/fylker/" + polygon.properties.name.replace(/ /g,"_") + ".geojson", JSON.stringify(turf.featureCollection([polygon])));
    return polygon;
});

fs.writeFileSync("temp/full/Fylker.geojson", JSON.stringify(turf.featureCollection(outFeatures)));
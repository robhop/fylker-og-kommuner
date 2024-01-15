import utf8 from 'utf8';
import fgdb from 'fgdb';
import * as fs from 'node:fs';
import * as turf from '@turf/turf';
import * as polyclip from "polyclip-ts"

const norge = JSON.parse(fs.readFileSync('temp/full/Norge.geojson', 'utf8'));

fgdb('temp/Basisdata_0000_Norge_25833_Kommuner_FGDB.gdb').then(function (objectOfGeojson) {
    objectOfGeojson.kommune.features.forEach(element => {
        var polygon = turf.multiPolygon(polyclip.intersection(
            element.geometry.coordinates,
            norge.features[0].geometry.coordinates));

        polygon.properties = {
            "id": element.properties.kommunenummer,
            "kommunenummer": element.properties.kommunenummer,
            "name": utf8.decode(element.properties.kommunenavn),
            "kommunenavn": utf8.decode(element.properties.kommunenavn),
        };
        console.log(polygon.properties.kommunenavn);
        fs.writeFileSync("temp/full/kommuner/" + polygon.properties.id + ".geojson", JSON.stringify(turf.featureCollection([polygon])));

    });
    console.log("DONE");
}, function (error) {
    console.log(error);
});

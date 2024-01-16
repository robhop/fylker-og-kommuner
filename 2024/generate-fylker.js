
import * as fs from 'node:fs';
import * as turf from '@turf/turf';

const fylker = JSON.parse(fs.readFileSync('temp/fylker2024.geojson', 'utf8'));
const norge = JSON.parse(fs.readFileSync('temp/full/Norge.geojson', 'utf8'));

var outFeatures = fylker.features.map(element => {
        var intersect = turf.intersect(element, norge.features[0]);
        intersect.properties = {
            "id": element.properties.fylkesnummer,
            "name": element.properties.administrativenhetnavn.find(i => i.sprak == 'nor').navn,
            "fylkesnummer": element.properties.fylkesnummer,
            "fylkesnavn": element.properties.fylkesnavn,
        };
        console.log(intersect.properties.name + " " + intersect.properties.id);
        return intersect
});

fs.writeFileSync("temp/full/Fylker.geojson", JSON.stringify(turf.featureCollection(outFeatures)));
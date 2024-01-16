#!/bin/bash

echo "Generate Norge"
unzip -o source/Basisdata_0000_Norge_25833_NorskeFylkerKommunerIllustrasjonsdata2021_GeoJSON.zip -d ./temp 
cat temp/fylker2021.json | npx reproject --use-epsg-io --from=EPSG:25833 --to=EPGS:4326 > tmp-f.json
npx geo2topo -q 1e5 fylker=tmp-f.json | npx toposimplify -F -P 0.5 | npx topo2geo fylker=temp/fylker2021.geojson
rm  tmp-f.json
node generate-norge.js
npx geo2topo -q 1e5 temp/full/Norge.geojson > temp/full/Norge.topojson
npx toposimplify -F -P 0.05 -o "../Norge-S.topojson" "temp/full/Norge.topojson"
npx topo2geo Norge=../Norge-S.geojson < ../Norge-S.topojson
npx toposimplify -F -P 0.1 -o "../Norge-M.topojson" "temp/full/Norge.topojson"
npx topo2geo Norge=../Norge-M.geojson < ../Norge-M.topojson
npx toposimplify -F -P 0.3 -o "../Norge-L.topojson" "temp/full/Norge.topojson"
npx topo2geo Norge=../Norge-L.geojson < ../Norge-L.topojson


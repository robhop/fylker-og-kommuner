#!/bin/bash
source ./settings.sh
mkdir -p temp/full

echo "Generate Norge"
unzip -o source/Basisdata_0000_Norge_25833_NorskeFylkerKommunerIllustrasjonsdata2021_GeoJSON.zip -d ./temp 
cat temp/fylker2021.json | npx reproject --use-epsg-io --from=EPSG:25833 --to=EPGS:4326 > temp/f.json
npx geo2topo -q $Q fylker=temp/f.json | npx toposimplify -F -P $P | npx topo2geo fylker=temp/fylker2021.geojson
rm temp/f.json
node generate-norge.js
npx geo2topo temp/full/Norge.geojson > temp/full/Norge.topojson
npx toposimplify -F -P $S -o "../Norge-S.topojson" "temp/full/Norge.topojson"
npx topo2geo Norge=../Norge-S.geojson < ../Norge-S.topojson
npx toposimplify -F -P $M -o "../Norge-M.topojson" "temp/full/Norge.topojson"
npx topo2geo Norge=../Norge-M.geojson < ../Norge-M.topojson
npx toposimplify -F -P $L -o "../Norge-L.topojson" "temp/full/Norge.topojson"
npx topo2geo Norge=../Norge-L.geojson < ../Norge-L.topojson

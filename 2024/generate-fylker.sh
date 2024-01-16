#!/bin/bash
source ./settings.sh

echo "Generate fylker"
unzip -o source/Basisdata_0000_Norge_25833_Fylker_GeoJSON.zip -d ./temp 
jq '.["Fylke"]' temp/Basisdata_0000_Norge_25833_Fylker_GeoJSON.geojson | npx reproject --use-epsg-io --from=EPSG:25833 --to=EPGS:4326 > temp/f.json
npx geo2topo -q $Q fylker=temp/f.json | npx toposimplify -F -P $P | npx topo2geo fylker=temp/fylker2024.geojson
rm temp/f.json

node generate-fylker.js
npx geo2topo temp/full/Fylker.geojson > temp/full/Fylker.topojson
npx toposimplify -F -P $S -o "../Fylker-S.topojson" "temp/full/Fylker.topojson"
npx topo2geo Fylker=../Fylker-S.geojson < ../Fylker-S.topojson
npx toposimplify -F -P $M -o "../Fylker-M.topojson" "temp/full/Fylker.topojson"
npx topo2geo Fylker=../Fylker-M.geojson < ../Fylker-M.topojson
npx toposimplify -F -P $L -o "../Fylker-L.topojson" "temp/full/Fylker.topojson"
npx topo2geo Fylker=../Fylker-L.geojson < ../Fylker-L.topojson
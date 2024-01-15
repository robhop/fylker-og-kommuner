#!/bin/bash

#unzip -o source/Basisdata_0000_Norge_25833_Fylker_GeoJSON.zip -d ./temp 
#unzip -o source/Basisdata_0000_Norge_25833_NorskeFylkerKommunerIllustrasjonsdata2021_GeoJSON.zip -d ./temp 
#unzip -o source/Basisdata_0000_Norge_25833_Kommuner_FGDB.zip -d ./temp 

#jq '.["Fylke"]' temp/Basisdata_0000_Norge_25833_Fylker_GeoJSON.geojson | npx reproject --use-epsg-io --from=EPSG:25833 --to=EPGS:4326 > temp/Basisdata_0000_Norge_25833_Fylker_GeoJSON-WGS84.geojson 
#cat temp/fylker2021.json | npx reproject --use-epsg-io --from=EPSG:25833 --to=EPGS:4326 > temp/fylker2021-WGS84.geojson

echo "Generate Norge.geojson"
#node generate-norge.js
npx geo2topo -q 1e8 temp/full/Norge.geojson > temp/full/Norge.topojson
npx toposimplify -F -P 0.02 -o "../Norge-S.topojson" "temp/full/Norge.topojson"
npx topo2geo Norge=../Norge-S.geojson < ../Norge-S.topojson
npx toposimplify -F -P 0.05 -o "../Norge-M.topojson" "temp/full/Norge.topojson"
npx topo2geo Norge=../Norge-M.geojson < ../Norge-M.topojson
npx toposimplify -F -P 0.1 -o "../Norge-L.topojson" "temp/full/Norge.topojson"
npx topo2geo Norge=../Norge-L.geojson < ../Norge-L.topojson

echo "Generate fylker"
mkdir -p temp/full/fylker
#node generate-fylker.js
#npx geojson-merge temp/full/fylker/*.geojson > temp/full/Fylker.geojson
npx geo2topo -q 1e8 temp/full/Fylker.geojson > temp/full/Fylker.topojson
npx toposimplify -F -P 0.02 -o "../Fylker-S.topojson" "temp/full/Fylker.topojson"
npx topo2geo Fylker=../Fylker-S.geojson < ../Fylker-S.topojson
npx toposimplify -F -P 0.05 -o "../Fylker-M.topojson" "temp/full/Fylker.topojson"
npx topo2geo Fylker=../Fylker-M.geojson < ../Fylker-M.topojson
npx toposimplify -F -P 0.1 -o "../Fylker-L.topojson" "temp/full/Fylker.topojson"
npx topo2geo Fylker=../Fylker-L.geojson < ../Fylker-L.topojson

echo "Generate kommuner"
mkdir -p temp/full/kommuner
#node generate-kommuner.js
#npx geojson-merge temp/full/kommuner/*.geojson > temp/full/Kommuner.geojson
npx geo2topo -q 1e8 temp/full/Kommuner.geojson > temp/full/Kommuner.topojson
npx toposimplify -F -P 0.02 -o "../Kommuner-S.topojson" "temp/full/Kommuner.topojson"
npx topo2geo Kommuner=../Kommuner-S.geojson < ../Kommuner-S.topojson
npx toposimplify -F -P 0.05 -o "../Kommuner-M.topojson" "temp/full/Kommuner.topojson"
npx topo2geo Kommuner=../Kommuner-M.geojson < ../Kommuner-M.topojson
npx toposimplify -F -P 0.1 -o "../Kommuner-L.topojson" "temp/full/Kommuner.topojson"
npx topo2geo Kommuner=../Kommuner-L.geojson < ../Kommuner-L.topojson


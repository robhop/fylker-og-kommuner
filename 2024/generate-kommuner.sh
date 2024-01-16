#!/bin/bash
source ./settings.sh

echo "Generate kommuner"
unzip -o source/Basisdata_0000_Norge_25833_Kommuner_FGDB.zip -d ./temp 
node export-fgdb.js temp/Basisdata_0000_Norge_25833_Kommuner_FGDB.gdb kommune > temp/k.json
npx geo2topo -q $Q kommuner=temp/k.json | npx toposimplify -F -P $P | npx topo2geo kommuner=temp/kommuner2024.geojson
rm temp/k.json

node generate-kommuner.js
npx geo2topo temp/full/Kommuner.geojson > temp/full/Kommuner.topojson
npx toposimplify -F -P $S -o "../Kommuner-S.topojson" "temp/full/Kommuner.topojson"
npx topo2geo Kommuner=../Kommuner-S.geojson < ../Kommuner-S.topojson
npx toposimplify -F -P $M -o "../Kommuner-M.topojson" "temp/full/Kommuner.topojson"
npx topo2geo Kommuner=../Kommuner-M.geojson < ../Kommuner-M.topojson
npx toposimplify -F -P $L -o "../Kommuner-L.topojson" "temp/full/Kommuner.topojson"
npx topo2geo Kommuner=../Kommuner-L.geojson < ../Kommuner-L.topojson


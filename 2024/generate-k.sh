#!/bin/bash

echo "Generate kommuner"
unzip -o source/Basisdata_0000_Norge_25833_Kommuner_FGDB.zip -d ./temp 

node generate-k-from-fgdb.js > tmp-k.json
npx geo2topo -q 1e5 kommuner=tmp-k.json | npx toposimplify -F -P 0.5 | npx topo2geo kommuner=temp/kommuner2024.geojson
rm tmp-k.json

mkdir -p temp/full/kommuner
#node generate-kommuner.js
npx toposimplify -F -P 0.015 -o "../Kommuner-S.topojson" "temp/full/Kommuner.topojson"
npx topo2geo Kommuner=../Kommuner-S.geojson < ../Kommuner-S.topojson
npx toposimplify -F -P 0.05 -o "../Kommuner-M.topojson" "temp/full/Kommuner.topojson"
npx topo2geo Kommuner=../Kommuner-M.geojson < ../Kommuner-M.topojson
npx toposimplify -F -P 0.15 -o "../Kommuner-L.topojson" "temp/full/Kommuner.topojson"
npx topo2geo Kommuner=../Kommuner-L.geojson < ../Kommuner-L.topojson


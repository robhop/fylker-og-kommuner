

echo "Generate fylker"
unzip -o source/Basisdata_0000_Norge_25833_Fylker_GeoJSON.zip -d ./temp 
jq '.["Fylke"]' temp/Basisdata_0000_Norge_25833_Fylker_GeoJSON.geojson | npx reproject --use-epsg-io --from=EPSG:25833 --to=EPGS:4326 > tmp.json
npx geo2topo -q 1e5 fylker=tmp.json | npx toposimplify -F -P 0.5 | npx topo2geo fylker=temp/fylker2024.geojson
rm  tmp.json
mkdir -p temp/full/fylker
node generate-fylker.js
npx toposimplify -F -P 0.05 -o "../Fylker-S.topojson" "temp/full/Fylker.topojson"
npx topo2geo Fylker=../Fylker-S.geojson < ../Fylker-S.topojson
npx toposimplify -F -P 0.1 -o "../Fylker-M.topojson" "temp/full/Fylker.topojson"
npx topo2geo Fylker=../Fylker-M.geojson < ../Fylker-M.topojson
npx toposimplify -F -P 0.3 -o "../Fylker-L.topojson" "temp/full/Fylker.topojson"
npx topo2geo Fylker=../Fylker-L.geojson < ../Fylker-L.topojson
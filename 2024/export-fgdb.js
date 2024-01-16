import fgdb from 'fgdb';
var args = process.argv.slice(2);
fgdb(args[0]).then(function (objectOfGeojson) {
    process.stdout.write(JSON.stringify(objectOfGeojson[args[1]]));
});


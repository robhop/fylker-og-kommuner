import fgdb from 'fgdb';

fgdb('temp/Basisdata_0000_Norge_25833_Kommuner_FGDB.gdb').then(function (objectOfGeojson) {
    process.stdout.write(JSON.stringify(objectOfGeojson.kommune));
}, function (error) {
});

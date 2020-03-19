const child_process = require('child_process');

const ls = child_process.exec(`ls | grep .js$`);
ls.stdout.pipe(process.stdout);
ls.stderr.pipe(process.stdout);

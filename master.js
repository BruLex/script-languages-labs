const child_process = require('child_process');
const fs = require("fs");

setInterval(() => {
    const run_worker = child_process.spawn('node', ['worker.js']);
    const fileStream = fs.createWriteStream('result.txt');

    run_worker.stdout.pipe(fileStream);
    run_worker.stdout.pipe(process.stdout);
    run_worker.on('error', (err) => console.log('Worker::ERROR: ' + JSON.stringify(err)));
    run_worker.on('exit', () => console.log('Worker::Exit'));
}, 6000);

const app = require('./server');

const config = require('../config.js');

const db = require("./services/database/models");
db.sequelize.sync({
    force: false
}).then(() => {
    console.log("Drop and re-sync db.");
});

app.listen(config.get('port'), config.get('ip'), () => console.log(`App started successfully on port http://${config.get('ip')}:${config.get('port')}`));

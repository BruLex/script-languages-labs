const express = require('express');
const { getRoot } = require('../clients/api');

const router = express.Router();

router.get('/', async (req, res) => {
    res.send("PROXY: " + await getRoot());
});

module.exports = router;

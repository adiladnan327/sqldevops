// ------------------------------------------------------------------------//
// Description: Demo application source code
// Repository: https://github.com/erickangMSFT
// Author: Eric Kang
// License: MIT
// ------------------------------------------------------------------------//

'use strict';

const express = require('express');
const router = express.Router();
const mssql = require('mssql');
const fs = require('fs');
const sqldevops = require('../modules/sqldevops.js');

const dbconfig = require('../config/dbconfig.json');
const directorySqlFile = './src/sql/customers_wwi.sql';
const nav = require('../config/navconfig.json');

/* GET directory page. */
router.get('/', (req, res, next) => {
    fs.readFile(directorySqlFile, 'utf8', (err, script) => {
        const request = new mssql.Request();
        request.query(script, (err, rec) => {
            if (err) {
                const sqlerror = sqldevops.getSqlError(err);
                res.render('error', {
                    message: sqlerror.message,
                    error: sqlerror
                });
            }
            else {
                // for debugging
                // console.log(rec.recordset);
                res.render('directory', {
                    title: 'Customer Information',
                    nav: nav,
                    customers: rec.recordset,
                    server: dbconfig.server,
                    database: dbconfig.database,
                    user: dbconfig.user
                });
            }
        });
    });
});
module.exports = router;
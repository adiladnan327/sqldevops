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
const tablespaceSqlFile = './src/sql/tablespace.sql';
const nav = require('../config/navconfig.json');

/* GET home page. */
router.get('/', (req, res, next) => {
  const request = new mssql.Request();
  fs.readFile(tablespaceSqlFile, 'utf8', (err, script) => {
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
        //console.log(rec.recordset);
        res.render('tablespacedetail', {
          title: 'Table Space Usage Detail',
          tablespaces: rec.recordset,
          nav: nav,
          server: dbconfig.server,
          database: dbconfig.database,
          user: dbconfig.user
        });
      }
    });
  });
});
module.exports = router;

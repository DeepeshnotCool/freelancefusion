const express = require('express');
const cors = require('cors');
const scrapeRouter = require('../routes/linkedinScrape.route');
const saveRouter = require('../routes/saveData.route');


module.exports = function (app) {
  // Enable CORS with origin and credentials
  app.use(cors({ origin: RegExp(process.env.CORS_URL, 'i'), credentials: true }));

  app.use(express.json({ limit: '50mb' }));

  app.use(express.urlencoded({ extended: true, limit: '50mb' }));

  
  app.get('/', (req, res) => {
    res.send('Welcome To LinkedinScrape Service');
  });

  app.use('/linkedin', scrapeRouter);
  app.use('/save', saveRouter);
};

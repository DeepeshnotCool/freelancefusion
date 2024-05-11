const express = require('express');
const router = express.Router();

const ScrapeContactController = require('../controllers/scrapeContactController');
const scrapeContactController = new ScrapeContactController();

router.post('/getContactProfileData', scrapeContactController.scrapeAndSaveDataContact);

module.exports = router;

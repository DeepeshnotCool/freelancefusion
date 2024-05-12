const express = require('express');
const router = express.Router();

const ScrapeContactController = require('../controllers/scrapeContactController');
const scrapeContactController = new ScrapeContactController();

const SaveDataController = require('../controllers/saveDataController');
const saveDataController = new SaveDataController();


router.post('/getContactProfileData', scrapeContactController.scrapeAndSaveDataContact);
router.post('/profile', saveDataController.saveUserProfile);
router.post('/opportunity', saveDataController.saveOpportunities);
router.post('/apply', saveDataController.saveAppliedUsers);

module.exports = router;

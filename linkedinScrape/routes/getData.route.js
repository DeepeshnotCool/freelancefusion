const express = require('express');
const router = express.Router();

const GetDataController = require('../controllers/getDataController');
const getDataController = new GetDataController();

router.post('/getMatchedOpportunities', getDataController.getMatchedOpportunities);
router.post('/getMatchedUserProfiles', getDataController.getMatchedUserProfiles);
router.post('/getCustomisedUserProfile', getDataController.getCustomisedUserProfile);


module.exports = router;

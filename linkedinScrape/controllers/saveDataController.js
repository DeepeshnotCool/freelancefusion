const LinkedInContactScraper = require('../core/linkedinContactScraper');
const SaveData = require('../datalayer/saveData.datalayer');

class SaveDataController {

    async saveUserProfile(req, res) {

        const { linkedinUrl, skills, name } = req.body;

        const reqObj = {
            linkedinUrl: linkedinUrl,
            maxAgeInDays: 30
        }
        try {
            const linkedinContactScraper = new LinkedInContactScraper();
            const scrapedContactData = await linkedinContactScraper.scrapeAndSaveProfileContactData(reqObj);
            const saveData = new SaveData();
            const userData = await saveData.saveUserProfileData(req?.body);
            console.log("userProfileUUID: ", userData);
            const result = { reqObj: req?.body, linkedinProfile: scrapedContactData, userProfileUUID: userData.userProfileUUID, profileImage: userData.profileImage };
            res.status(200).json({ message: 'User Data saved by scrapping Linkedin Data successfully', result: result });
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    async saveOpportunities(req, res) {
        const { skillsRequired, experienceLevelRequired } = req.body;

        try {
            const saveData = new SaveData();
            const userData = await saveData.saveOpportunityData(req?.body);
            const result = {opportunityUUID: userData?.opportunityUUID };

            res.status(200).json({ message: 'Opportunity Data saved successfully', result: result });
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }


}

module.exports = SaveDataController;

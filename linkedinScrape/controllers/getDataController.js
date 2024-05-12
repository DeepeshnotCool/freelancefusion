const GetDataCore = require('../core/getDataCore');
const getData = require('../datalayer/getData.datalayer');

class getDataController {

    async getMatchedOpportunities(req, res) {

        const { userSkills, LinkedinSkills, userProfileUUID } = req.body;

        try {
            const getDataCore = new GetDataCore();
            const matchedOpportunities = await getDataCore.getMatchedOpportunities(req?.body);
            const result = { matchedOpportunities: matchedOpportunities.matchedOpportunities };
            res.status(200).json({ message: 'Best Match Opportunities found successfully', result: result });
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    async getMatchedUserProfiles(req, res) {
        const { opportunityUUID, skillsRequired } = req.body;

        try {
            const getDataCore = new GetDataCore();
            const matchedUserProfiles = await getDataCore.getMatchedUserProfiles(req?.body);
            const result = { matchedUserProfiles: matchedUserProfiles?.matchedUserProfiles };

            res.status(200).json({ message: 'Best Match User Profiles found successfully', result: result });
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }

    async getCustomisedUserProfile(req, res) {
        const { userProfileUUID, opportunityUUID } = req.body;

        try {
            const getDataCore = new GetDataCore();
            const customisedUserProfile = await getDataCore.getCustomisedUserProfile(req?.body);
            const result = { customisedUserProfile: customisedUserProfile?.customisedUserProfile };

            res.status(200).json({ message: 'Customised User Profile generated successfully', result: result });
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }




}

module.exports = getDataController;

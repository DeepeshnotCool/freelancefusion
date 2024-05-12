const GenAIApi = require('../api/genAI.api');

class genAICore {

    async getMatchedOpportunities(reqObj) {
        try {

            const genAIApi = new GenAIApi();
            const result = genAIApi.getMatchedOpportunities(reqObj);

            return result;
        } catch (error) {
            throw new Error(`Error getting Matched Opportunities : ${error.message}`);
        }
    }

    async getMatchedUserProfiles(reqObj) {
        try {

            const genAIApi = new GenAIApi();
            const result = genAIApi.getMatchedUserProfiles(reqObj);

            return result;
        } catch (error) {
            throw new Error(`Error getting Matched UserProfiles: ${error.message}`);
        }
    }

    async getCustomisedUserProfile(reqObj) {
        try {

            const genAIApi = new GenAIApi();
            const result = genAIApi.getCustomisedUserProfile(reqObj);

            return result;

        } catch (error) {
            throw new Error(`Error scraping LinkedIn Contact data: ${error.message}`);
        }
    }



}

module.exports = genAICore;

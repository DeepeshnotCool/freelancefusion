const ProxyCurlApi = require('../api/proxyCurl.api');
const proxyCurlApi = new ProxyCurlApi();
const LinkedinContactMetaDataDataLayer = require('../datalayer/linkedinContactMetaData.datalayer');
const GetDataDataLayer = require('../datalayer/getData.datalayer');
const GoogleCloudStorage = require('./googleCloudStorage');
const GenAICore = require('./genAICore');
const moment = require('moment');

class getDataCore {

    async getMatchedOpportunities(reqObj) {
        try {

            const getDataDataLayer = new GetDataDataLayer();
            const opportunities = await getDataDataLayer.getAllOpportunities(reqObj);

            reqObj.opportunities = opportunities;


            const genAICore = new GenAICore();
            const matchedOpportunities = await genAICore.getMatchedOpportunities(reqObj);

            return { matchedOpportunities: matchedOpportunities.matchedOpportunities };

        } catch (error) {
            throw new Error(`Error getting Matched Opportunities : ${error.message}`);
        }
    }

    async getMatchedUserProfiles(reqObj) {
        try {

            const getDataDataLayer = new GetDataDataLayer();
            const appliedUsers = await getDataDataLayer.getAllAppliedUsers(reqObj?.body);
            
            reqObj.appliedUsers = appliedUsers;

            const genAICore = new GenAICore();
            const matchedUserProfiles = await genAICore.getMatchedUserProfiles(reqObj);


            return { matchedUserProfiles: matchedUserProfiles };

        } catch (error) {
            throw new Error(`Error getting Matched UserProfiles: ${error.message}`);
        }
    }

    async getCustomisedUserProfile(reqObj) {
        try {
            
            const genAICore = new GenAICore();
            const customisedUserProfile = await genAICore.getCustomisedUserProfile(reqObj);

            return { customisedUserProfile: customisedUserProfile };

        } catch (error) {
            throw new Error(`Error scraping LinkedIn Contact data: ${error.message}`);
        }
    }



}

module.exports = getDataCore;

const got = require('got');
const CommonGotApi = require('./commonGotApi.api');
const baseUrl = process.env.GEN_AI_SERVICE;

class GenAIApi {
    async getMatchedOpportunities(reqObj) {
        try {
            const apiUrl = `${baseUrl}/getMatchedOpportunities`;
            const body = {
                LinkedinSkills: reqObj?.LinkedinSkills,
                userSkills: reqObj?.userSkills,
                opportunities: reqObj?.opportunities
            }
            const response = await CommonGotApi.fetchDataWithRetryPost(apiUrl, body);
            return response;

        } catch (error) {
            throw new Error(`Error fetching linkedin contact profile data: ${error.message}`);
        }

    }

    async getMatchedUserProfiles(reqObj) {
        try {
            const apiUrl = `${baseUrl}/getMatcheduserProfiles`;
            const body = {
                skillsRequired: reqObj?.skillsRequired,
                appliedUsers: reqObj?.appliedUsers,
            }
            const response = await CommonGotApi.fetchDataWithRetryPost(apiUrl, body);
            return response;

        } catch (error) {
            throw new Error(`Error fetching linkedin contact profile data: ${error.message}`);
        }

    }

    async getCustomisedUserProfile(linkedinContactUrl, recent = false) {
        try {
            const apiUrl = `${baseUrl}/getCustomisedUserProfile`;

            const body = {
                userProfileUUID: reqObj?.userProfileUUID,
                projectDescription: reqObj?.projectDescription,
                skillsRequired: reqObj?.skillsRequired,
                userlinkedinData: reqObj?.userlinkedinData,
                userProfileData: reqObj?.userProfileData,
                reviews: reqObj?.reviews
            }
            const response = await CommonGotApi.fetchDataWithRetryPost(apiUrl, body);
            return response;

        } catch (error) {
            throw new Error(`Error fetching linkedin contact profile data: ${error.message}`);
        }

    }
}

module.exports = GenAIApi;






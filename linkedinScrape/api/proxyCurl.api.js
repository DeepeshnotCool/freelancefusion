const got = require('got');
const CommonGotApi = require('./commonGotApi.api');
const apiKey = process.env.PROXY_CURL_API_KEY;

class ProxyCurlApi {
    async fetchLinkedinContactData(linkedinContactUrl, recent = false) {
        try {
            const apiUrl = `https://nubela.co/proxycurl/api/v2/linkedin`;
            const params = {
                linkedin_profile_url: linkedinContactUrl,
                skills: 'include',
                use_cache: recent ? 'if-recent' : 'if-present',
                fallback_to_cache: 'on-error',
            }
            const response = await CommonGotApi.fetchDataWithRetryGet(apiUrl, apiKey, params);
            return response;

        } catch (error) {
            throw new Error(`Error fetching linkedin contact profile data: ${error.message}`);
        }

    }
}

module.exports = ProxyCurlApi;






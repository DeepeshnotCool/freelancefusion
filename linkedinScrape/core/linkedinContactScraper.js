const ProxyCurlApi = require('../api/proxyCurl.api');
const proxyCurlApi = new ProxyCurlApi();
const LinkedinContactMetaDataDataLayer = require('../datalayer/linkedinContactMetaData.datalayer');
const GoogleCloudStorage = require('./googleCloudStorage');
const moment = require('moment');

class LinkedInContactScraper {

    async scrapeAndSaveProfileContactData(reqObj) {
        try {
            // Sanitize the LinkedIn profile URL to create a safe filename
            const sanitizedUrl = reqObj?.linkedinUrl.replace(/[^\w\s]/gi, '-');


            
            // Construct a unique filename with the sanitized URL using a timestamp
            const timestamp = moment().format('YYYYMMDD-HHmmss');
            const fileName = `linkedin_contact_data_${sanitizedUrl}_${timestamp}.json`;

            const linkedinContactMetaDataDataLayer = new LinkedinContactMetaDataDataLayer();
            const findObj = {
                linkedinContactUrl: reqObj?.linkedinUrl,
                maxAgeInDays: reqObj?.maxAgeInDays
            }

            const googleCloudStorage = new GoogleCloudStorage();
            if(!reqObj?.recent){
                const destination = await linkedinContactMetaDataDataLayer.getLinkedinContactMetaData(findObj);
    
                if (destination) {
                    const resContent = await googleCloudStorage.find(destination);
                    if(resContent){
                        return resContent;
                    }
                }
            }
            const linkedinContactData = await proxyCurlApi.fetchLinkedinContactData(reqObj?.linkedinUrl, reqObj?.recent);
          

            const saveObj = await googleCloudStorage.upload(fileName, JSON.stringify(linkedinContactData), 'contact');
            saveObj.linkedInContactUrl = reqObj?.linkedinUrl;

            await linkedinContactMetaDataDataLayer.saveLinkedinContactMetaData(saveObj);


            return linkedinContactData;
        } catch (error) {
            throw new Error(`Error scraping LinkedIn Contact data: ${error.message}`);
        }
    }
}

module.exports = LinkedInContactScraper;

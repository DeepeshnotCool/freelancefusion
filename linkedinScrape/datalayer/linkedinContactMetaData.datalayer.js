const LinkedinContactMetaDataMongo = require('../models/linkedinContactMetaData.model');
const { v5: uuidv5 } = require('uuid');
const config = require('../config.json');
const moment = require('moment');



class LinkedinContactMetaDataDataLayer {
    async saveLinkedinContactMetaData(reqObj) {
        try {
            // Generate UUID using linkedinContactUrl and destination
            const ContactMetaDataUUID = uuidv5(reqObj?.destination + reqObj?.linkedInContactUrl, config.namespace); 

            // save LinkedinContactMetaData to db
            const result = await LinkedinContactMetaDataMongo.create({
                ContactMetaDataUUID: ContactMetaDataUUID,
                linkedinContactUrl: reqObj.linkedInContactUrl || "",
                fileName: reqObj?.fileName || "",
                filePath: reqObj?.filePath || "",
                destination: reqObj?.destination || "",
                creationDate: reqObj?.creationDate || "",
            });

            // Check if document was successfully saved
            if (result) {
                console.log('LinkedIn contact MetaData saved successfully');
            } else {
                throw new Error('Failed to save LinkedIn contact MetaData');
            }

        } catch (error) {
            throw new Error(`Error saving LinkedIn contact MetaData: ${error.message}`);
        }
    }

    async getLinkedinContactMetaData(reqObj) {
        try {
            // Calculate the threshold date (maxAgeInDays days ago)
            console.log("maxAgeInDays: ", reqObj?.maxAgeInDays);
            const thresholdDate = moment().subtract(reqObj?.maxAgeInDays, 'days').toDate();
    
            // MongoDB aggregation pipeline to filter and find the latest document
            const aggregationPipeline = [
                { $match: { linkedinContactUrl: reqObj?.linkedinContactUrl } },
                { $sort: { creationDate: -1 } },
                { $limit: 1 },
                { $project: { _id: 0, destination: 1, creationDate: 1 } }
            ];
    
            // Execute the aggregation pipeline
            const results = await LinkedinContactMetaDataMongo.aggregate(aggregationPipeline).exec();
    
            // Check if any document matching the criteria was found
            if (results.length > 0 && moment(results[0].creationDate).isAfter(thresholdDate)) {
                // Return the destination from the latest document
                return results[0]?.destination || null;
            }
    
            // No matching documents found or the latest document is too old
            return null;
        } catch (error) {
            throw new Error(`Error finding LinkedIn contact MetaData from database: ${error.message}`);
        }
    }
}

module.exports = LinkedinContactMetaDataDataLayer;








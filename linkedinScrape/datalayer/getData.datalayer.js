const LinkedinContactMetaDataMongo = require('../models/linkedinContactMetaData.model');
const UserProfileMongo = require('../models/userProfile.model');
const opportunityProfileMongo = require('../models/opportunityProfile.model');
const appiledUserMongo = require('../models/appliedUser.model');
const { v5: uuidv5 } = require('uuid');
const config = require('../config.json');
const moment = require('moment');



class getData {
    async getAllAppliedUsers(reqObj) {
        try {
             // find all UserProfiles who has applied for this opportunity 
             const result = await appiledUserMongo.find({ opportunityUUID: reqObj?.opportunityUUID}).exec();

             if (result) {
                 console.log('appliedUserProfiles found');
             } else {
                 throw new Error('Failed to get appliedUserProfiles');
             }
             return result;

        } catch (error) {
            throw new Error(`Error getting applied User Profile: ${error.message}`);
        }
    }


    async getAllOpportunities(reqObj) {
        try {

            // find all opportunities are return it
            const result = await opportunityProfileMongo.find({}).exec();

            if (result) {
                console.log('Opportunities found');
            } else {
                throw new Error('Failed to get Opportunities');
            }
            return result;
        } catch (error) {
            throw new Error(`Error getting Opportunities: ${error.message}`);
        }
    }
}

module.exports = getData;








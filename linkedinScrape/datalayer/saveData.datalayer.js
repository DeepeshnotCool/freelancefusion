const LinkedinContactMetaDataMongo = require('../models/linkedinContactMetaData.model');
const UserProfileMongo = require('../models/userProfile.model');
const opportunityProfileMongo = require('../models/opportunityProfile.model');
const appiledUserMongo = require('../models/appliedUser.model');
const { v5: uuidv5 } = require('uuid');
const config = require('../config.json');
const moment = require('moment');



class saveData {
    async saveUserProfileData(reqObj) {
        try {
            // Generate UUID using linkedinUrl and name as unique Identifier
            // const userProfileUUID = uuidv5(reqObj?.linkedinUrl + reqObj?.name , config.namespace); 

            let userProfileUUID;
            if (reqObj?.linkedinUrl && reqObj?.name && reqObj.linkedinUrl !== "" && reqObj.name !== "") {
                const sanitizedName = reqObj.name.replace(/\s/g, '');
                const sanitizedUrl = reqObj?.linkedinUrl.replace(/[^\w\s]/gi, '-');
                
                userProfileUUID = uuidv5(sanitizedUrl + sanitizedName, config.namespace);
                console.log("User profile UUID:", userProfileUUID);
            } else {
                console.error('Either reqObj.linkedinUrl or reqObj.name is not defined or empty.');
            }



            const imageBuffer = Buffer.from(reqObj?.profileUrl, 'base64');
            const profileImage = {
                data: imageBuffer, 
                contentType: 'image/jpeg' 
            }


            // save userProfile to db
            const result = await UserProfileMongo.create({
                userProfileUUID: userProfileUUID,
                name: reqObj?.name,
                bio: reqObj?.bio,
                linkedinUrl: reqObj.linkedinUrl || "",
                userSkills: reqObj.skills || [],
                profileUrl: reqObj?.profileUrl || "",
                profileImage: profileImage,
            });

            // Check if document was successfully saved
            if (result) {
                console.log('User Profile saved successfully');
            } else {
                throw new Error('Failed to save User Profile');
            }

            return {userProfileUUID: userProfileUUID, profileImage: profileImage };

        } catch (error) {
            throw new Error(`Error saving User Profile: ${error.message}`);
        }
    }


    async saveOpportunityData(reqObj) {
        try {
            // Generate UUID using projectDescription as unique Identifier
            const opportunityUUID = uuidv5(reqObj?.projectDescription, config.namespace); 

            

            // save opportunity to db
            const result = await opportunityProfileMongo.create({
                opportunityUUID: opportunityUUID,
                projectDescription: reqObj?.projectDescription,
                skillsRequired: reqObj?.skillsRequired,
                duration: reqObj.duration || "",
                cost: reqObj.cost || [],
                experienceLevelRequired: reqObj?.experienceLevelRequired || "",
            });

            // Check if document was successfully saved
            if (result) {
                console.log('Opportunity saved successfully');
            } else {
                throw new Error('Failed to save Opportunity');
            }

            return {opportunityUUID: opportunityUUID };

        } catch (error) {
            throw new Error(`Error saving Opportunity: ${error.message}`);
        }
    }

    async saveAppliedUsersData(reqObj) {
        try {
            // Generate UUID using projectDescription as unique Identifier
            const appliedUserUUID = uuidv5(reqObj?.userProfileUUID + reqObj?.opportunityUUID, config.namespace); 

            // save appliedUser to db
            const result = await appiledUserMongo.create({
                appliedUserUUID: appliedUserUUID,
                opportunityUUID: reqObj?.opportunityUUID,
                userProfileUUID: reqObj?.userProfileUUID,
                skillsRequired: reqObj?.skillsRequired || [],
                LinkedinSkills: reqObj?.LinkedinSkills || [],
                userSkills: reqObj?.userSkills || [],
                experienceLevelRequired: reqObj?.experienceLevelRequired || "",
                userExperienceLevel: reqObj?.userExperienceLevel || "",
                name: reqObj?.name || "",
            });

            // Check if document was successfully saved
            if (result) {
                console.log('appliedUserData saved successfully');
            } else {
                throw new Error('Failed to save appliedUserData');
            }

            return {appliedUserUUID: appliedUserUUID };

        } catch (error) {
            throw new Error(`Error saving appliedUserData: ${error.message}`);
        }
    }


}

module.exports = saveData;








const mongoose = require('mongoose');
const { Schema } = mongoose;

const appliedUserSchema = new Schema({
    appliedUserUUID: String,
    LinkedinSkills: Array,
    userSkills: Array,
    experienceLevelRequired: String,
    userExperienceLevel: String,
    opportunityUUID: String,
    userProfileUUID: String,
    creationDate: { type: Date, default: Date.now },
  });

module.exports = mongoose.model('appliedUser', appliedUserSchema, 'applieduser');
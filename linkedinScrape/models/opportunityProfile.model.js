const mongoose = require('mongoose');
const { Schema } = mongoose;

const OpportunityProfileSchema = new Schema({
    opportunityUUID: String,
    projectDescription: String,
    skillsRequired: Array,
    duration: String,
    cost: String,
    experienceLevelRequired: String,
    creationDate: { type: Date, default: Date.now },
  });

module.exports = mongoose.model('opportunityProfile', OpportunityProfileSchema, 'opportunityprofile');


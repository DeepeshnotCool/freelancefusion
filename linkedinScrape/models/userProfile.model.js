const mongoose = require('mongoose');
const { Schema } = mongoose;

const UserProfileSchema = new Schema({
    userProfileUUID: String,
    linkedinUrl: String,
    userSkills: Array,
    bio: String,
    profileUrl: String,
    name: String,
    profileImage: {
        data: Buffer, 
        contentType: String 
    },
    creationDate: { type: Date, default: Date.now },
  });

module.exports = mongoose.model('UserProfile', UserProfileSchema, 'userprofile');
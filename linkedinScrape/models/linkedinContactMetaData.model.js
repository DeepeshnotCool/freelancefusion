const mongoose = require('mongoose');
const { Schema } = mongoose;

const LinkedinContactMetaDataSchema = new Schema({
    ContactMetaDataUUID: String,
    linkedinContactUrl: String,
    creationDate: String,
    fileName: String,
    filePath: String,
    destination: String,
    timestamp: { type: Date, default: Date.now }
  });


  LinkedinContactMetaDataSchema.index({ linkedinContactUrl: 1, creationDate: -1 });

module.exports = mongoose.model('LinkedinContactMetaData', LinkedinContactMetaDataSchema, 'linkedincontactmetadata');
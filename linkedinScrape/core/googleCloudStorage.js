const { Storage } = require('@google-cloud/storage');
const fs = require('fs');
const path = require('path');
const { googleBucketName } = require('../config');

class GoogleCloudStorage {
    constructor() {
        this.bucketName = googleBucketName;
        this.storage = new Storage({
            keyFilename: path.join(__dirname, '..', 'googleCloudBucketCredential.json')
        });
    }

    async upload(fileName, fileContent, folderName) {
        try {
            const folderPath = path.join(__dirname, '..', folderName);
            if (!fs.existsSync(folderPath)) {
                fs.mkdirSync(folderPath);
            }

            // Write the file to the folder
            const filePath = path.join(folderPath, fileName);
            console.log("filePath: ", filePath, "typeOf: ", typeof(filePath));
            fs.writeFileSync(filePath, fileContent);

            // Upload the file to Google Cloud Storage
            const bucket = this.storage.bucket(this.bucketName);
            console.log('destination:', folderName + '/' + fileName);
            const [file] = await bucket.upload(filePath, {
                destination: folderName + '/' + fileName,
            });

            console.log('File created at:', file.metadata.timeCreated);

            // Delete the local file after uploading
            fs.unlinkSync(filePath);

            const saveObj = {
                fileName: fileName,
                filePath: filePath,
                destination: folderName+'/'+fileName,
                creationDate: file.metadata.timeCreated
            }

            console.log(`SaveObj: `, saveObj);

            console.log(`File ${fileName} uploaded successfully to folder ${folderName} in Google Cloud Storage`);
            return saveObj;
        } catch (error) {
            throw new Error(`Error uploading file to Google Cloud Storage: ${error.message}`);
        }
    }



    async find(destination) {
        try {
            // Get the file from Google Cloud Storage
            const bucket = this.storage.bucket(googleBucketName);
            const file = bucket.file(destination);

            // Check if the file exists
            const [exists] = await file.exists();

            if (!exists) {
                // throw new Error(`File ${destination} does not exist in Google Cloud Storage`);
                console.log(`File Does not exist going for scraping the data`);
                return null;
            }

            // Download the file content
            const [content] = await file.download();

            // Return the file content
            const jsonData = JSON.parse(content.toString());
            return jsonData;
        } catch (error) {
            throw new Error(`Error finding file in Google Cloud Storage: ${error.message}`);
        }
    }
}

module.exports = GoogleCloudStorage;

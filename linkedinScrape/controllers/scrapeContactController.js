const LinkedInContactScraper = require('../core/linkedinContactScraper');

class ScrapeContactController {

    async scrapeAndSaveDataContact(req, res) {
        const { linkedinUrl, recent, maxAgeInDays } = req.body;

        if(!linkedinUrl) {
            res.status(400).json({ error: `Linkedin Url is required` });
        }

        const reqObj = {
            linkedinUrl: linkedinUrl,
            recent: recent,
            maxAgeInDays: maxAgeInDays ? maxAgeInDays : 30
        }
        try {
            const linkedinContactScraper = new LinkedInContactScraper();
            const scrapedContactData = await linkedinContactScraper.scrapeAndSaveProfileContactData(reqObj);
            res.status(200).json({ message: 'Data scraped and saved successfully', result: scrapedContactData });
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }
}

module.exports = ScrapeContactController;

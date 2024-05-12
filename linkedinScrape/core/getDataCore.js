const ProxyCurlApi = require('../api/proxyCurl.api');
const proxyCurlApi = new ProxyCurlApi();
const LinkedinContactMetaDataDataLayer = require('../datalayer/linkedinContactMetaData.datalayer');
const GetDataDataLayer = require('../datalayer/getData.datalayer');
const GoogleCloudStorage = require('./googleCloudStorage');
const moment = require('moment');

class getDataCore {

    async getMatchedOpportunities(reqObj) {
        try {


            // get all the opportunities and pass in the genAI service along with userSkills and LinkedinSkills 


            const getDataDataLayer = new GetDataDataLayer();
            const opportunities = await getDataDataLayer.getAllOpportunities(reqObj);

            return { matchedOpportunities: opportunities };




            // after calling the genAI service it will return the list of opportunities based on the match rate of the skills

            // we will return the list of the opportunities
        } catch (error) {
            throw new Error(`Error getting Matched Opportunities : ${error.message}`);
        }
    }

    async getMatchedUserProfiles(reqObj) {
        try {


            // get all userProfiles who have applied for that particular opportunities and then get all the skills of all userProfiles map them and send it to genAI service along with the skills required and return the best match userProfiles


            const getDataDataLayer = new GetDataDataLayer();
            const appliedUsers = await getDataDataLayer.getAllAppliedUsers(reqObj?.body);







            return { matchedUserProfiles: appliedUsers };




            // after calling the genAI service it will return the list of userProfiles based on the match rate of the skills

            // we will return the list of the opportunities
        } catch (error) {
            throw new Error(`Error getting Matched UserProfiles: ${error.message}`);
        }
    }

    async getCustomisedUserProfile(reqObj) {
        try {

            // userProfileUUID
            // projectDescription
            // skillsRequired
            // userlinkedinData
            // userProfileData
            // reviews

            // call genAI service to get the customised profile

            const customisedUserProfile = {
                "public_identifier": "deepeshranjankhatri",
                "profile_pic_url": "https://s3.us-west-000.backblazeb2.com/proxycurl/person/deepeshranjankhatri/profile?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=0004d7f56a0400b0000000001%2F20240511%2Fus-west-000%2Fs3%2Faws4_request&X-Amz-Date=20240511T155503Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=5487c2acb8bcbe6b881718f55b63f5df454a506286b4723c2b27613eb4a60bc0",
                "background_cover_image_url": "https://s3.us-west-000.backblazeb2.com/proxycurl/person/deepeshranjankhatri/cover?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=0004d7f56a0400b0000000001%2F20240511%2Fus-west-000%2Fs3%2Faws4_request&X-Amz-Date=20240511T155503Z&X-Amz-Expires=3600&X-Amz-SignedHeaders=host&X-Amz-Signature=eecfbed1b6d4d819a016edb402ba507aac1ac2f6c0b42fdab9c9ae45bbb63c90",
                "first_name": "Deepesh Ranjan",
                "last_name": "Khatri",
                "full_name": "Deepesh Ranjan Khatri",
                "follower_count": 1508,
                "occupation": "Associate Software Developer at BambooBox",
                "headline": "ASDE @Bamboobox | Former SDE INTERN @Goldman Sachs | Leetcode(Knight)",
                "summary": "working in a startup to enhance my skills.",
                "country": "IN",
                "country_full_name": "India",
                "city": "Jamshedpur",
                "state": "Jharkhand",
                "experiences": [
                    {
                        "starts_at": {
                            "day": 1,
                            "month": 7,
                            "year": 2023
                        },
                        "ends_at": null,
                        "company": "BambooBox",
                        "company_linkedin_profile_url": "https://www.linkedin.com/company/bamboobox/",
                        "company_facebook_profile_url": null,
                        "title": "Associate Software Developer",
                        "description": "Full stack developer with MERN tech stack",
                        "location": "Bengaluru, Karnataka, India",
                        "logo_url": "https://media.licdn.com/dms/image/D560BAQF83ryU6OGQYw/company-logo_400_400/0/1688131602495/bamboobox_logo?e=1720656000&v=beta&t=ClGkmvi5B4b9QuP8zOoSharP0X5IPltKgBeHBYjq3JU"
                    },
                    {
                        "starts_at": {
                            "day": 1,
                            "month": 5,
                            "year": 2023
                        },
                        "ends_at": {
                            "day": 30,
                            "month": 6,
                            "year": 2023
                        },
                        "company": "BambooBox",
                        "company_linkedin_profile_url": "https://www.linkedin.com/company/bamboobox/",
                        "company_facebook_profile_url": null,
                        "title": "Associate Software Developer Intern",
                        "description": null,
                        "location": "Bengaluru, Karnataka, India",
                        "logo_url": "https://media.licdn.com/dms/image/D560BAQF83ryU6OGQYw/company-logo_400_400/0/1688131602495/bamboobox_logo?e=1720656000&v=beta&t=ClGkmvi5B4b9QuP8zOoSharP0X5IPltKgBeHBYjq3JU"
                    },
                    {
                        "starts_at": {
                            "day": 1,
                            "month": 4,
                            "year": 2021
                        },
                        "ends_at": {
                            "day": 31,
                            "month": 5,
                            "year": 2023
                        },
                        "company": "CodeChef",
                        "company_linkedin_profile_url": "https://www.linkedin.com/company/codechef/",
                        "company_facebook_profile_url": null,
                        "title": "President",
                        "description": "President at codechef College chapter RVSCET",
                        "location": "Jamshedpur, Jharkhand, India",
                        "logo_url": "https://media.licdn.com/dms/image/C560BAQGqbQqGLrllzQ/company-logo_400_400/0/1641201042355/codechef_logo?e=1720656000&v=beta&t=-ZjoGqIP11Wb5wERpC_4b3rzXAs9WqOpntHUzxST3oQ"
                    },
                    {
                        "starts_at": {
                            "day": 1,
                            "month": 8,
                            "year": 2022
                        },
                        "ends_at": {
                            "day": 30,
                            "month": 4,
                            "year": 2023
                        },
                        "company": "Chegg India",
                        "company_linkedin_profile_url": "https://www.linkedin.com/company/cheggindia/",
                        "company_facebook_profile_url": null,
                        "title": "Subject Matter Expert",
                        "description": "solved 300+ questions of Computer Science Domain",
                        "location": "Other",
                        "logo_url": "https://media.licdn.com/dms/image/C4D0BAQGrZGuUpN9MWQ/company-logo_400_400-alternative/0/1630552136362/cheggindia_logo?e=1720656000&v=beta&t=LNLyEh7YgFNBXkmqwe_nv5oxkYWinGOCe2v6yvYiWWI"
                    },
                    {
                        "starts_at": {
                            "day": 1,
                            "month": 6,
                            "year": 2022
                        },
                        "ends_at": {
                            "day": 31,
                            "month": 7,
                            "year": 2022
                        },
                        "company": "Goldman Sachs",
                        "company_linkedin_profile_url": "https://www.linkedin.com/company/goldman-sachs/",
                        "company_facebook_profile_url": null,
                        "title": "Summer Analyst",
                        "description": "• Introduced Agile Methodologies and development best practices to division to enhance product development.\n\n• Worked with 3 different codebases and Wrote production-ready code with fluency in front-end\rand back-end frameworks.\n\r\n• Documented technical workflows and knowledge to educate newly hired employees.\n\r\n• Learnt relevant skills for this internship: Java, springboot, react JS, MongoDB, DB2, JUnit, Rest ApI's.",
                        "location": "Bengaluru, Karnataka, India",
                        "logo_url": "https://media.licdn.com/dms/image/C4E0BAQHm5bYK6emQSg/company-logo_400_400/0/1630621204189/goldman_sachs_logo?e=1720656000&v=beta&t=bPGoo71fCUTbkmLBWSucaMg9ebCHcupGaejpqsuRo7Y"
                    },
                    {
                        "starts_at": {
                            "day": 1,
                            "month": 8,
                            "year": 2021
                        },
                        "ends_at": {
                            "day": 31,
                            "month": 8,
                            "year": 2021
                        },
                        "company": "CVIT-IIITH",
                        "company_linkedin_profile_url": null,
                        "company_facebook_profile_url": null,
                        "title": "CVIT-IIITH 5th Summer School",
                        "description": "attended summer school at IIITH",
                        "location": "Hyderabad, Telangana, India",
                        "logo_url": null
                    }
                ],
                "education": [
                    {
                        "starts_at": {
                            "day": 1,
                            "month": 1,
                            "year": 2019
                        },
                        "ends_at": {
                            "day": 31,
                            "month": 1,
                            "year": 2023
                        },
                        "field_of_study": "Computer Science",
                        "degree_name": "Bachelor of Technology - BTech",
                        "school": "RVS College of Engineering and Technology",
                        "school_linkedin_profile_url": null,
                        "school_facebook_profile_url": null,
                        "description": null,
                        "logo_url": "https://media.licdn.com/dms/image/C510BAQFAC2lCHwVVxw/company-logo_400_400/0/1630607261998/rvs_college_of_engineering_and_technology_logo?e=1720656000&v=beta&t=i6En_aqCRZK9vY0BkZSTSQ-Wxdg6HAsu1x3RfS2oCSg",
                        "grade": null,
                        "activities_and_societies": null
                    },
                    {
                        "starts_at": {
                            "day": 1,
                            "month": 4,
                            "year": 2016
                        },
                        "ends_at": {
                            "day": 30,
                            "month": 4,
                            "year": 2018
                        },
                        "field_of_study": "Computer Science",
                        "degree_name": "High school",
                        "school": "Jawahar Navodaya Vidyalaya (JNV)",
                        "school_linkedin_profile_url": null,
                        "school_facebook_profile_url": null,
                        "description": null,
                        "logo_url": "https://media.licdn.com/dms/image/C510BAQGK87VYL7oZLw/company-logo_400_400/0/1630566378561?e=1720656000&v=beta&t=zKS4lWrmR49xeaswH3H9Vnw1ov9ntJ6TuncXvldlc2A",
                        "grade": "A",
                        "activities_and_societies": null
                    }
                ],
                "languages": [
                    "English",
                    "Hindi"
                ],
                "accomplishment_organisations": [],
                "accomplishment_publications": [],
                "accomplishment_honors_awards": [],
                "accomplishment_patents": [],
                "accomplishment_courses": [
                    {
                        "name": "B.Tech in computer science",
                        "number": "1"
                    }
                ],
                "accomplishment_projects": [
                    {
                        "starts_at": {
                            "day": 1,
                            "month": 4,
                            "year": 2021
                        },
                        "ends_at": null,
                        "title": "CANVAS using OpenCV",
                        "description": "We made a CANVAS Using python-OpenCV  ",
                        "url": null
                    }
                ],
                "accomplishment_test_scores": [
                    {
                        "name": "TATA Mutual Fund Math Competition",
                        "score": "100",
                        "date_on": {
                            "day": 1,
                            "month": 6,
                            "year": 2014
                        },
                        "description": null
                    },
                    {
                        "name": "Python Hackerrank",
                        "score": "1265 till now",
                        "date_on": null,
                        "description": null
                    }
                ],
                "volunteer_work": [
                    {
                        "starts_at": {
                            "day": 1,
                            "month": 5,
                            "year": 2021
                        },
                        "ends_at": null,
                        "title": "President",
                        "cause": "EDUCATION",
                        "company": "CodeChef RVSCET Chapter",
                        "company_linkedin_profile_url": "https://www.linkedin.com/company/codechef-rvscet-chapter/",
                        "description": null,
                        "logo_url": "https://media.licdn.com/dms/image/C560BAQHXqOTkas3YTA/company-logo_400_400/0/1630666356179?e=1720656000&v=beta&t=jSCEJbBO08q7ZBVmQlD1VPUIc1C0AHq2ognGUD_EFWI"
                    }
                ],
                "certifications": [],
                "connections": 500,
                "people_also_viewed": [
                    {
                        "link": "https://www.linkedin.com/in/justani",
                        "name": "Aniruddh Dubey",
                        "summary": "Head of Engineering at CodeChef",
                        "location": null
                    },
                    {
                        "link": "https://www.linkedin.com/in/shivani-sharma-b1a669196",
                        "name": "Shivani Sharma",
                        "summary": "Associate Software Engineer @ BambooBox | Google Cloud Certified, Full Stack Development",
                        "location": null
                    },
                    {
                        "link": "https://www.linkedin.com/in/mou-samaddar-815738229",
                        "name": "Mou Samaddar",
                        "summary": "BTech CSE 2022-26 || HTML || CSS || JavaScript || MySql || Python || Java || Intern at CodeClause",
                        "location": null
                    },
                    {
                        "link": "https://www.linkedin.com/in/md-kamran-55b98521a",
                        "name": "Md Kamran",
                        "summary": "Intern @HeyCoach | Specialist(1504) at Codeforces | 4⭐ Knight Leetcode (2082) Top :- ~1% (1500+ Solved) | 4⭐ CodeChef (1820) | AtCoder(761) 7 Kyu | 4000+ Algorithmic Problems | Aspiring SDE |",
                        "location": null
                    },
                    {
                        "link": "https://www.linkedin.com/in/hruday-pabbisetty",
                        "name": "hruday pabbisetty",
                        "summary": "Software Engineer II at Microsoft",
                        "location": null
                    },
                    {
                        "link": "https://www.linkedin.com/in/smit-doshi-9990b020b",
                        "name": "Smit Doshi",
                        "summary": "SDE Intern @Zeus Learning || Aspiring Software Development Engineer | MERN Stack Developer | Competitive Programmer | Problem Solver | 3⭐@Codechef",
                        "location": null
                    },
                    {
                        "link": "https://www.linkedin.com/in/rachit-choudhary-39224421b",
                        "name": "Rachit Choudhary",
                        "summary": "ICPC Asia-West Continental Finalist | AIR - 11 in ICPC Regionals | SD - Trainee @Gemini Solutions | 5🌟 CodeChef | Expert Codeforces | Guardian Leetcode | Ex - SD- Intern @EchoIT Solutions | Ex-Intern @CodingNinjas.",
                        "location": null
                    },
                    {
                        "link": "https://www.linkedin.com/in/dharmendra837",
                        "name": "Dharmendra Bhai Patel",
                        "summary": "SDE @ Incedo Inc. || B.Tech CSE",
                        "location": null
                    },
                    {
                        "link": "https://www.linkedin.com/in/tausif39",
                        "name": "Tausiful Haque",
                        "summary": "Back End Developer | C++ | JMI 24",
                        "location": null
                    },
                    {
                        "link": "https://www.linkedin.com/in/dr-vikram-sharma-346b0a11a",
                        "name": "Dr Vikram Sharma",
                        "summary": "Empowering Graduates for the Future | Training and Placement Head @ RVSCET",
                        "location": null
                    }
                ],
                "recommendations": [],
                "activities": [
                    {
                        "title": "How did I prepare LLD(Low Level Design) for Microsoft interviews...Complete preparation strategy!!-> 1st week:- Learn/Revised OOPS concepts,-…",
                        "link": "https://www.linkedin.com/posts/parassaini_microsoft-google-like-activity-7079357037649739776-BK-w",
                        "activity_status": "Liked by Deepesh Ranjan Khatri"
                    },
                    {
                        "title": "Pando is a global leader in supply-chain technology. With its end-to-end fulfillment cloud platform, Pando empowers business agility across…",
                        "link": "https://www.linkedin.com/posts/bamboobox_newcustomer-supplychain-b2b-activity-7076468278042251264-5gJi",
                        "activity_status": "Liked by Deepesh Ranjan Khatri"
                    },
                    {
                        "title": "Workplace energy !Likhit Reddy JOEPETER FRANCIS Vishal Gupta  Divyesh Dixit KUSHAGRA SETU",
                        "link": "https://www.linkedin.com/posts/workplace-energy-likhit-reddy-joepeter-activity-7076589113654595584-kzAl",
                        "activity_status": "Liked by Deepesh Ranjan Khatri"
                    },
                    {
                        "title": "As we enter the second half of this year with optimism, marketers continue to optimize their spend and focus on maximizing the impact of their ABM…",
                        "link": "https://www.linkedin.com/posts/as-we-enter-the-second-half-of-this-year-activity-7076165145789419520--Cge",
                        "activity_status": "Liked by Deepesh Ranjan Khatri"
                    },
                    {
                        "title": "View my verified achievement from Amazon Web Services",
                        "link": "https://www.linkedin.com/posts/soumadip-majumdar-583089257_aws-certified-cloud-practitioner-was-issued-activity-7075724758394294272-xV4g",
                        "activity_status": "Liked by Deepesh Ranjan Khatri"
                    },
                    {
                        "title": "I’m happy to share that I’m starting a new position as Graduate Engineer Trainee at Air India Limited!",
                        "link": "https://www.linkedin.com/posts/aniketsagar47_im-happy-to-share-that-im-starting-a-new-activity-7070970401220141056-4ksJ",
                        "activity_status": "Liked by Deepesh Ranjan Khatri"
                    },
                    {
                        "title": "My BYJU'S  Interview Experience for MTS-𝟏.Applied Through: an On-campus opportunity(allowed branches are CSE, ECE, IT, EE).Total 3 Rounds were…",
                        "link": "https://www.linkedin.com/posts/akashparihar_byjus-interviewexperience-leetcode-activity-7065666601945108480-G8sk",
                        "activity_status": "Liked by Deepesh Ranjan Khatri"
                    },
                    {
                        "title": "Amidst all the chaos and destruction in the world, it's heartwarming to witness acts of selflessness and kindness. Recently, a human family came…",
                        "link": "https://www.linkedin.com/posts/itio-innovex_like-change-video-activity-7064123887638257664-kyzc",
                        "activity_status": "Liked by Deepesh Ranjan Khatri"
                    },
                    {
                        "title": "Hey friends, I’m looking for a new role and would really appreciate your support. Thanks in advance for any connections, advice, or opportunities you…",
                        "link": "https://www.linkedin.com/posts/saif-mohammad-khan-894679183_opentowork-activity-7059190132599308288-rKZC",
                        "activity_status": "Liked by Deepesh Ranjan Khatri"
                    },
                    {
                        "title": "As a dev, on a scale of 1-10 how much can you relate with this? 😩By: Vineet Dugar#tech #dev #devlife #developer #appdevelopment…",
                        "link": "https://www.linkedin.com/posts/geekyants-india-pvt-ltd_tech-dev-devlife-activity-7052634667887280128-3nVt",
                        "activity_status": "Liked by Deepesh Ranjan Khatri"
                    },
                    {
                        "title": "Wait, what?!",
                        "link": "https://www.linkedin.com/posts/github_thomaswebsummitrio-activity-7054499076628742144-KOCV",
                        "activity_status": "Liked by Deepesh Ranjan Khatri"
                    },
                    {
                        "title": "Build your own CoPilot: Turbopilot is an open source large-language-model that can be used to build your own copilot & runs locally on…",
                        "link": "https://www.linkedin.com/posts/iamabhishekchoudhary_docker-activity-7052568134024601601-xN1K",
                        "activity_status": "Liked by Deepesh Ranjan Khatri"
                    },
                    {
                        "title": "𝐈𝐟 𝐲𝐨𝐮 𝐚𝐫𝐞 𝐩𝐫𝐞𝐩𝐚𝐫𝐢𝐧𝐠 𝐟𝐨𝐫 𝐚 𝐅𝐑𝐎𝐍𝐓-𝐄𝐍𝐃 𝐈𝐧𝐭𝐞𝐫𝐯𝐢𝐞𝐰 𝐭𝐡𝐞𝐧 𝐭𝐡𝐢𝐬 𝐩𝐨𝐬𝐭 𝐢𝐬 𝐟𝐨𝐫 𝐲𝐨𝐮. 𝐀𝐧𝐝 𝐚𝐥𝐬𝐨…",
                        "link": "https://www.linkedin.com/posts/ansh-_javascript-webdesign-software-activity-7048881877981536256-TF20",
                        "activity_status": "Liked by Deepesh Ranjan Khatri"
                    },
                    {
                        "title": "Thanks Vincent Pradeilles 👨🏻‍💻 for sharing",
                        "link": "https://www.linkedin.com/posts/javascript-developer_thanks-vincent-pradeilles-for-sharing-activity-7037051869185105920-330G",
                        "activity_status": "Liked by Deepesh Ranjan Khatri"
                    },
                    {
                        "title": "Here's another mind-blowing moment with #ChatGPT `Browser Alpha`!You can paste a PDF document and have it summarized or Q&A it in real time!",
                        "link": "https://www.linkedin.com/posts/genai-works_chatgpt-activity-7046194163008098305-1AUI",
                        "activity_status": "Liked by Deepesh Ranjan Khatri"
                    },
                    {
                        "title": "ChatGPT for Blender!zero shot Blender code generation works surprisingly well out of the box, but gonna try to give it access to the entire…",
                        "link": "https://www.linkedin.com/posts/genai-works_chatgpt-for-blender-zero-shot-blender-code-activity-7045605285461176320-0Y-e",
                        "activity_status": "Liked by Deepesh Ranjan Khatri"
                    }
                ],
                "similarly_named_profiles": [],
                "articles": [],
                "groups": [],
                "skills": [
                    "C++",
                    "C (Programming Language)",
                    "Python (Programming Language)",
                    "Engineering",
                    "Java",
                    "Data Structures",
                    "OpenCV",
                    "Data Analysis"
                ],
                "inferred_salary": null,
                "gender": null,
                "birth_date": null,
                "industry": null,
                "extra": null,
                "interests": [],
                "personal_emails": [],
                "personal_numbers": []
            }


            return { customisedUserProfile: customisedUserProfile };




            // after calling the genAI service it will return the list of opportunities based on the match rate of the skills

            // we will return the list of the opportunities
        } catch (error) {
            throw new Error(`Error scraping LinkedIn Contact data: ${error.message}`);
        }
    }



}

module.exports = getDataCore;

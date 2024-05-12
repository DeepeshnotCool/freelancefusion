import os
from langchain.chain import RunnablePassthrough
from langchain.hub import hub
from langchain.wrappers import ChatOpenAI
import json
import openai




os.environ["OPENAI_API_KEY"] = ""



def generate_matched_opportunities_service(data):

    pass
def generate_matched_user_profile_service(data):
    pass

def generate_customised_user_profile_service(user_profile_data, project_description, skills_required, user_linkedin_data):
    # Creating a prompt for generating the profile
    prompt = f"User Profile:\n\nName: {user_profile_data['name']}\nJob Title: {user_profile_data['jobTitle']}\nBio: {user_profile_data['bio']}\nLinkedIn URL: {user_profile_data['linkedinUrl']}\n\nSkills:\n"

    for skill in user_profile_data['skills']:
        prompt += f"- {skill['skillName']}: {skill['skillLevel']}\n"

    prompt += "\nProject Description:\n\n" + project_description + "\n\nSkills Required:\n\n"

    for skill in skills_required:
        prompt += f"- {skill}\n"

    prompt += "\nLinkedIn Data:\n\n" + f"Name: {user_linkedin_data['result']['full_name']}\n"
    prompt += f"Occupation: {user_linkedin_data['result']['occupation']}\n"
    prompt += f"Summary: {user_linkedin_data['result']['summary']}\n"
    prompt += f"Location: {user_linkedin_data['result']['city']}, {user_linkedin_data['result']['state']}, {user_linkedin_data['result']['country_full_name']}\n"
    prompt += f"Education: {user_linkedin_data['result']['education'][0]['field_of_study']}, {user_linkedin_data['result']['education'][0]['school']}\n"
    prompt += f"Experiences:\n"

    for exp in user_linkedin_data['result']['experiences']:
        prompt += f"- {exp['title']} at {exp['company']}, {exp['location']}\n"

    prompt += f"\nFollowers on LinkedIn: {user_linkedin_data['result']['follower_count']}\n"

    # Setting up LangChain for conversational AI
    llm_chat = ChatOpenAI(model_name="text-davinci-003", temperature=0.5)
    prompt_chat = hub.pull("langchain/prompt/chat_prompt_template")

    # Combining LangChain components
    chain = RunnablePassthrough() | prompt_chat | llm_chat

    # Generating the profile using LangChain
    generated_profile = chain.invoke({"question": prompt})
    generated_profile = json.loads(generated_profile)

    return generated_profile




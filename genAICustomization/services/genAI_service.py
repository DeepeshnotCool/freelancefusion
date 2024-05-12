import os
from langchain.chain import RunnablePassthrough, RunnableParallel
from langchain.hub import hub
from langchain.wrappers import ChatOpenAI
import pandas as pd
from langchain.text import DataFrameLoader, RecursiveCharacterTextSplitter, Chroma, OpenAIEmbeddings
from langchain.parsers import StrOutputParser
import json
import openai




os.environ["OPENAI_API_KEY"] = "sk-xQtDrK180lCaUJxDA5nJT3BlbkFJdmSxAUDZiOP3pkfXFK6"




def calculate_skill_match_score(profile_skills, opportunity_skills):
    matched_skills = set(profile_skills) & set(opportunity_skills)
    if len(matched_skills) >= 8:
        return 5
    elif 6 <= len(matched_skills) < 8:
        return 4
    elif 4 <= len(matched_skills) < 6:
        return 3
    else:
        return 2

def calculate_proficiency_level_score(level):
    if level == "Highly Proficient":
        return 5
    elif level == "Proficient":
        return 4.5
    elif level == "Competent":
        return 3.5
    elif level == "Adequate":
        return 3
    elif level == "Beginner":
        return 2
    else:
        return 0

def calculate_profile_rating_score(rating, proficiency_level, completion_timelines):
    if rating == "Highly Recommended" and proficiency_level == "Highly Proficient" and completion_timelines == "On Time":
        return 5
    elif rating == "Recommended" and proficiency_level == "Highly Proficient" and completion_timelines == "On Time":
        return 4.5
    elif rating == "Recommended" and proficiency_level == "Proficient" and completion_timelines == "On Time":
        return 4
    else:
        return 0

def calculate_linkedin_skill_match_score(profile_skills, opportunity_skills):
    matched_skills = set(profile_skills) & set(opportunity_skills)
    if len(matched_skills) >= 8:
        return 5
    elif 6 <= len(matched_skills) < 8:
        return 4
    elif 4 <= len(matched_skills) < 6:
        return 3
    else:
        return 2

def calculate_match_rate(skill_match_score, proficiency_level_score, profile_rating_score, linkedin_skill_match_score):
    weighted_avg = (skill_match_score + proficiency_level_score + profile_rating_score + linkedin_skill_match_score) / 4
    if weighted_avg >= 4.5:
        return "VERY HIGH"
    elif 4 <= weighted_avg < 4.5:
        return "HIGH"
    elif 3.5 <= weighted_avg < 4:
        return "MEDIUM"
    else:
        return "LOW"

def generate_matched_opportunities_service(data):
    linkedin_skills = data["LinkedinSkills"]
    user_skills = data["userSkills"]
    opportunities = data["opportunities"]

    matched_opportunities = []

    for opportunity in opportunities:
        skill_match_score = calculate_skill_match_score(user_skills, opportunity["skillsRequired"])
        proficiency_level_score = calculate_proficiency_level_score(data.get("proficiencyLevel", ""))
        profile_rating_score = calculate_profile_rating_score(data.get("profileRating", ""), data.get("proficiencyLevel", ""), data.get("completionTimelines", ""))
        linkedin_skill_match_score = calculate_linkedin_skill_match_score(linkedin_skills, opportunity["skillsRequired"])

        match_rate = calculate_match_rate(skill_match_score, proficiency_level_score, profile_rating_score, linkedin_skill_match_score)

        matched_opportunities.append({
            "opportunityUUID": opportunity["opportunityUUID"],
            "projectDescription": opportunity["projectDescription"],
            "skillsRequired": opportunity["skillsRequired"],
            "duration": opportunity["duration"],
            "cost": opportunity["cost"],
            "experienceLevelRequired": opportunity["experienceLevelRequired"],
            "creationDate": opportunity["creationDate"],
            "matchRate": match_rate
        })

    matched_opportunities.sort(key=lambda x: x["matchRate"], reverse=True)
    return matched_opportunities



def generate_matched_opportunities_service_llm(data):
    linkedin_skills = data["LinkedinSkills"]
    user_skills = data["userSkills"]
    opportunities = data["opportunities"]

    # LangChain setup
    llm = ChatOpenAI(model_name="gpt-3.5-turbo", temperature=0.5)
    prompt_skill_match = hub.pull("langchain/prompt/skill_match_prompt")
    prompt_proficiency_level = hub.pull("langchain/prompt/proficiency_level_prompt")
    prompt_profile_rating = hub.pull("langchain/prompt/profile_rating_prompt")
    prompt_linkedin_skill_match = hub.pull("langchain/prompt/linkedin_skill_match_prompt")
    prompt_match_rate = hub.pull("langchain/prompt/match_rate_prompt")

    # Calculate scores using LangChain prompts
    skill_match_score = RunnablePassthrough() | prompt_skill_match | llm
    proficiency_level_score = RunnablePassthrough() | prompt_proficiency_level | llm
    profile_rating_score = RunnablePassthrough() | prompt_profile_rating | llm
    linkedin_skill_match_score = RunnablePassthrough() | prompt_linkedin_skill_match | llm

    # Process data for each opportunity
    matched_opportunities = []
    for opportunity in opportunities:
        data_context = {
            "user_skills": user_skills,
            "opportunity_skills": opportunity["skillsRequired"],
            "proficiency_level": data.get("proficiencyLevel", ""),
            "profile_rating": data.get("profileRating", ""),
            "completion_timelines": data.get("completionTimelines", ""),
            "linkedin_skills": linkedin_skills
        }
        skill_match_score_output = skill_match_score.invoke(data_context)
        proficiency_level_score_output = proficiency_level_score.invoke(data_context)
        profile_rating_score_output = profile_rating_score.invoke(data_context)
        linkedin_skill_match_score_output = linkedin_skill_match_score.invoke(data_context)

        # Calculate match rate
        match_rate_context = {
            "skill_match_score": skill_match_score_output,
            "proficiency_level_score": proficiency_level_score_output,
            "profile_rating_score": profile_rating_score_output,
            "linkedin_skill_match_score": linkedin_skill_match_score_output
        }
        match_rate = RunnablePassthrough() | prompt_match_rate | llm
        match_rate_output = match_rate.invoke(match_rate_context)

        matched_opportunities.append({
            "opportunityUUID": opportunity["opportunityUUID"],
            "projectDescription": opportunity["projectDescription"],
            "skillsRequired": opportunity["skillsRequired"],
            "duration": opportunity["duration"],
            "cost": opportunity["cost"],
            "experienceLevelRequired": opportunity["experienceLevelRequired"],
            "creationDate": opportunity["creationDate"],
            "matchRate": match_rate_output
        })

    # Sort opportunities by match rate
    matched_opportunities.sort(key=lambda x: x["matchRate"], reverse=True)
    return matched_opportunities

def generate_matched_user_profile_service(data):
    applied_users = data["appliedUsers"]
    skills_required = data["skillsRequired"]

    # LangChain setup
    llm = ChatOpenAI(model_name="gpt-3.5-turbo", temperature=0.5)
    prompt_skill_match = hub.pull("langchain/prompt/skill_match_prompt")
    prompt_proficiency_level = hub.pull("langchain/prompt/proficiency_level_prompt")
    prompt_profile_rating = hub.pull("langchain/prompt/profile_rating_prompt")
    prompt_linkedin_skill_match = hub.pull("langchain/prompt/linkedin_skill_match_prompt")
    prompt_match_rate = hub.pull("langchain/prompt/match_rate_prompt")

    # Calculate scores using LangChain prompts
    user_profiles = []
    for user in applied_users:
        user_skills = user["userSkills"]
        linkedin_skills = user["LinkedinSkills"]

        skill_match_score = RunnablePassthrough() | prompt_skill_match | llm
        proficiency_level_score = RunnablePassthrough() | prompt_proficiency_level | llm
        profile_rating_score = RunnablePassthrough() | prompt_profile_rating | llm
        linkedin_skill_match_score = RunnablePassthrough() | prompt_linkedin_skill_match | llm

        # Process data for each user
        data_context = {
            "user_skills": user_skills,
            "opportunity_skills": skills_required,
            "proficiency_level": user.get("userExperienceLevel", ""),
            "profile_rating": user.get("profileRating", ""),
            "linkedin_skills": linkedin_skills
        }
        skill_match_score_output = skill_match_score.invoke(data_context)
        proficiency_level_score_output = proficiency_level_score.invoke(data_context)
        profile_rating_score_output = profile_rating_score.invoke(data_context)
        linkedin_skill_match_score_output = linkedin_skill_match_score.invoke(data_context)

        # Calculate match rate
        match_rate_context = {
            "skill_match_score": skill_match_score_output,
            "proficiency_level_score": proficiency_level_score_output,
            "profile_rating_score": profile_rating_score_output,
            "linkedin_skill_match_score": linkedin_skill_match_score_output
        }
        match_rate = RunnablePassthrough() | prompt_match_rate | llm
        match_rate_output = match_rate.invoke(match_rate_context)

        user_profiles.append({
            "userProfileUUID": user["userProfileUUID"],
            "matchRate": match_rate_output
        })

    # Sort user profiles by match rate
    user_profiles.sort(key=lambda x: x["matchRate"], reverse=True)
    return user_profiles


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

    # Constructing the LangChain
    llm = ChatOpenAI(model_name="gpt-3.5-turbo", temperature=0.5)
    prompt_template = hub.pull("langchain/prompt/chat_prompt_template")
    rag_prompt = hub.pull("rlm/rag-prompt")

    rag_chain = (
            RunnablePassthrough.assign(context=(lambda x: x["context"]))
            | rag_prompt
            | llm
            | StrOutputParser()
    )

    rag_chain = RunnableParallel(
        {"context": rag_chain, "question": prompt_template}
    ).assign(answer=rag_chain)

    generated_profile = rag_chain.invoke({"question": prompt})
    generated_profile = json.loads(generated_profile)

    return generated_profile


def feedback_mechanism(feedback_score):
    if feedback_score < 0.9:
        return True
    return False

def agent_executor(user_profile_data, project_description, skills_required, user_linkedin_data):
    generated_profile = generate_customised_user_profile_service(user_profile_data, project_description, skills_required, user_linkedin_data)
    feedback_score = generated_profile.get("score", 1.0)
    if feedback_mechanism(feedback_score):
        generated_profile = generate_customised_user_profile_service(user_profile_data, project_description, skills_required, user_linkedin_data)
    return generated_profile




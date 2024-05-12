# routes.py
from flask import Blueprint, request, jsonify
from controllers import genAI_controller

genAI_routes = Blueprint("genAI_routes", __name__)


# genAI routes
@genAI_routes.route("/getMatchedOpportunities", methods=["POST"])
def get_matched_opportunities():
    print("here1")
    return genAI_controller.generate_matched_opportunities(request)

@genAI_routes.route("/getMatcheduserProfiles", methods=["POST"])
def get_matched_user_profile():
    return genAI_controller.generate_matched_user_profile(request)

@genAI_routes.route("/getCustomisedUserProfile", methods=["POST"])
def get_customised_user_profile():
    return genAI_controller._generate_customised_user_profile()


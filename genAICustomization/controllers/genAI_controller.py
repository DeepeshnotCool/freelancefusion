from services import genAI_service

def generate_matched_opportunities(request):
    return genAI_service.generate_matched_opportunities_service(request.json)


def generate_matched_user_profile(request):
    return genAI_service.generate_matched_user_profile_service(request.json)


def _generate_customised_user_profile(request):
    return genAI_service.generate_customised_user_profile_service(request.json)






from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework.exceptions import AuthenticationFailed

from prebunkapi.models.modles import DisinformationTacticModel, LessonModel, OptionSelectionModel, \
    TacticExplainationModel
from prebunkapi.services import get_user_token
from prebunkapi.services.lessons import get_recommended_difficulty_for_tactic, get_lesson_around_difficulty


@api_view(['GET'])
def get_lesson(request, tactic_id) -> Response:
    """
    Fetches a custom lesson for a user based on a firebase user token and the 
    disinformation tactic ID, and returns it in JSON format.

    This view does not return any related IncorrectSelections

    HttpRequest:
        Authorization Header: Bearer {user token}.

    Return: [JSON]
        List of JSON (success): a list of the lesson in JSON format
            * format: [
                {
                  'type': ...,
                  'id': ...,
                  'body' ...,
                },
                {
                  'type': 'option_selection',
                  'id': ...,
                  'body': ...,
                  'correct': ...,
                  'incorrect': ...,
                  'not_sure': ...,
                  'real_difficulty': ...,
                  'opportunity_cost': ...,
                  'feedback': ...,
                },
                {
                  'type': 'option_selection',
                  'id': ...,
                  'body': ...,
                  'is_accurate': ...,
                  'not_sure': ...,
                  'real_difficulty': ...,
                  'opportunity_cost': ...,
                  'feedback': ...,
                },
              ]
        Status 401: Firebase user token was not provided.
        Status 404: Firebase user token did not match an entry in the database.
    """

    # Check if the user token is valid by fetching the user from firebase using the user token in the request
    try:
        user = get_user_token(request)
    except AuthenticationFailed as e:
        # Return 401 (Unauthorized) if the user token is invalid along with suitable error messages
        error_message = {
            'error_title': 'Unauthorized',
            'error_message': str(e),
        }

        return Response(error_message, status=401)

    recommended_difficulty = get_recommended_difficulty_for_tactic(user, tactic_id)

    (lesson_model, tactic_explanations, option_selection_lessons) = get_lesson_around_difficulty(user, tactic_id,
                                                                                                 recommended_difficulty)
    lesson = []

    # Populate the lesson (list of json), which has 1 tactic explainations, followed by 2 option selections lessons
    for tactic_explanation in tactic_explanations:
        o1 = option_selection_lessons.pop()
        o1 = OptionSelectionModel.objects.filter(id=o1.option_selection.id).first()
        o2 = option_selection_lessons.pop()
        o2 = OptionSelectionModel.objects.filter(id=o2.option_selection.id).first()

        def tactic_explaination_json(te: TacticExplainationModel):
            """
            Helper function, return a JSON object for the tactic explaination.
            """
            return {
                'type': 'tactic_explaination',
                'id': te.id,
                'body': te.explaination,
            }

        def option_selection_json(os: OptionSelectionModel):
            """
            Helper function, return a JSON object for the option selection.

            If the option selection correct/incorrect is "Fake" or "Accurate", then we return is_accurate with flag,
            otherwise we return the entire correct/incorrect message.
            """
            if os.correct_option == "Fake" or os.correct_option == "Accurate":
                return {
                    'type': 'option_selection',
                    'id': os.id,
                    'body': os.information,
                    'is_accurate': os.correct_option == "Accurate",
                    'not_sure': os.display_not_sure,
                    'real_difficulty': os.real_difficulty,
                    'opportunity_cost': os.opportunity_cost,
                    'feedback': os.feedback,
                }
            else:
                return {
                    'type': 'option_selection',
                    'id': os.id,
                    'body': os.information,
                    'correct': os.correct_option,
                    'incorrect': os.incorrect_option,
                    'not_sure': os.display_not_sure,
                    'real_difficulty': os.real_difficulty,
                    'opportunity_cost': os.opportunity_cost,
                    'feedback': os.feedback,
                }

        lesson.append(tactic_explaination_json(tactic_explanation))
        lesson.append(option_selection_json(o1))
        lesson.append(option_selection_json(o2))

    disinformation_tactic = DisinformationTacticModel.objects.filter(id=tactic_id).first()

    response = {
        'tactic_id': tactic_id,
        'tactic_name': disinformation_tactic.name,
        'tactic_description': disinformation_tactic.description,
        'lesson_id': lesson_model.lesson_id,
        'general_difficulty': lesson_model.average_difficulty,
        'lesson': lesson,
    }

    print(f'Response: {response}')

    return Response(response, status=200)


@api_view(['POST'])
def post_lesson_results(request, tactic_id, lesson_id) -> Response:
    """
    Receives lesson results from the user and updates the user's lesson history with the results.

    HttpRequest:
        Authorization Header: Bearer {user Token}.

    Expected JSON body:
        {
            "lesson_id": ...,
            "correct_selections": [option selection ID],
            "incorrect_selections": [option selection ID],
        }
    """

    # Check if the user token is valid by fetching the user from firebase using the user token in the request
    try:
        user = get_user_token(request)
    except AuthenticationFailed as e:
        # Return 401 (Unauthorized) if the user token is invalid along with suitable error messages
        error_message = {
            'error_title': 'Unauthorized',
            'error_message': str(e),
        }

        return Response(error_message, status=401)

    # Get the lesson from the database
    lesson = LessonModel.objects.filter(disinformation_tactic=tactic_id, lesson_id=lesson_id).first()

    # calculate the score
    score = 0
    for selection in request.data['correct_selections']:
        score += OptionSelectionModel.objects.filter(id=selection).first().real_difficulty
    for selection in request.data['incorrect_selections']:
        score -= OptionSelectionModel.objects.filter(id=selection).first().real_difficulty

    lesson.score = score
    lesson.save()

    return Response(status=200)


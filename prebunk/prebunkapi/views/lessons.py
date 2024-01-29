from rest_framework.decorators import api_view
from rest_framework.response import Response

from prebunkapi.models.auth import InoculateUser
from prebunkapi.services import get_user_token


@api_view(['GET'])
def get_lesson(request, tactic_id):
    """
    Fetches a custom lesson for a user based on a firebase user token and the 
    disinformation tactic ID.

    This view does not return any related IncorrectSelections

    HttpRequest:
        Authorization Header: Bearer {user token}.

    Return:
        List of JSON (success): a list of the lesson in JSON format.
        Status 401: Firebase user token was not provided.
        Status 404: Firebase user token did not match an entry in the database.
    """
    #try:
    #    user: InoculateUser = get_user_token(request)
    #except ValueError:
    #    return Response({'error': 'Firebase user token was not provided.'}, status=401)
    #except KeyError:
    #    return Response({'error': 'Firebase user token was provided, but did not match a user.'}, status=404)

    # TODO: generate an actual lesson dynamically from user
    # TODO: store the lesson in the database
    lesson: [] = [
        {
            'type': 'tactic_explaination',
            'id': 12,
            'body': '# Tactic Explaination!!! \n\nThis is the explaination!',
        },
        {
            'type': 'option_selection',
            'id': 12,
            'body': '# Option Selection 1!!! \n\nThis is the information!',
            'correct': 'This is the correct option',
            'incorrect': 'This is the incorrect option',
            'not_sure': True,
            'feedback': 'This is the feedback',
        },
        {
            'type': 'tactic_explaination',
            'id': 3,
            'body': '# Explains Tactic!!! \n\nThis is the explaination!',
        },
        {
            'type': 'option_selection',
            'id': 8,
            'body': '# Option Selection 2!!! \n\nThis is more information!',
            'correct': 'This is the correct option',
            'incorrect': 'This is the incorrect option',
            'not_sure': False,
            'feedback': 'You must have selected the incorrect option init.',
        },
        {
            'type': 'option_selection',
            'id': 2,
            'body': '# Option Selection 3!!! \n\nThis is more information!',
            'is_accurate': False,
            'not_sure': False,
            'feedback': 'You must have selected the incorrect option init.',
        },
    ]

    response = {
        'tactic_id': 0,
        'tactic_name': 'Disinformation Tactic',
        'tactic_description': 'A concise description of the disinformation tactic :)',
        'lesson_id': 0,
        'lesson': lesson,
    }

    return Response(response)

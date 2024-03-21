from random import sample

from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response

from prebunkapi.models.modles import DisinformationTacticModel
from prebunkapi.serializers import DisinformationTacticSerializer
from prebunkapi.services import get_user_token
from prebunkapi.services.disinformation_tactics import get_most_recent_tactic, list_disinformation_tactics


@api_view(['GET'])
def get_disinformation_tactics(request):
    """
    Returns an array of all the disinformation tactics
    """

    tactics = DisinformationTacticModel.objects.all()
    serializer = DisinformationTacticSerializer(tactics, many=True)

    return Response(serializer.data, status=status.HTTP_200_OK)


@api_view(['GET'])
def get_disinformation_tactic(request, tactic_id: int):
    """
    Returns the single disinformation tactic
    """

    tactic = DisinformationTacticModel.objects.filter(id=tactic_id).first()

    if tactic is None:
        return Response(status=status.HTTP_404_NOT_FOUND)

    serializer = DisinformationTacticSerializer(tactic, many=False)

    return Response(serializer.data, status=status.HTTP_200_OK)

@api_view(['GET'])
def get_recommended_tactic(request) -> Response:
    """
    Gets the recommended disinformation tactic for the user. Calculated by getting the most recently studied tactic.
    If there is no previous lesson, get a random one from the list of disinformation tactics.

    Args:
        token (str): The user token for the user for whom the recommended tactic is being fetched.

    Returns:
        Response: The recommended disinformation tactic.
    """

    user = get_user_token(request)

    most_recent_tactic = get_most_recent_tactic(user)

    # If there is no most recent tactic, recommend a random one
    if most_recent_tactic is None:
        random_tactic = DisinformationTacticModel.objects.order_by('?').first()
        if random_tactic is not None:
            serializer = DisinformationTacticSerializer(random_tactic, many=False)
            return Response(serializer.data, status=status.HTTP_200_OK)
        else:
            return Response({"error": "No disinformation tactics available."}, status=status.HTTP_418_IM_A_TEAPOT)

    serializer = DisinformationTacticSerializer(most_recent_tactic, many=False)
    return Response(serializer.data, status=status.HTTP_200_OK)


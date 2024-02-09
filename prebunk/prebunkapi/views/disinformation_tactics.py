from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response

from prebunkapi.models.modles import DisinformationTacticModel
from prebunkapi.serializers import DisinformationTacticSerializer


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

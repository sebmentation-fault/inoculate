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

    return Response(serializer.data)


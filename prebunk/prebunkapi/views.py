from rest_framework.decorators import api_view
from django.views.decorators.csrf import csrf_exempt
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from prebunkapi.models import DisinformationTacticModel, TacticExplainationModel, OptionSelectionModel
from prebunkapi.serializers import DisinformationTacticSerializer, TacticExplanationSerializer, OptionSelectionSerializer

@api_view(['GET'])
def get_routes(request):
    """
    Returns all the availiable routes and a description for what each route does.

    Modification of code by Dennis Ivy. Source code unavailable (Reason: live streamed code)
    """
    routes = [
        {
            'Endpoint': '/disinformation_tactics/',
            'method': 'GET',
            'body': None,
            'description': 'Returns an array of disinformation tactics'
        },
        {
            'Endpoint': '/disinformation_tactics/id/',
            'method': 'GET',
            'body': None,
            'description': 'Returns a single disinformation tactic object'
        },
        {
            'Endpoint': '/disinformation_tactics/create/',
            'method': 'POST',
            'body': {'body': ''},
            'description': 'Create a new disinformation tactic with the data sent in the request'
        },
        {
            'Endpoint': '/disinformation_tactics/id/update/',
            'method': 'PUT',
            'body': {'body': ''},
            'description': 'Modify an existing disinformation tactic with the data sent in the request'
        },
        {
            'Endpoint': '/disinformation_tactics/id/delete/',
            'method': 'DELETE',
            'body': None,
            'description': 'Deletes an existing disinformation tactic'
        },
        {
            'Endpoint': '/disinformation_tactics/lessons/',
            'method': 'GET',
            'body': None,
            'description': 'Returns an array of lessons for a given disinformation tactic'
        },
        {
            'Endpoint': '/disinformation_tactics/lessons/id',
            'method': 'GET',
            'body': None,
            'description': 'Returns a single lesson for a given disinformation tactic'
        },
        {
            'Endpoint': '/disinformation_tactics/lessons/id/results',
            'method': 'PUT',
            'body': {'body': ''},
            'description': 'Upload the result for a given lesson'
        },
        {
            'Endpoint': '/disinformation_tactics/lessons/id/delete',
            'method': 'DELETE',
            'body': None,
            'description': 'Deletes an existing entry for a lesson'
        },
    ]
    return Response(routes)


class DisinformationTacticListCreateView(APIView):
    def get(self, request, *args, **kwargs):
        pass

    def post(self, request, *args, **kwargs):
        pass

class DisinformationTacticDetailView(APIView):
    def delete(self, request, arg, *args, **kwargs):
        pass

    def get_object(self, pk):
        pass

class TacticExplanationListCreateView(APIView):
    def get(self, request, *args, **kwargs):
        pass

    def post(self, request, *args, **kwargs):
        pass

class OptionSelectionListCreateView(APIView):
    def get(self, request, *args, **kwargs):
        pass

    def post(self, request, *args, **kwargs):
        pass

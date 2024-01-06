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
        # ------------------ DISINFORMATION TACTIC ------------------ 
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
        # ------------------ LESSONS ------------------ 
        {
            'Endpoint': '/disinformation_tactics/lessons/',
            'method': 'GET',
            'body': None,
            'description': 'Returns an array of lessons for a given disinformation tactic'
        },
        {
            'Endpoint': '/disinformation_tactics/lessons/id/',
            'method': 'GET',
            'body': None,
            'description': 'Returns a single lesson for a given disinformation tactic'
        },
        {
            'Endpoint': '/disinformation_tactics/lessons/id/submit-results/',
            'method': 'CREATE',
            'body': {'body': ''},
            'description': 'Upload the result for a given lesson'
        },
        {
            'Endpoint': '/disinformation_tactics/lessons/id/delete/',
            'method': 'DELETE',
            'body': None,
            'description': 'Deletes an existing entry for a lesson'
        },
        # ------------------ TACTIC EXPLAINATION ------------------ 
        {
            'Endpoint': '/disinformation_tactics/id/explainations/',
            'method': 'GET',
            'body': None,
            'description': 'Returns an array of explainations for a given disinformation tactic'
        },
        {
            'Endpoint': '/disinformation_tactics/id/explainations/create/',
            'method': 'POST',
            'body': {'body': ''},
            'description': 'Create a new explaination for a given disinformation tactic'
        },
        {
            'Endpoint': '/disinformation_tactics/id/explainations/id/',
            'method': 'GET',
            'body': None,
            'description': 'Returns a single explaination for a given disinformation tactic'
        },
        {
            'Endpoint': '/disinformation_tactics/id/explainations/id/update/',
            'method': 'PUT',
            'body': {'body': ''},
            'description': 'Update the contents of an explaination'
        },
        {
            'Endpoint': '/disinformation_tactics/id/explainations/id/delete/',
            'method': 'DELETE',
            'body': None,
            'description': 'Deletes an existing entry for an explaination'
        },
        # ------------------ OPTION SELECTION ------------------ 
        {
            'Endpoint': '/options/',
            'method': 'GET',
            'body': None,
            'description': 'Returns an array of selectable options'
        },
        {
            'Endpoint': '/options/create',
            'method': 'POST',
            'body': {'body': ''},
            'description': 'Create a new option, with the corresponding disinformation tactics in the request'
        },
        {
            'Endpoint': '/options/id',
            'method': 'GET',
            'body': None,
            'description': 'Returns a single option'
        },
        {
            'Endpoint': '/options/id/update',
            'method': 'PUT',
            'body': {'body': ''},
            'description': 'Update the contents of an explaination'
        },
        {
            'Endpoint': '/options/id/delete',
            'method': 'DELETE',
            'body': None,
            'description': 'Deletes an existing entry for an option'
        },
    ]
    return Response(routes)

@api_view(['GET'])
def getDisinformationTactics(request):
    """
    Returns an array of all of the disinformation tactics
    """

    tactics = DisinformationTacticModel.objects.all()
    serializer = DisinformationTacticSerializer(tactics, many=True)
    return Response(serializer.data)



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

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from prebunkapi.models import DisinformationTacticModel, TacticExplainationModel, OptionSelectionModel
from prebunkapi.serializers import DisinformationTacticSerializer, TacticExplanationSerializer, OptionSelectionSerializer

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

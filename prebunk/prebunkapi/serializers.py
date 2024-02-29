from rest_framework import serializers

from prebunkapi.models.modles import *


class DisinformationTacticSerializer(serializers.ModelSerializer):
    class Meta:
        model = DisinformationTacticModel
        fields = '__all__'


class LessonSerializer(serializers.ModelSerializer):
    class Meta:
        model = LessonModel
        fields = '__all__'


class TacticExplanationSerializer(serializers.ModelSerializer):
    class Meta:
        model = TacticExplainationModel
        fields = '__all__'


class OptionSelectionSerializer(serializers.ModelSerializer):
    class Meta:
        model = OptionSelectionModel
        fields = '__all__'


class OptionSelectionTacticSerializer(serializers.ModelSerializer):
    class Meta:
        model = OptionSelectionTacticModel
        fields = '__all__'

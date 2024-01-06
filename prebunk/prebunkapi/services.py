"""
Helper functions for the Views to reduce complexity and code reuse
"""
from django.db import IntegrityError
from django.http import HttpResponseNotFound, HttpResponseBadRequest
from django.core.exceptions import ObjectDoesNotExist, ValidationError
from rest_framework.serializers import Serializer
from rest_framework.status import HTTP_404_NOT_FOUND, HTTP_412_PRECONDITION_FAILED, HTTP_422_UNPROCESSABLE_ENTITY
from prebunkapi.models import DisinformationTacticModel, TacticExplainationModel, OptionSelectionModel
from prebunkapi.serializers import DisinformationTacticSerializer, TacticExplanationSerializer, OptionSelectionSerializer

def get_disinformation_tactic(name: str):
    """
    Get a disinformation tactic instance by primary key.

    Args:
        name (str): Name of the DisinformationTacticModel

    Returns:
        DisinformationTacticModel: DisinformationTacticModel instance.

    Raises:
        ValidationError: The disinformation tactic does not exist.
    """
    try:
        return DisinformationTacticModel.objects.get(name=name)
    except ObjectDoesNotExist:
        error_msg = 'The disinformation tactic does not exist'
        code = HTTP_404_NOT_FOUND
        raise ValidationError(message={'error_msg': error_msg, 'error_code': code})

def list_disinformation_tactics():
    """
    List all disinformation tactics.

    Returns:
        list: List of disinformation tactic instances.
    """
    return DisinformationTacticModel.objects.all()

def create_disinformation_tactic(serializer: Serializer):
    """
    Create a new disinformation tactic.

    Args:
        serializer (DisinformationTacticSerializer): Serializer for creating the disinformation tactic.

    Returns:
        DisinformationTacticModel: Created disinformation tactic instance.
    """
    try:
        is_valid = serializer.is_valid(raise_exception=True)
        if is_valid: return serializer.save()
        else: 
            error_msg = 'The disinformation tactic could not be created'
            code = HTTP_412_PRECONDITION_FAILED
            raise ValidationError(message={'error_msg': error_msg, 'error_code': code})
    except ValidationError:
        error_msg = 'The disinformation tactic could not be created'
        code = HTTP_422_UNPROCESSABLE_ENTITY
        raise ValidationError(message={'error_msg': error_msg, 'error_code': code})


def delete_disinformation_tactic(pk):
    """
    Delete a disinformation tactic by primary key.

    Args:
        pk (int): Primary key of the disinformation tactic.
    """
    disinformation_tactic = get_disinformation_tactic(pk)
    disinformation_tactic.delete()


def list_explanations():
    """
    List all explanations for a given disinformation tactic.

    Args:

    Returns:
        list: List of explanation instances.
    """
    pass


def create_explanation():
    """
    Create a new explanation.

    Args:

    Returns:
        TacticExplainationModel: Created explanation instance.
    """
    pass


def list_options(disinformation_tactic_pk):
    """
    List all options for a given disinformation tactic.

    Args:
        disinformation_tactic_pk (int): Primary key of the disinformation tactic.

    Returns:
        list: List of OptionSelection instances.
    """
    pass

def create_option():
    """
    Create a new option.

    Args:

    Returns:
        OptionSelectionModel: Created OptionSelection instance.
    """
    pass


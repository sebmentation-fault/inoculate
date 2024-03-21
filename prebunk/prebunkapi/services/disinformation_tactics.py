from django.contrib.auth.models import User
from django.core.exceptions import ObjectDoesNotExist, ValidationError

from rest_framework.serializers import Serializer
from rest_framework.status import HTTP_404_NOT_FOUND, HTTP_412_PRECONDITION_FAILED, HTTP_422_UNPROCESSABLE_ENTITY

from prebunkapi.models.modles import DisinformationTacticModel, LessonModel
from prebunkapi.serializers import DisinformationTacticSerializer


def get_disinformation_tactic(name: int) -> DisinformationTacticModel:
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


def list_disinformation_tactics() -> [DisinformationTacticModel]:
    """
    List all disinformation tactics.

    Returns:
        list: List of disinformation tactic instances.
    """
    return DisinformationTacticModel.objects.all()


def create_disinformation_tactic(serializer: Serializer) -> DisinformationTacticModel:
    """
    Create a new disinformation tactic.

    Args:
        serializer (DisinformationTacticSerializer): Serializer for creating the disinformation tactic.

    Returns:
        DisinformationTacticModel: Created disinformation tactic instance.
    """
    try:
        is_valid = serializer.is_valid(raise_exception=True)
        if is_valid:
            return serializer.save()
        else:
            error_msg = 'The disinformation tactic could not be created'
            code = HTTP_412_PRECONDITION_FAILED
            raise ValidationError(message={'error_msg': error_msg, 'error_code': code})
    except ValidationError:
        error_msg = 'The disinformation tactic could not be created'
        code = HTTP_422_UNPROCESSABLE_ENTITY
        raise ValidationError(message={'error_msg': error_msg, 'error_code': code})


def delete_disinformation_tactic(tactic_id: int):
    """
    Delete a disinformation tactic by primary key.

    Args:
        tactic_id (int): Primary key of the disinformation tactic.
    """
    disinformation_tactic = get_disinformation_tactic(tactic_id)
    disinformation_tactic.delete()


def get_most_recent_tactic(user: User) -> DisinformationTacticModel | None:
    """
    Get the most recently studied disinformation tactic for a user.

    Args:
        user (User): The user for whom the most recently studied disinformation tactic is being fetched.

    Returns:
        DisinformationTacticModel: The most recently studied disinformation tactic.
    """

    # Filter all the Lesson Models, and order them by the created date
    try:
        most_recent_lesson = LessonModel.objects.filter(user=user).order_by('-created').first()

        return most_recent_lesson.disinformation_tactic

    except Exception as e:

        return None


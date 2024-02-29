from random import sample

from django.contrib.auth.models import User
from django.db.models import Subquery

from prebunkapi.models.modles import DisinformationTacticModel, OptionSelectionModel, LessonModel, \
    OptionSelectionTacticModel, OptionSelectionLessonModel, TacticExplainationModel


def get_previous_lessons(user: User, tactic_id: int) -> [LessonModel]:
    """
    Service to get the previous lessons that the user has had on a specific disinformation tactic.

    Parameters:
        user (User): The user for whom the previous lessons are being fetched.
        tactic_id (int): The id of the disinformation tactic.

    Returns:
        [LessonModel]: The previous lessons that the user has had on the disinformation tactic.
    """

    # Get the disinformation tactic from the database
    disinformation_tactic = DisinformationTacticModel.objects.filter(id=tactic_id).first()

    # Filter the user's lessons based on the disinformation tactic
    try:
        user_lessons = LessonModel.objects.filter(user=user, disinformation_tactic=disinformation_tactic)
    except TypeError as e:
        # the user has not done this tactic before, so there are no lessons
        return []

    return user_lessons


def get_recommended_difficulty_for_tactic(user: User, tactic_id: int) -> int:
    """
    Returns the recommended difficulty for the next lesson on a specific disinformation tactic. If the user has not yet
    had/done a lesson for this tactic, then the default difficulty (100) is returned, otherwise, the difficulty is the
    most recent difficulty plus/minus the score of the most recent lesson.

    Parameters:
        user (User): The user for whom the difficulty is being recommended.
        tactic_id (int): The id of the disinformation tactic.

    Returns:
        int: The recommended difficulty for the disinformation tactic.
    """

    user_lessons = get_previous_lessons(user, tactic_id)

    # If there is no lesson for the user, create one
    if len(user_lessons) == 0:
        default_difficulty = 100
        return default_difficulty
    else:
        # Get the most recent difficulty
        most_recent_lesson = user_lessons.order_by('-created').first()
        return most_recent_lesson.average_difficulty + most_recent_lesson.score


def get_lesson_around_difficulty(user: User, tactic_id: int, difficulty: int, diff_range: int = 10) -> (LessonModel,
    [TacticExplainationModel], [OptionSelectionLessonModel]):
    """
    Returns a newly made lesson that has option selections that are designed to be around the given difficulty. The
    range of the difficulties is the recommended difficulty plus/minus 10 by default.

    The lesson contains 5 tactic explainations and 10 option selections.

    Parameters:
        user (User): The user for whom the lesson is being served to.
        tactic_id (int): The id of the disinformation tactic.
        difficulty (int): The difficulty around which the lesson is being recommended.
        diff_range (int): The range of the difficulties around the recommended difficulty (defaults to 10)

    Returns:
        (LessonModel, [OptionSelectionLessonModel]): The newly made lesson and the option selections that are in the
        lesson.
    """
    tactic_count = 5
    option_selection_count = 10

    # Get the disinformation tactic from the database
    disinformation_tactic = DisinformationTacticModel.objects.filter(id=tactic_id).first()

    # Filter the tactic explainations based on the disinformation tactic, and get 5 random ones
    tactic_explainations = TacticExplainationModel.objects.filter(disinformation_tactic=disinformation_tactic)
    tactic_explainations = tactic_explainations.order_by('?')[:tactic_count]

    # Filter option selections based on the disinformation tactic and the difficulty
    option_selection_tactics = OptionSelectionTacticModel.objects.filter(disinformation_tactic=disinformation_tactic)

    # Get the option selections that are in the list of option_selection_tactics and where the difficulty is in the
    # range of the difficulty plus/minus 10, and get 10 random ones
    option_selections = OptionSelectionModel.objects.filter(id__in=Subquery(option_selection_tactics
                                                                            .values('option_selection')),
                                                            real_difficulty__gt=difficulty - diff_range,
                                                            real_difficulty__lt=difficulty + diff_range)
    option_selections = option_selections.order_by('?')[:option_selection_count]

    # Set the ID to be the successor to the previous one
    previous_lessons = get_previous_lessons(user, tactic_id)

    if len(previous_lessons) == 0:
        lesson_id = 0
    else:
        lesson_id = previous_lessons.order_by('-lesson_id').first().lesson_id + 1

    # Create a new lesson with these option selections
    # Score is currently set to 0, but will be updated when the user completes the lesson
    lesson = LessonModel.objects.create(user=user, disinformation_tactic=disinformation_tactic, lesson_id=lesson_id,
                                        average_difficulty=difficulty, score=0)

    option_selection_lessons = []

    for option_selection in option_selections:
        option_selection_lessons.append(OptionSelectionLessonModel.objects.create(lesson=lesson,
                                                                                  option_selection=option_selection))

    return lesson, tactic_explainations, option_selection_lessons

from django.db import models
from django.contrib.auth.models import User

class DisinformationTacticModel(models.Model):
    """
    Model representing a disinformation tactic.

    Fields:
        name (CharField): The name of the disinformation tactic.
    """

    name = models.CharField(max_length=255, unique=True, primary_key=True)

    def __str__(self) -> str:
        return str(self.name)


class LessonModel(models.Model):
    """
    Model representing a lesson dynamically generated for a given user.

    Fields:
        user (User): Foreign key to the built-in User model.
        disinformation_tactic (DisinformationTactic): Foreign key to the DisinformationTactic model.
        lesson_id (PositiveIntegerField): Counter for each lesson associated with a user and disinformation tactic.
        date_created (DateTimeField): Date and time when the lesson is created.

    Primary key:
        user, disinformation_tactic and lesson_id

    Meta:
        constraints (list[UniqueConstraint]): Singleton unique constraint containing user, disinformation tactic, and lesson_id for a primary key
    """

    user = models.ForeignKey(User, on_delete=models.CASCADE)
    disinformation_tactic = models.ForeignKey(DisinformationTacticModel, on_delete=models.CASCADE)
    lesson_id = models.IntegerField()
    date_created = models.DateTimeField(auto_now_add=True)

    class Meta:
        constraints = [
            models.UniqueConstraint(
                fields=['user', 'disinformation_tactic', 'lesson_id'],
                name='user_tactic_lesson'
            )
        ]

    def __str__(self) -> str:
        return f'Lesson on "{self.disinformation_tactic}" for {self.user}'


# Lesson Modules

class TacticExplainationModel(models.Model):
    """
    Model to store information about disinformation tactics.

    Fields:
        id (int): 
        disinformation_tactic (DisinformationTacticModel): Foreign key to the DisinformationTacticModel model.
        explaination (str): Detailed information about how to spot a specific disinformation tactic.

    Primary key:
        id
    """

    id = models.AutoField(primary_key=True)
    disinformation_tactic = models.ForeignKey(DisinformationTacticModel, on_delete=models.CASCADE)
    explaination = models.TextField()

    def __str__(self) -> str:
        return f'{self.disinformation_tactic}: {self.explaination}'


class OptionSelectionModel(models.Model):
    """
    Model to store available options for users to choose from.

    Fields:
        information (str): Sets a scene or contains a headline/social media post.
        correct_option (str): Selectable option that is known to be correct.
        incorrect_option (str): Selectable option that is known to be incorrect.
        display_not_sure (bool): Flag dictating whether the user should be allowed to select "not sure".
        decieved_feedback (str): Feedback that is specific to the information seen, describing exactly what went wrong if the user is decieved from it.
        skepical_feedback (str): Feedback that is specific to the information seen, describing exactly what went wrong if the user is skepical of it.
    """

    id = models.AutoField(primary_key=True)
    information = models.TextField()
    correct_option = models.CharField(max_length=256)
    incorrect_option = models.CharField(max_length=256)
    display_not_sure = models.BooleanField()
    decieved_feedback = models.TextField()
    skepical_feedback = models.TextField()
    date_created = models.DateTimeField(auto_now_add=True)

    def __str__(self) -> str:
        return f'Information: {self.information}'


class OptionSelectionTacticModel(models.Model):
    """
    Model to link a many-to-many relationship between TacticExplainationModel and OptionSelectionModel.

    Fields:
        option_selection (OptionSelectionModel): Foreign key to the OptionSelectionModel
        tactic_explaination (OptionSelectionModel): Foreign key to the TacticExplainationModel

    Primary key:
        option_selection and tactic_explaination

    Meta:
        constraints (list[UniqueConstraint]): Singleton unique constraint containing option_selection and tactic_explaination
    """

    id = models.AutoField(primary_key=True)
    option_selection = models.ForeignKey(OptionSelectionModel, on_delete=models.CASCADE)
    tactic_explaination = models.ForeignKey(TacticExplainationModel, on_delete=models.CASCADE)

    class Meta:
        constraints = [
            models.UniqueConstraint(
                fields=['option_selection', 'tactic_explaination'],
                name='option_selection_tactic'
            )
        ]



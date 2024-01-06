from django.db import models
from django.contrib.auth.models import User

class DisinformationTacticModel(models.Model):
    """
    Model representing a disinformation tactic.

    Fields:
        name (CharField): The name of the disinformation tactic.
        created (DateTimeField): The date that the disinformation tactic was created.
        updated (DateTimeField): The date that the disinformation_tactic was last changed.
    """

    name = models.CharField(max_length=255, unique=True, primary_key=True)
    # auto_now_add means on the first time this record is saved
    created = models.DateTimeField(auto_now_add=True)
    # auto_now means on every time this record is saved
    updated = models.DateTimeField(auto_now=True)

    def __str__(self) -> str:
        """
        Return: The first 150 characters of the disinformation_tactic name
        """
        return str(self.name)[0:150]


class LessonModel(models.Model):
    """
    Model representing a lesson dynamically generated for a given user.

    Fields:
        user (User): Foreign key to the built-in User model.
        disinformation_tactic (DisinformationTactic): Foreign key to the DisinformationTactic model.
        lesson_id (PositiveIntegerField): Counter for each lesson associated with a user and disinformation tactic.
        created (DateTimeField): Date and time when the lesson is created.
        updated (DateTimeField): The date that the lesson was last changed.

    Primary key:
        user, disinformation_tactic and lesson_id

    Meta:
        constraints (list[UniqueConstraint]): Singleton unique constraint containing user, disinformation tactic, and lesson_id for a primary key
    """

    user = models.ForeignKey(User, on_delete=models.CASCADE)
    disinformation_tactic = models.ForeignKey(DisinformationTacticModel, on_delete=models.CASCADE)
    lesson_id = models.IntegerField()
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)

    class Meta:
        constraints = [
            models.UniqueConstraint(
                fields=['user', 'disinformation_tactic', 'lesson_id'],
                name='user_tactic_lesson'
            )
        ]

    def __str__(self) -> str:
        """
        Return: The first 45 characters of user and the first 100 of the disinformation_tactic
        """
        u = str(self.user)[0:45]
        dt = str(self.disinformation_tactic)[0:100]
        msg = f'{u} - {dt}'
        return msg


# Lesson Modules

class TacticExplainationModel(models.Model):
    """
    Model to store information about disinformation tactics.

    Fields:
        id (int): 
        disinformation_tactic (DisinformationTacticModel): Foreign key to the DisinformationTacticModel model.
        explaination (str): Detailed information about how to spot a specific disinformation tactic.
        created (DateTimeField): Date and time when the explaination was created.
        updated (DateTimeField): The date that the explaination was last changed.

    Primary key:
        id
    """

    id = models.AutoField(primary_key=True)
    disinformation_tactic = models.ForeignKey(DisinformationTacticModel, on_delete=models.CASCADE)
    explaination = models.TextField()
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)

    def __str__(self) -> str:
        """
        Return: The first 45 characters of the disinformation_tactic and the first 100 of the explaination.
        """
        dt = str(self.disinformation_tactic)[0:45]
        e = str(self.explaination)[0:100]
        msg = f'{dt} - {e}'
        return msg


class OptionSelectionModel(models.Model):
    """
    Model to store available options for users to choose from.

    Fields:
        information (str): Sets a scene or contains a headline/social media post.
        correct_option (str): Selectable option that is known to be correct.
        incorrect_option (str): Selectable option that is known to be incorrect.
        display_not_sure (bool): Flag dictating whether the user should be allowed to select "not sure".
        feedback (str): Feedback that is specific to the information seen, describing exactly what went wrong if the user is skepical of it, or if the user is decieved from it.
        created (DateTimeField): Date and time when the option selection was created.
        updated (DateTimeField): The date that the option selection was last changed.
    """

    id = models.AutoField(primary_key=True)
    information = models.TextField()
    correct_option = models.TextField()
    incorrect_option = models.TextField()
    display_not_sure = models.BooleanField()
    feedback = models.TextField()
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)

    def __str__(self) -> str:
        """
        Return: The first 150 characters of the OptionSelectionModel's information.
        """
        return str(self.information)[0:150]


class OptionSelectionTacticModel(models.Model):
    """
    Model to link a many-to-many relationship between TacticExplainationModel and OptionSelectionModel. 

    Note that this is only necessary for OptionSelection models that are decieptful. Accurate informations will not have a DisinformationTactic by nature.

    Fields:
        option_selection (OptionSelectionModel): Foreign key to the OptionSelectionModel
        tactic_explaination (OptionSelectionModel): Foreign key to the TacticExplainationModel
        created (DateTimeField): Date and time when the option selection tactic was created.
        updated (DateTimeField): The date that the option selection tactic was last changed.

    Primary key:
        option_selection and tactic_explaination

    Meta:
        constraints (list[UniqueConstraint]): Singleton unique constraint containing option_selection and tactic_explaination
    """

    id = models.AutoField(primary_key=True)
    option_selection = models.ForeignKey(OptionSelectionModel, on_delete=models.CASCADE)
    tactic_explaination = models.ForeignKey(TacticExplainationModel, on_delete=models.CASCADE)
    created = models.DateTimeField(auto_now_add=True)
    updated = models.DateTimeField(auto_now=True)

    class Meta:
        constraints = [
            models.UniqueConstraint(
                fields=['option_selection', 'tactic_explaination'],
                name='option_selection_tactic'
            )
        ]

    def __str__(self) -> str:
        """
        Return: The first 70 characters of the option selection and the first 70 of the tactic explaination
        """
        os = str(self.option_selection)[0:70]
        te = str(self.tactic_explaination)[0:70]
        msg = f'{os} - {te}'
        return msg

from django.db import models
from django.contrib.auth.models import User


class InoculateUser(models.Model):
    """
    Model that represents a user of the system.

    Fields:
        user (User): One-to-one key to the built-in User model.
        token (str): A firebase-generated user token.
    """
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    firebase_token = models.TextField()

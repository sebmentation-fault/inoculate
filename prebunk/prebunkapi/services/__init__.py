"""
A set of services that are separate the concern for views to keep track of changes with models.
"""

from django.contrib.auth.models import User
from django.http import HttpRequest

from firebase_auth.authentication import FirebaseAuthentication


def get_user_token(request: HttpRequest) -> User:
    """
    Function to authenticate the user token with the Firebase server.

    Parameters:
        request (HttpRequest): The entire HttpRequest that the api was called with

    Return (User): the user instance

    Raises:
        AuthenticationFailed: If the user token is invalid
    """

    # Check if the user token is valid by fetching the user from firebase using the user token in the request
    firebase_authentication = FirebaseAuthentication()

    return firebase_authentication.authenticate(request)


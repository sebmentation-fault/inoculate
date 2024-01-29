"""
A set of services that are separate the concern for views to keep track of changes with models.
"""

from django.http import HttpRequest

from prebunkapi.models.auth import InoculateUser


def get_user_token(request: HttpRequest) -> InoculateUser | None:
    """
    Parameters:
        request (HttpRequest): The entire HttpRequest that the api was called with

    Return (InoculateUser): the user instance

    Raises:
        ValueError ("No Token"): No token was found in the Authorization header.
        ValueError ("Invalid Token"): The token was found, but did not match a user in the database.
    """

    try:
        token = request.headers.get('Authorization', '').split('Bearer ')[-1]
    except:
        raise ValueError("No Token")

    if not token:
        raise ValueError("No Token")

    try:
        return InoculateUser.objects.get(firebase_token=token)
    except:
        raise KeyError("Invalid Token")

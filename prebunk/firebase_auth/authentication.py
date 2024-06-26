import os

from django.contrib.auth.models import User

from rest_framework import authentication
from rest_framework import exceptions

from firebase_admin import auth, initialize_app, credentials

from .constants import LOCAL_FIREBASE

if LOCAL_FIREBASE:
    os.environ["FIREBASE_AUTH_EMULATOR_HOST"] = "localhost:9099"

# initialises the firebase sdk when this file is imported
try:
    firebase_sdk = os.environ.get('GOOGLE_APPLICATION_CREDENTIALS')

    creds = credentials.Certificate(firebase_sdk)
    firebase_app = initialize_app(creds)
except ValueError:
    raise exceptions.AuthenticationFailed('The Firebase SDK could not be initialized')


class FirebaseAuthentication(authentication.BaseAuthentication):
    """
    When provided with a user token, this class checks it with the Firebase server to verify authenticity.

    Inspiration/Credits to:
    * Oscar Alsing - https://www.oscaralsing.com/firebase-authentication-in-django/

    Maintainer author: Sebastian Kjallgren
    """

    def authenticate(self, request) -> (User, None):
        """
        Method to authenticate the user token with the Firebase server.

        Parameters:
            request (HttpRequest): The entire HttpRequest that the api was called with

        Return (User): the user instance

        Raises:
            AuthenticationFailed: If the user token is invalid
        """
        authorization_header = request.META.get("HTTP_AUTHORIZATION")

        if not authorization_header:
            raise exceptions.AuthenticationFailed('Authorization credentials not provided')

        id_token = authorization_header.split(" ").pop()

        if not id_token:
            raise exceptions.AuthenticationFailed('Authorization credentials not provided')

        try:
            decoded_token = auth.verify_id_token(id_token)
        except Exception:
            raise exceptions.AuthenticationFailed('Invalid ID Token')

        try:
            uid = decoded_token.get("uid")
        except Exception:
            raise exceptions.AuthenticationFailed('No such user exists')

        (user, _) = User.objects.get_or_create(username=uid)

        return user, None

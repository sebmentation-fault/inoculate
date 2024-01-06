

from django.contrib.auth.models import User
from rest_framework import authentication
from rest_framework import exceptions
from firebase_admin import auth, initialize_app

# initialises the firebase sdk
try:
    initialize_app()
except ValueError:
    raise exceptions.AuthenticationFailed('The Firebase SDK could not be initialized')

class FirebaseBackend(authentication.BaseAuthentication):
    """
    When provided with a user token, this class checks it with the Firebase server to verify authenticity.

    Original author: Justin Thomas
    Source: https://medium.com/@justhomas/how-to-connect-flutter-and-firebase-authentication-with-your-django-rest-framework-backend-b7b9a0b1f5cb

    Maintainer author: Sebastian Kjallgren
    """

    def authenticate(self, request):
        authorization_header = request.META.get("HTTP_AUTHORIZATION")

        if not authorization_header:
            raise exceptions.AuthenticationFailed('Authorization credentials not provided')
        id_token = authorization_header.split(" ").pop()

        if not id_token:
            raise exceptions.AuthenticationFailed('Authorization credentials not provided')
        decoded_token = None

        try:
            decoded_token = auth.verify_id_token(id_token)
        except Exception:
            raise exceptions.AuthenticationFailed('Invalid ID Token')

        try:
            uid = decoded_token.get("uid")
        except Exception:
            raise exceptions.AuthenticationFailed('No such user exists')
        
        user= User.objects.get_or_create(username=uid)
        
        return (user, None)

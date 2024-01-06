from django.urls import path

from .views import get_routes

urlpatterns = [
    path('', get_routes)
]

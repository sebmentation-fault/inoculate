from django.urls import path

from .views import get_routes, getDisinformationTactics

urlpatterns = [
    path('', get_routes),
    path('disinformation_tactics/', getDisinformationTactics),
]

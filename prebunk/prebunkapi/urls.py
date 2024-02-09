from django.urls import path

from .views import get_routes
from .views.disinformation_tactics import get_disinformation_tactics, get_disinformation_tactic
from .views.lessons import get_lesson

urlpatterns = [
    path('disinformation_tactics/', get_disinformation_tactics),
    path('disinformation_tactics/<int:tactic_id>', get_disinformation_tactic),
    path('lessons/<int:tactic_id>', get_lesson),
    path('', get_routes),
]

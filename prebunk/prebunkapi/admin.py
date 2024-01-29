from django.contrib import admin

from prebunkapi.models.auth import InoculateUser
from prebunkapi.models.modles import (DisinformationTacticModel, LessonModel, OptionSelectionModel,
                                      OptionSelectionTacticModel, TacticExplainationModel)

# Add the user
admin.site.register(InoculateUser)

# Add the API models
admin.site.register(DisinformationTacticModel)
admin.site.register(LessonModel)
admin.site.register(TacticExplainationModel)
admin.site.register(OptionSelectionModel)
admin.site.register(OptionSelectionTacticModel)

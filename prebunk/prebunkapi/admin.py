from django.contrib import admin

from .models import DisinformationTacticModel, LessonModel, OptionSelectionModel, OptionSelectionTacticModel, TacticExplainationModel

admin.site.register(DisinformationTacticModel)
admin.site.register(LessonModel)
admin.site.register(TacticExplainationModel)
admin.site.register(OptionSelectionModel)
admin.site.register(OptionSelectionTacticModel)

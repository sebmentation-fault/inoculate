# Generated by Django 4.2.7 on 2023-12-15 11:52

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
        ('prebunkapi', '0001_initial'),
    ]

    operations = [
        migrations.CreateModel(
            name='LessonModel',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('lesson_id', models.IntegerField()),
                ('date_created', models.DateTimeField(auto_now_add=True)),
                ('disinformation_tactic', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='prebunkapi.disinformationtacticmodel')),
                ('user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.AddConstraint(
            model_name='lessonmodel',
            constraint=models.UniqueConstraint(fields=('user', 'disinformation_tactic', 'lesson_id'), name='lesson_primary_key'),
        ),
    ]
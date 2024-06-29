from django.db import models

# model => variables

# Create your models here.
class Todo_view(models.Model):
	task = models.CharField(max_length=200, blank=True, default='')
	completed = models.BooleanField(default=False)
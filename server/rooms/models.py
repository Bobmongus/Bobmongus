from django.db import models
from django.conf import settings


# Create your models here.
class Room(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, related_name='rooms')
    isStart = models.BooleanField(default=False)
    roomtitle = models.CharField(max_length=50)
    roomdetail = models.CharField(max_length=300)
    persons = models.IntegerField(default=0)
    endtime = models.DateField()
    linkURL = models.TextField()
    roomTimeStr = models.DateField()


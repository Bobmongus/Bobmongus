from django.db import models
from django.contrib.auth.models import AbstractUser
# Create your models here.

# from django.utils.translation import gettext_lazy as _

# from .managers import UserManager

class User(AbstractUser):
    # id=models.IntegerField(primary_key=True)
    username=None
    email = models.CharField(max_length=30,unique=True)
    password = models.CharField(max_length=30)
    image = models.TextField()
    isLogin = models.BooleanField(default=False)
    isReady = models.BooleanField(default=False)
    isMakingRoom = models.BooleanField(default=False)    
    refreshToken = models.TextField()
    nickname = models.CharField(max_length=10)
    enteredRoom = models.IntegerField(default=0)
    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = []

    # objects = UserManager()

    # def __str__(self):
    #     return self.email
    # 생각해보니까. 그냥 들어가 있는 방의 pk만 알면 될듯?

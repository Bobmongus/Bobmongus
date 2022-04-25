from rest_framework import serializers
# from django.contrib.auth import get_user_model
from .models import User


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        # 어떤 필드 사용할지 생각해야함. 전체 다 쓰면 안될듯?
        fields = ["id","email","password","isLogin","isReady","isMakingRoom","nickname"]
        extra_kwargs = {
            'password': {'write_only': True}
        }

    def create(self, validated_data):
        # password = validated_data.pop('password', None)
        instance = self.Meta.model(**validated_data)
        # if password is not None:
        #     instance.set_password(password)
        instance.save()
        return instance



# User = get_user_model()
# class UserSerializer(serializers.ModelSerializer):
#     password = serializers.CharField(write_only=True)
    
#     class Meta:
#         model = User
#         # 어떤 필드 사용할지 생각해야함. 전체 다 쓰면 안될듯?
#         fields = ("email","password","isLogin","isReady","isMakingRoom","nickname")
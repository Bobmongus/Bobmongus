from rest_framework import serializers
from .models import Room


class RoomListSerializer(serializers.ModelSerializer):
    class Meta:
        model = Room
        fields = ('id', 'roomtitle', 'nowpersons', 'persons', 'endtime', 'roomTimeStr')


class RoomSerializer(serializers.ModelSerializer):
    class Meta:
        model = Room
        # fields = '__all__'
        fields = ('roomtitle', 'roomdetail', 'linkURL', 'personlimit')
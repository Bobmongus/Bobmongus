# from ..accounts.models import User
from django.contrib.auth import get_user_model
from django.shortcuts import get_object_or_404
from .utils import CheckToken
from rest_framework import status

from rest_framework.response import Response
# Create your views here.
from rest_framework.views import APIView

from .serializers import RoomSerializer

from .models import Room
# import simplejson as json

class RoomCreateView(APIView):
    def post(self, request):
        access_token = request.headers.get("access-token")
        refresh_token = request.headers.get("refresh-token")


        pk = request.data['pk']
        # user = User.objects.filter(pk=pk).first()
        user = get_object_or_404(get_user_model(), pk=pk)
        
        # if user is None:
        #     response = Response()
        #     response.data = { 
        #         'message' : 'failed',
        #         'detail': 'User not found',
        #     }
        #     response.status_code = status.HTTP_404_NOT_FOUND
        #     return response
        
        new_access_token, checkError = CheckToken(access_token,refresh_token,int(pk))
        if checkError:
            user.refreshToken = ''
            user.save()
            response = Response()
            response.data = { 
                'message' : 'failed',
                'detail': 'Token Error',
            }
            response.status_code = status.HTTP_401_UNAUTHORIZED
            return response
        
        serializer = RoomSerializer(data=request.data)
        print("통과?")
        if serializer.is_valid(raise_exception=True):
            serializer.save(user=user)
            room = Room.objects.filter(user_id = pk).first()
            room.persons = 1
            room.save()
            user.enteredRoom = room.pk
            user.save()
            response = Response()
            response.headers = {
                'access_token':new_access_token,
            }
            response.data = {
                'message' : 'success',
                'image' : user.image
            }
            response.status_code = status.HTTP_200_OK
            return response
            

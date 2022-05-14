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

from django.utils import timezone
from datetime import timedelta


# 방 생성 -> 방 생성여부 true, 방 유저 목록 추가. 방 인원수 1
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
        print(request.data)
        serializer = RoomSerializer(data=request.data)
        print("통과?")
        if serializer.is_valid(raise_exception=True):
            nowtime = timezone.now()
            settime = int(request.data['settingTime'])
            endtime = nowtime + timedelta(minutes=settime)
            serializer.save(user=user, endtime=endtime, roomTimeStr = nowtime)
            room = Room.objects.filter(user_id = pk).first()
            room.persons = 1
            room.save()
            user.enteredRoom = room.pk
            user.isMakingRoom = True
            user.save()
            response = Response()
            response.headers = {
                'access_token':new_access_token,
            }
            response.data = {
                'message' : 'success'
                # room pk? 
            }
            response.status_code = status.HTTP_200_OK
            return response

# 레디 -> 레디여부 true
class ReadyView(APIView):
    def post(self, request):
        access_token = request.headers.get("access-token")
        refresh_token = request.headers.get("refresh-token")
        pk = request.data['pk']
        user = get_object_or_404(get_user_model(), pk=pk)
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
        
        user.isReady = True
        user.save()

        roompk = request.data['roompk']


        users = get_user_model().objects.filter(enteredRoom=roompk).values("id","email","password","image","isReady","isMakingRoom","nickname","enteredRoom")
        # userlist = []
        # for us in users:
        #     userlist.append(us.values())

        response = Response()
        response.headers = {
            'access_token':new_access_token,
        }
        response.data = {
            'message' : 'success',
            'roomusers': users
        }
        response.status_code = status.HTTP_200_OK
        return response


# 방 들어갈때 -> 방 유저 추가. 방 현재 인원수 +1
class EnterRoomView(APIView):
    def post(self, request):
        access_token = request.headers.get("access-token")
        refresh_token = request.headers.get("refresh-token")

        pk = request.data['pk']
        user = get_object_or_404(get_user_model(), pk=pk)
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

        roompk = request.data['roompk']
        user.enteredRoom = roompk
        user.save()
        users = get_user_model().objects.filter(enteredRoom=roompk).values("id","email","password","image","isReady","isMakingRoom","nickname","enteredRoom")
        room = Room.objects.filter(pk = roompk).first()

        
        # 인원수 다 찬 방에 들어가려고 할때.
        response = Response()
        response.headers = {
            'access_token':new_access_token,
        }
        # if room.persons
        if room:
            if room.personlimit > room.persons:
                room.persons = room.persons + 1
                room.save()
                response.data = {
                    'message' : 'success',
                    'roomusers': users
                }
                response.status_code = status.HTTP_200_OK
                return response
            response.data = {
                'message' : 'failed',
            }
            response.status_code = status.HTTP_400_BAD_REQUEST
            return response
        
        response.data = {
            'message' : 'failed'
        }
        response.status_code = status.HTTP_400_BAD_REQUEST
        return response

# 방 나갈때 -> 레디 풀기, 방 유저에서 없애기, 방 생성여부 false로 바꾸기. 유저 0명일땐 방 폭파시키기.
class ExitRoom(APIView):
    def post(self, request):
        access_token = request.headers.get("access-token")
        refresh_token = request.headers.get("refresh-token")
        pk = request.data['pk']
        user = get_object_or_404(get_user_model(), pk=pk)
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
        
        user.isReady = False
        user.enteredRoom = 0
        user.isMakingRoom = False
        roompk = request.data['roompk']
        room = Room.objects.filter(pk = roompk).first()
        room.persons = room.persons - 1
        if room.persons == 0:
            room.delete()
        else:
            room.save()
        user.save()
        response = Response()
        response.headers = {
            'access_token':new_access_token,
        }
        response.data = {
            'message' : 'success'
        }
        response.status_code = status.HTTP_200_OK
        return response


class GetRoomList(APIView):
    def get(self, request):
        access_token = request.headers.get("access-token")
        refresh_token = request.headers.get("refresh-token")
        pk = request.GET['pk']
        user = get_object_or_404(get_user_model(), pk=pk)
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
        nowtime = timezone.now()
        rooms = Room.objects.filter(endtime__lt = nowtime)
        rooms.delete()
        rooms = Room.objects.all().values("isStart", "pk", "roomtitle", "persons", "endtime", "roomTimeStr")
        # 해당 방의 남은 시간 보내주기.
        for i in range(len(rooms)):
            rooms[i]["remainTime"] = ((rooms[i].get("endtime") - nowtime)).seconds//60
        
        response = Response()
        response.headers = {
            'access_token':new_access_token,
        }
        response.data = {
            'message' : 'success',
            'data': rooms
        }
        response.status_code = status.HTTP_200_OK
        return response

class GetRoomDetail(APIView):
    def get(self, request):
        access_token = request.headers.get("access-token")
        refresh_token = request.headers.get("refresh-token")
        pk = request.GET['pk']
        user = get_object_or_404(get_user_model(), pk=pk)
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
        roompk = request.GET['roompk']
        room = Room.objects.filter(pk = roompk).first()
        response = Response()
        response.headers = {
            'access_token':new_access_token,
        }
        response.data = {
            'message' : 'success',
            'data': {
                "pk":room.pk,
                "isStart": room.isStart,
                "roomtitle": room.roomtitle,
                "roomdetail": room.roomdetail,
                "persons": room.persons,
                "endtime": room.endtime,
                "roomTimeStr": room.roomTimeStr
            }
        }
        response.status_code = status.HTTP_200_OK
        return response

class GetRoomUsers(APIView):
    def get(self, request):
        access_token = request.headers.get("access-token")
        refresh_token = request.headers.get("refresh-token")
        pk = request.GET['pk']
        user = get_object_or_404(get_user_model(), pk=pk)
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
        roompk = request.GET['roompk']
        users = get_user_model().objects.filter(enteredRoom=roompk).values("id","email","password","image","isReady","isMakingRoom","nickname","enteredRoom")
        response = Response()
        response.headers = {
            'access_token':new_access_token,
        }
        response.data = {
            'message' : 'success',
            'data': users
        }
        return response


class StartRoomView(APIView):
    def post(self, request):
        access_token = request.headers.get("access-token")
        refresh_token = request.headers.get("refresh-token")
        pk = request.data['pk']
        user = get_object_or_404(get_user_model(), pk=pk)
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
        roompk = request.data['roompk']
        room = Room.objects.filter(pk = roompk).first()
        response = Response()
        if room != None:
            room.isStart = True
            room.save()
            response.headers = {
            'access_token':new_access_token,
            }
            response.data = {
                'message' : 'success',
                'data': {
                    "pk":room.pk,
                    "isStart": room.isStart,
                    "roomtitle": room.roomtitle,
                    "roomdetail": room.roomdetail,
                    "persons": room.persons,
                    "endtime": room.endtime,
                    "roomTimeStr": room.roomTimeStr
                }
            }
            response.status_code = status.HTTP_200_OK
            return response
        response.response.headers = {
            'access_token':new_access_token,
            }
        response.data = {
            'message' : 'failed',
        }
        response.status_code = status.HTTP_400_BAD_REQUEST
        return response
# import email
# from urllib import response
from os import access
from django.shortcuts import get_object_or_404
from requests import delete
from rest_framework.response import Response
from rest_framework.views import APIView
# from rest_framework.exceptions import AuthenticationFailed
from rest_framework import status
from rest_framework.permissions import IsAuthenticated

from .serializers import UserSerializer
from .models import User
from .utils import CheckToken

import jwt, datetime
from django.contrib.auth import get_user_model


# 회원가입시 이메일 중복확인
class EmailCheckView(APIView):
    def get(self, request):
        # 필수 입력이 앱 단에 처리가 안됐을때 이렇게 쓰자.
        # if not 'email' in request.GET:
        #     response = Response()
        #     response.data = {
        #         'message' : 'failed',
        #         'detail' : '입력한 이메일이 없습니다.'
        #     }
        email = request.GET['email']
        user = User.objects.filter(email=email).first()
        # print(user)
        # user = get_object_or_404(get_user_model(), email=email)
        if user is None:
            response = Response()
            response.data = { 'message' : 'success'}
            response.status_code = status.HTTP_200_OK
            return response
        response = Response()
        response.data = { 'message' : 'failed'} 
        response.status_code = status.HTTP_404_NOT_FOUND
        return response



# 회원가입
class RegisterView(APIView):
    def post(self, request):
        serializer = UserSerializer(data=request.data)
        if not serializer.is_valid():
            response = Response()
            response.data = { 'message' : 'failed'}
            response.status_code = status.HTTP_400_BAD_REQUEST
            return response

        # serializer.is_valid(raise_exception=True)
        serializer.save()
        response = Response()
        response.data = { 'message' : 'success'}
        response.status_code = status.HTTP_201_CREATED
        return response


# 로그인
class LoginView(APIView):
    def post(self, request):
        email = request.data['email']
        password = request.data['password']
        print(email)
        print(password)
        user = User.objects.filter(email=email).first()
        if user is None:
            response = Response()
            response.data = { 
                'message' : 'failed',
                'detail': 'User not found',
            }
            response.status_code = status.HTTP_404_NOT_FOUND
            return response
            # raise AuthenticationFailed('User not found')
        
        if not user.password == password:
            response = Response()
            response.data = { 
                'message' : 'failed',
                'detail': 'password error',
            } 
            response.status_code = status.HTTP_400_BAD_REQUEST
            return response
            # raise AuthenticationFailed('password error')
        # print(user.pk)
        access_payload = {
            'id': user.pk,
            'exp': datetime.datetime.utcnow() + datetime.timedelta(minutes=60),
            'iat': datetime.datetime.utcnow()
        }

        refresh_payload = {
            'id': user.pk,
            'exp': datetime.datetime.utcnow() + datetime.timedelta(hours=1000),
            'iat': datetime.datetime.utcnow()
        }

        access_token = jwt.encode(access_payload, 'secret' , algorithm='HS256')
        refresh_token = jwt.encode(refresh_payload, 'secret', algorithm='HS256')

        user.refreshToken = refresh_token
        user.save()
        
        response = Response()
        response.headers = {
            'access_token':access_token,
            'refresh_token': refresh_token
        }
        response.data = {
            'message': 'success',
            'userid' : user.pk,
            'nickname' : user.nickname,
            'email': user.email,
        }
        response.status_code = status.HTTP_202_ACCEPTED
        print(access_token)
        return response

# 로그아웃
class LogoutView(APIView):
    def post(self, request):
        email = request.data['email']
        user = get_object_or_404(get_user_model(), email=email)
        user.refreshToken = ""
        user.save()
        response = Response()
        response.data = {
            'message' : 'success'
        }
        response.status_code = status.HTTP_200_OK
        return response

# 비밀번호 초기화 (로그인 전)
class ResetPasswordView(APIView):
    def post(self, request):
        email = request.data['email']
        password = request.data['password']
        user = User.objects.filter(email=email).first()
        if user is None:
            response = Response()
            response.data = { 
                'message' : 'failed',
                'detail': 'User not found',
            }
            response.status_code = status.HTTP_404_NOT_FOUND
            return response
        user.password = password
        user.save()
        response = Response()
        response.data = {
            'message' : 'success'
        }
        response.status_code = status.HTTP_200_OK
        return response


# 토큰 필요
class ChangeProfileImageView(APIView):
    def post(self, request):
        access_token = request.headers.get("access-token")
        refresh_token = request.headers.get("refresh-token")
        pk = request.data['pk']
        image = request.data['image']
        user = User.objects.filter(pk=pk).first()
        if user is None:
            response = Response()
            response.data = { 
                'message' : 'failed',
                'detail': 'User not found',
            }
            response.status_code = status.HTTP_404_NOT_FOUND
            return response

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

        user.image = image
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


class DeleteView(APIView):
    def delete(self, request):
        access_token = request.headers.get("access-token")
        print(access_token)
        print(type(access_token))
        refresh_token = request.headers.get("refresh-token")
        pk = request.data['pk']
        new_access_token, checkError = CheckToken(access_token,refresh_token,int(pk))
        user = User.objects.filter(pk=pk).first()
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
        if user is None:
            response = Response()
            response.data = { 
                'message' : 'failed',
                'detail': 'User not found',
            }
            response.status_code = status.HTTP_404_NOT_FOUND
            return response
        user.delete()
        response = Response()
        response.data = { 
            'message' : 'success',
        }
        response.status_code = status.HTTP_200_OK
        return response


# 비밀번호 변경 (로그인 후)
class ChangePasswordView(APIView):
    # 비밀번호 일치 여부 확인
    def get(self, request):
        password = request.GET['password']
        access_token = request.headers.get("access-token")
        refresh_token = request.headers.get("refresh-token")
        pk = request.GET['pk']
        new_access_token, checkError = CheckToken(access_token,refresh_token,int(pk))
        user = User.objects.filter(pk=pk).first()
        
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

        
        if user is None:
            response = Response()
            response.data = { 
                'message' : 'failed',
                'detail': 'User not found',
            }
            response.status_code = status.HTTP_404_NOT_FOUND
            return response
        response = Response()
        
        response.headers = {
            'access_token':new_access_token,
        }
        # print('여기?')
        if user.password == password:
            response.data = { 
            'message' : 'success',
            }
            response.status_code = status.HTTP_200_OK
        else:
            response.data = { 
            'message' : 'failed',
            }
            response.status_code = status.HTTP_400_BAD_REQUEST
        return response


    def post(self, request):
        access_token = request.headers.get("access-token")
        refresh_token = request.headers.get("refresh-token")
        pk = request.data['pk']
        new_access_token, checkError = CheckToken(access_token,refresh_token,int(pk))
        user = User.objects.filter(pk=pk).first()
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
        if user is None:
            response = Response()
            response.data = { 
                'message' : 'failed',
                'detail': 'User not found',
            }
            response.status_code = status.HTTP_404_NOT_FOUND
            return response
        new_password = request.data['password']
        user.password = new_password
        user.save()
        response = Response()
        response.headers = {
            'access_token':new_access_token,
        }
        response.data = { 
            'message' : 'success',
        }
        response.status_code = status.HTTP_200_OK
        return response


# from django.shortcuts import render
# from distutils.command.config import config
# import email
# from django.http.response import JsonResponse
# from django.shortcuts import get_object_or_404
# from django.contrib.auth import get_user_model

# from rest_framework import status
# from rest_framework.decorators import api_view
# from rest_framework.response import Response
# from rest_framework.permissions import IsAuthenticated

# from .serializers import UserSerializer

# @api_view(['GET'])
# def checkemail(request, email):

#     user = get_object_or_404(get_user_model(), email=email)
#     return Response(status=status.HTTP_200_OK)

# @api_view(['POST'])
# def signup(request):
#     password = request.data.get('password')
#     password_confirmation = request.data.get('passwordConfirmation')
#     print(request.data)
#     print(password)
#     # 패스워드 일치 여부 체크
#     if password != password_confirmation:
#         return Response({'error': '비밀번호가 일치하지 않습니다.'}, status=status.HTTP_401_UNAUTHORIZED)

#     serializer = UserSerializer(data=request.data)

#     if serializer.is_valid(raise_exception=True):
#         user = serializer.save()
#         # 비밀번호 해싱
#         # user.set_username("hi")
#         user.set_password(request.data.get('password'))
#         user.save()
#         return Response(serializer.data, status=status.HTTP_201_CREATED)

# # def login():
# # https://www.youtube.com/watch?v=l6Pfu4L_y_k 참고 바람
# #     pass


# @api_view(['POST'])
# def resetpassword(request):
#     pass


# def login(request):
#     email = request.data.get('email')
#     password = request.data.get('email')
#     user = get_object_or_404(get_user_model(), email=email, password=password)

#     pass
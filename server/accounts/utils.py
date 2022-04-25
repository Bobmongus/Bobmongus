import jwt, datetime
from .models import User


def CheckToken(access_token, refresh_token, pk):
    # refresh token이 들어오면, access_token이 만료되었다는 거니까,
    # refresh 토큰을 확인하고, 아직 만료되지 않았다면 access_token을 다시 발급해준다.
    # refresh 토큰이 만료되었다면? 로그아웃 시켜야함.
    checkError = False
    if refresh_token:
        try:
            refresh_payload = jwt.decode(refresh_token, 'secret', algorithms='HS256')
            if refresh_payload.get('id') != pk:
                checkError = True
            # 리프레시 토큰이 만료되었다면. 유저 정보에서 리프레시 토큰 날리기.
            if refresh_payload.get('exp') < datetime.datetime.utcnow().timestamp():
                user = User.objects.filter(pk=pk).first()
                if user in None:
                    checkError = True
                user.refreshToken = ''
                user.save()
                checkError = True
            
            # 만료 안되었다면? 엑세스토큰 발행해서 반환
            access_payload = {
                'id': pk,
                'exp': datetime.datetime.utcnow() + datetime.timedelta(minutes=60),
                'iat': datetime.datetime.utcnow()
            }
            # 새로 발행
            newAccessToken = jwt.encode(access_payload, 'secret' , algorithm='HS256')
            return [newAccessToken, checkError]
        except (jwt.ExpiredSignatureError, jwt.exceptions.InvalidSignatureError):
            return ['',True]
    # refresh 토큰이 없다면? access token이 유효한지만 체크하면 됨.
    else:
        try:
            access_payload = jwt.decode(access_token, 'secret', algorithms='HS256')
            id = access_payload.get('id')
            user = User.objects.filter(pk=id).first()
            if user is None:
                checkError = True
            refresh_payload = jwt.decode(user.refreshToken,'secret', algorithms='HS256')
            if access_payload.get('id') != refresh_payload.get('id'):
                checkError = True
            access_payload = {
                'id': pk,
                'exp': datetime.datetime.utcnow() + datetime.timedelta(minutes=60),
                'iat': datetime.datetime.utcnow()
            }
            newAccessToken = jwt.encode(access_payload, 'secret' , algorithm='HS256')
            return [newAccessToken, checkError]
        except (jwt.ExpiredSignatureError, jwt.exceptions.InvalidSignatureError):
            try:
                user = User.objects.filter(pk=pk).first()
                if user is None:
                    checkError = True
                refresh_payload = jwt.decode(user.refreshToken,'secret', algorithms='HS256')
                if pk != refresh_payload.get('id'):
                    checkError = True
                access_payload = {
                    'id': pk,
                    'exp': datetime.datetime.utcnow() + datetime.timedelta(minutes=60),
                    'iat': datetime.datetime.utcnow()
                }
                newAccessToken = jwt.encode(access_payload, 'secret' , algorithm='HS256')
            except (jwt.ExpiredSignatureError, jwt.exceptions.InvalidSignatureError):
                return ['',True]
            
            return [newAccessToken, checkError]
from django.urls import path

from .views import RoomCreateView, ReadyView, EnterRoomView,ExitRoom, GetRoomList, GetRoomDetail, GetRoomUsers
urlpatterns = [
    path('createroom', RoomCreateView.as_view()),
    path('ready', ReadyView.as_view()),
    path('enterroom', EnterRoomView.as_view()),
    path('exitroom', ExitRoom.as_view()),
    path('getroomlist', GetRoomList.as_view()),
    path('getroomdetail', GetRoomDetail.as_view()),
    path('getroomusers', GetRoomUsers.as_view())
]
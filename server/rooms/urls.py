from django.urls import path

from .views import RoomCreateView, ReadyView, EnterRoomView
urlpatterns = [
    path('createroom', RoomCreateView.as_view()),
    path('ready', ReadyView.as_view()),
    path('enterroom', EnterRoomView.as_view()),
    
]
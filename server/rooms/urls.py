from django.urls import path

from .views import RoomCreateView
urlpatterns = [
    path('createroom', RoomCreateView.as_view()),

]
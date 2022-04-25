from django.urls import path , include
# from . import views
from .views import EmailCheckView,ResetPasswordView,RegisterView,LoginView,LogoutView,ChangeProfileImageView, DeleteView

urlpatterns = [
    # path('', include('dj_rest_auth.urls')),
    # path('registration/', include('dj_rest_auth.registration.urls')),


    # path('checkemail/<str:email>/',views.checkemail),
    # path('signup/', views.signup),
    # path('login/', views.login)
    path('emailcheck', EmailCheckView.as_view()),
    path('resetpassword', ResetPasswordView.as_view()),
    path('register', RegisterView.as_view()),
    path('login', LoginView.as_view()),
    path('logout', LogoutView.as_view()),

    path('changeprofileimage', ChangeProfileImageView.as_view()),
    path('deleteuser', DeleteView.as_view())

]
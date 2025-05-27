from django.urls import path
from .views import SchemeListView, diagnose


urlpatterns = [
    path('api/schemes/', SchemeListView.as_view(), name='scheme-list'),
    path('api/diagnose/', diagnose, name='diagnose'),
]

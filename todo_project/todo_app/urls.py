from django.urls import path
from todo_app 	 import TodoView

urlpatterns = [
	path('todo', TodoView.as_view())
]
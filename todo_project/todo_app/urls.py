from django.urls    import path
from todo_app.views import TodoView
from todo_app.views import HomePageView

urlpatterns = [
	path('todo/', TodoView.as_view(),     name="todo"),
    path(''     , HomePageView.as_view(), name="home")
]
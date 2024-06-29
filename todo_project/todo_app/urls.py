from django.urls    import path
from todo_app.views import TodoView

urlpatterns = [
	path('todo', TodoView.as_view())
]
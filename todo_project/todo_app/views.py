from django.shortcuts import render
from rest_framework.response import Response
from rest_framework.views 	 import APIView
from todo_app.models import Todo_model
from django.http import HttpResponse

# Create your views here.
class TodoView(APIView):
	def post(self, request):
		data = request.data.dict()
		todo = Todo_model(task=data['task'], completed=data['completed'])
		todo.save()
		return Response(200)
		
	def get(self, request):
		items = [(x.task, x.completed) for x in Todo_model.objects.all()]
		return Response(items)

class HomePageView(APIView):
    def get(self, request):
        return HttpResponse("I love Ayooya!")
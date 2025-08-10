from django.urls import path, include
#from .views import test_api_view
#from rest_framework.routers import DefaultRouter
from .views import BookListView, BookDetailView

'''router = DefaultRouter()
router.register(r'books', BookListView, BookDetailView)'''

urlpatterns = [
    #path('test/', test_api_view),
    #path('', include(router.urls)),
    path('books/', BookListView.as_view(), name='book-list'),
    path('books/<int:pk>/', BookDetailView.as_view(), name='book-detail'),
]
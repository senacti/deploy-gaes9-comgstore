from django.urls import path
from . import views
urlpattern = [
  
    path('<pk>', views.ProductDetailView.as_view(), name='product'),
  
]
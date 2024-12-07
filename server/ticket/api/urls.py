from django.urls import path
from .views import TicketDetail, TicketList, BookATicket

tickets_url_prefix = 'tickets'

urlpatterns = [
    path(tickets_url_prefix+'/', TicketList.as_view(), name='ticket-list'),
    path(tickets_url_prefix+'/<int:pk>/', TicketDetail.as_view(), name='ticket-detail'),
    path(tickets_url_prefix+'/book/<int:pk>/', BookATicket.as_view(), name='book-ticket'),
]
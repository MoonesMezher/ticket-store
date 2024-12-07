from rest_framework import generics
from .models import Ticket
from .serializers import TicketSerializer
from rest_framework.response import Response
from rest_framework import status

class TicketList(generics.ListCreateAPIView):
    serializer_class = TicketSerializer
    
    def get_queryset(self):
        # Assuming you want to filter tickets that have no related comments
        return Ticket.objects.filter(available_tickets__gt=0)

class TicketDetail(generics.RetrieveUpdateDestroyAPIView):
    queryset = Ticket.objects.all()
    serializer_class = TicketSerializer
    
class BookATicket(generics.UpdateAPIView):
    queryset = Ticket.objects.all()
    serializer_class = TicketSerializer

    def patch(self, request, *args, **kwargs):
        ticket = self.get_object()  # Get the ticket instance

        # Check if the ticket is already booked
        if ticket.available_tickets == 0:
            return Response({"detail": "No available tickets to this trip."}, status=status.HTTP_400_BAD_REQUEST)

        # Get the user's email from the request body
        user_email = request.data.get('user_email')
        if not user_email:
            return Response({"detail": "User email is required."}, status=status.HTTP_400_BAD_REQUEST)

        # Update the booking status and save the user's email
        ticket.available_tickets = ticket.available_tickets - 1
        ticket.save()

        serializer = self.get_serializer(ticket)
        return Response(serializer.data, status=status.HTTP_200_OK)
    
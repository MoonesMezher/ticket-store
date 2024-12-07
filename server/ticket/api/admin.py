from django.contrib import admin

from .models import Ticket
# Register your models here.
admin.site.site_header = 'Tickets Store Admin'
admin.site.site_title = 'Welcome to Tickets Store Admin'
admin.site.index_title = 'Welcome to Tickets Store Admin'

admin.site.register(Ticket)

from django import template

register = template.Library()


#Filtro para mostrar el precio de los productos 
@register.filter()
def price_format(value):
    return '${0:.2f}'.format(value)
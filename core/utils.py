from core.models import Order
from core.models import Sales

def get_or_create_cart(request):
    user = request.user if request.user.is_authenticated else None
    profile = Profile.objects.get(user=user)
    id = request.session.get('id')
    carrito = Sales.objects.filter(pk= id).first()

    if carrito is None:
        carrito = Sales.objects.create(id_user = profile)

    if profile and carrito.id_user is None:
        carrito.id_user = profile
        carrito.save()

    request.session['id'] = carrito.cod_sale

def get_or_create_order(carrito, request):
    order = Order.objects.filter(cod_sale=carrito).first()

    if order is None and profile:
        order = Order.objects.create(cod_sale = carrito, id_user = profile)

    if order:
        request.session['order_id'] = order.cod_order

    return order
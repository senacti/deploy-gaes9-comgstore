from decimal import Decimal
from django.conf import settings
from re import template
from django.shortcuts import render
from django.contrib.auth import authenticate
from django.shortcuts import redirect

from django.contrib.auth import login
from django.contrib.auth import logout

# Libreria para imagen
import matplotlib.image as mpimg
import matplotlib.pyplot as plt

# Libreria para tener acceso a la base de datos
import MySQLdb

# importacion de modelos
from django.contrib.auth.models import User, Group
from core.models import Order, Profile
from core.models import Rol
from core.models import Sales, Purchase
from core.models import Supplier
from core.models import Order, Delivery, StateDomicile, OrderStatus
from core.models import Product, Client
from core.models import SalesDetail, PurchaseDetail
from django.contrib.auth.decorators import login_required , permission_required 

# Importacion paginator
from django.core.paginator import Paginator
from django.http import Http404

#importacion para graficas
from datetime import datetime
from django.db.models.functions import Coalesce
from django.db.models import Sum

# importaciones del email
from django.contrib import messages
import smtplib
from email.message import EmailMessage
from django.template.loader import get_template
from django.core.mail import EmailMultiAlternatives
from django.core.mail import send_mail

# importaciones para redirigir
from django.shortcuts import redirect
from django.shortcuts import reverse
from django.urls import reverse_lazy
from django.shortcuts import get_object_or_404
from django.db import transaction
import sys

from django.template.loader import render_to_string
from django.conf import settings


# importaciones para crear los formularios, actualizar y enviar mensajes con clases
from core.forms import SupplierForm, ProductForm
from django.views.generic.list import ListView
from django.views.generic import View
from django.views.generic.edit import UpdateView
from django.views.generic.edit import DeleteView
from django.contrib.auth.mixins import LoginRequiredMixin
from django.contrib.messages.views import SuccessMessageMixin

# Imports PDF
from xhtml2pdf import pisa
from io import BytesIO
from django.http import HttpResponse
from django.template.loader import get_template

# Inicio Vistas
def index(request):
    return render(request, 'index.html', {
        # context
    })


def informacion(request):
    return render(request, 'informacion.html', {
        # context
    })

@login_required
def sinacceso(request):

    user = request.user if request.user.is_authenticated else None
    profile = Profile.objects.get(user=user)

    rol_client = Rol.objects.get(cod_rol=3)
    rol_employee = Rol.objects.get(cod_rol = 2)
    rol_admin = Rol.objects.get(cod_rol = 1)

    return render(request, 'sinacceso.html', {
        'profile': profile,
        'client' : rol_client,
        'employee' : rol_employee,
        'admin': rol_admin
    })




def Formularioinicio(request):
    return render(request, 'registration/Formularioinicio.html', {
        # context
    })

def FormularioContacto(request):
    return render(request, 'contactenos.html')

def contactenos(request):
    if request.method == "POST":
        name = request.POST.get('nombre')
        email = request.POST.get('correo')
        asunto = request.POST.get('asunto')
        message = request.POST.get('mensaje')
        
        ctx = {
           'name' : name,
           'asunto' : asunto,
           'email' : email,
           'message' : message
       }
        message = render_to_string('email_template.html', ctx)
        send_mail('Solicitud',
        message,
        settings.EMAIL_HOST_USER,
                  ['creativecomunity121@gmail.com'],
        fail_silently=False, html_message=message)
        # context
    return render(request, 'contactenos.html')
# Fin: Inicio Vistas


# Admnistrador vistas
# Registros Admin

@login_required
@permission_required('auth.add_user', login_url='sinacceso')
def Administrador(request):
    user = request.user if request.user.is_authenticated else None
    profile = Profile.objects.get(user=user)

    rol_client = Rol.objects.get(cod_rol=3)
    rol_employee = Rol.objects.get(cod_rol = 2)

    if profile.cod_rol == rol_client or profile.cod_rol == rol_employee:
        return redirect('sinacceso')
    
    else:
        return render(request, 'administrador/Administrador.html', {
            # context
        })


@login_required
@permission_required('core.add_profile', login_url='sinacceso')
def AdminRegistroE(request):
    if request.method == 'POST':
        id_number = request.POST.get('identificacion_empleado')
        username = request.POST.get('nombre_usuario')
        first_name = request.POST.get('nombres')
        last_name = request.POST.get('apellidos')
        birthdate = request.POST.get('fecha_nacimiento')
        gender = request.POST.get('genero')
        telephone_number = request.POST.get('telefono')
        address = request.POST.get('direccion')
        email = request.POST.get('correo')
        password = request.POST.get('contraseña')

        group = Group.objects.get(name= 'Empleados')

        user = User.objects.create_user(
            username=username, email=email, password=password)
        user.is_staff = False
        user.is_superuser = False
        user.groups.add(group)
        user.first_name = first_name
        user.last_name = last_name
        user.save()

        rol = Rol.objects.get(cod_rol=2)


        
        profile = Profile.objects.create(user=user, id_profile=id_number, birthdate=birthdate, gender=gender,
                                         telephone_number=telephone_number, address=address, cod_rol=rol, state=True)
        profile.save()

    return render(request, 'administrador/registroempleado.html', {
        # context
    })


@login_required
@permission_required('core.add_supplier', login_url='sinacceso')
def AdminRegistroProv(request):

    form = SupplierForm(request.POST or None)
    supplier_list = Supplier.objects.all().order_by('cod_supplier')

    if request.method == 'POST' and form.is_valid():
        supplier = form.save()
        messages.success(request, "Proveedor creado exitosamente")

    return render(request, 'administrador/registroproveedor.html', {
        'form': form,
        'supplier_list': supplier_list
    })


@login_required
@permission_required('core.add_product', login_url='sinacceso')
def AdminRegistroProd(request):

    form = ProductForm(request.POST, request.FILES or None)

    if request.method == 'POST' and form.is_valid():
        form.save()
        messages.success(request, "Producto creado exitosamente")
        return redirect('AdminConsultaProd')

    return render(request, 'administrador/registroproducto.html', {
        'form' : form
    })


@login_required
@permission_required('core.add_purchase', login_url='sinacceso')
def AdminRegistroCom(request):

    user = request.user if request.user.is_authenticated else None
    profile = Profile.objects.get(user=user)
    id = request.session.get('id')
    compra = Purchase.objects.filter(pk=id).first()

    if compra is None:
        compra = Purchase.objects.create(id_user=profile)

    if profile and compra.id_user is None:
        compra.id_user = profile
        compra.save()

    request.session['id'] = compra.cod_purchase

    products = Product.objects.all().order_by('cod_product')
    suppliers = Supplier.objects.all()

    return render(request, 'administrador/compra.html', {
        'products': products,
        'compra': compra,
        'supplier': suppliers,
    })

@login_required
@permission_required('core.add_purchasedetail', login_url='sinacceso')
def add_products_purchase(request):

    user = request.user if request.user.is_authenticated else None
    profile = Profile.objects.get(user=user)
    id = request.session.get('id')
    compra = Purchase.objects.filter(pk=id).first()

    if compra is None:
        compra = Purchase.objects.create(id_user=profile)

    if profile and compra.id_user is None:
        compra.id_user = profile
        compra.save()

    request.session['id'] = compra.cod_purchase

    if request.method == 'POST':

        product = Product.objects.get(pk=request.POST.get('product_id'))
        #product = get_object_or_404(Product, pk=request.POST.get('product_id'))
        messages.success(request, "Producto agregado a la compra")
        quantity = int(request.POST.get('quantity', 1))
        # carrito.cod_product.add(product, through_defaults={
        # 'quantity' : quantity
        # )

        purchase_product = PurchaseDetail.objects.create_or_update_quantity_purchase(purchase=compra,
                                                                     product=product,
                                                                     quantity=quantity)

        product.stock = product.stock + quantity
        product.save()

    else:

        product = compra.cod_product.all()

        return render(request, 'administrador/ListadoCompra.html', {
            'product': product,
            'compra': compra,
        })

    return redirect('AdminRegistroCom')

@login_required
@permission_required('core.delete_purchasedetail', login_url='sinacceso')
def remove_products_purchase(request):
    user = request.user if request.user.is_authenticated else None
    profile = Profile.objects.get(user=user)
    id = request.session.get('id')
    compra = Purchase.objects.filter(pk=id).first()

    if compra is None:
        compra = Purchase.objects.create(id_user=profile)

    if profile and compra.id_user is None:
        compra.id_user = profile
        compra.save()

    request.session['id'] = compra.cod_purchase

    if request.method == 'POST':
        messages.error(request, "Producto Eliminado")
        product = Product.objects.get(pk=request.POST.get('product_remove'))

        for cp in compra.products_related_purchase():
            if cp.product == product:
                quantity_eliminated = cp.quantity

        product.stock = product.stock - quantity_eliminated
        product.save()

        compra.cod_product.remove(product)

        return redirect('AdminRegistroCom')

    return render(request, 'administrador/ListadoCompra.html', {
        'product': product,
        'compra': compra,
    })

@login_required
@permission_required('core.add_purchasedetail', login_url='sinacceso')
def guardarCompra(request):

    if request.method == 'POST':
        user = request.user if request.user.is_authenticated else None
        profile = Profile.objects.get(user=user)
        id = request.session.get('id')
        compra = Purchase.objects.filter(pk=id).first()

        if compra is None:
            compra = Purchase.objects.create(id_user=profile)

        if profile and compra.id_user is None:
            compra.id_user = profile
            compra.save()

        request.session['id'] = compra.cod_purchase

        supplier = Supplier.objects.get(pk=request.POST.get('supplier'))
        compra.supplier = supplier

        for v in compra.products_related_purchase():
            v.subtotal = v.product.price_supplier * v.quantity
            v.save()

        compra.save()

        request.session['id'] = None

        messages.success(request, 'Compra registrada exitosamente')
        return redirect('AdminConsultaCom')


@login_required
@permission_required('core.add_sales, auth.add_user', login_url='sinacceso')
def AdminRegistroVen(request):

    user = request.user if request.user.is_authenticated else None
    profile = Profile.objects.get(user=user)
    id = request.session.get('id')
    venta = Sales.objects.filter(pk=id).first()

    if venta is None:
        venta = Sales.objects.create(id_user=profile)

    if profile and venta.id_user is None:
        venta.id_user = profile
        venta.save()

    request.session['id'] = venta.cod_sale

    products_sa = Product.objects.all()
    clients = Client.objects.all()

    return render(request, 'administrador/venta.html', {
        'products_sa': products_sa,
        'venta' : venta,
        'client' : clients
    })

@login_required
@permission_required('core.add_inventorymovement, auth.add_user', login_url='sinacceso')
def AdminRegistroInv(request):
    return render(request, 'administrador/inventario.html', {
        # context
    })

# Consultas Admin


@login_required
@permission_required('auth.add_user', login_url='sinacceso')
def AdminConsultaE(request):

    rol = Rol.objects.get(cod_rol=2)
    employees_list = Profile.objects.filter(cod_rol = rol).order_by('id_profile')

    return render(request, 'administrador/consultaempleado.html', {
        'employees' : employees_list
    })

# Proveedor comparte el apartado en el registro


@login_required
@permission_required('core.add_product', login_url='sinacceso')
def AdminConsultaProd(request):

    product_list = Product.objects.all().order_by('cod_product')

    page = request.GET.get('page', 1)
    
    try:
        paginator = Paginator(product_list, 5)
        product_list = paginator.page(page)
    except:
        raise Http404

    return render(request, 'administrador/consultaproducto.html', {
        'product_list' : product_list,
        'paginator': paginator
    })


@login_required
@permission_required('core.view_purchase', login_url='sinacceso')
def AdminConsultaCom(request):

    user = request.user if request.user.is_authenticated else None
    profile = Profile.objects.get(user=user)

    purchase = Purchase.objects.filter(id_user=profile)

    return render(request, 'administrador/consultacompra.html', {
        'purchase': purchase
    })


@login_required
@permission_required('core.view_sales , auth.add_user', login_url='sinacceso')
def AdminConsultaVen(request):

    user = request.user if request.user.is_authenticated else None
    profile = Profile.objects.get(user=user)

    sales = Sales.objects.filter(id_user=profile)

    return render(request, 'administrador/consultaventa.html', {
        'sales' : sales
    })


@login_required
@permission_required('core.view_inventorymovement', login_url='sinacceso')
def AdminConsultaInv(request):
    return render(request, 'administrador/consultainventario.html', {
        # context
    })

# Pedido solo tiene apartado de consulta

@login_required
@permission_required('core.view_order, auth.add_user', login_url='sinacceso')
def AdminConsultaPed(request):
    
    orders = Order.objects.filter(status = OrderStatus.CREATED).all().order_by('cod_order')
    orders_completed = Order.objects.filter(status = OrderStatus.COMPLETED).all().order_by('cod_order')
    rol_employee = Rol.objects.get(cod_rol = 2)
    employees = Profile.objects.filter(cod_rol = rol_employee)

    state_domicile = StateDomicile.objects.get(cod_state_domicile = 2)
    deliver = Delivery.objects.filter(state_domicile = state_domicile).all()

    return render(request, 'administrador/pedidos.html', {
        'orders' : orders,
        'deliveries' : deliver,
        'orders_completed' : orders_completed,
        'employees' : employees,
    })

@login_required
@permission_required('core.add_delivery', login_url='sinacceso')
def assign_deliver(request):
    if request.method == 'POST':
        order_id = Order.objects.get(cod_order= request.POST.get('order_id'))
        employee = Profile.objects.get(id_profile = request.POST.get('employee'))
        state_domicile = StateDomicile.objects.get(cod_state_domicile = 2)

        deliver = Delivery.objects.create(state_domicile= state_domicile, id_user = employee, code_order = order_id)
        deliver.save()

        order = Order.objects.get(cod_order = request.POST.get('order_id'))
        order.complete()
    
    return redirect('AdminConsultaPed')


@login_required
@permission_required('core.add_delivery', login_url='sinacceso')
def reassigned_deliver(request):
    if request.method == 'POST':
        deliver = Delivery.objects.get(cod_delivery = request.POST.get('id_deliver'))
        profile = Profile.objects.get(id_profile = request.POST.get('employee_reassigned'))
        deliver.id_user = profile

        deliver.save()

    return redirect('AdminConsultaPed')

# Fin: Consultas Admin

# Factura
@login_required
def Factura(request, id_sale):

    venta = Sales.objects.filter(cod_sale = id_sale).get(cod_sale = id_sale)

    user = request.user 
    profile = Profile.objects.get(user=user)

    rol_admin = Rol.objects.get(cod_rol=1)
    rol_employee = Rol.objects.get(cod_rol=2)
    rol_client = Rol.objects.get(cod_rol = 3)


    return render(request, 'reports/factura.html', {
        'venta': venta,
        'profile': profile,
        'admin': rol_admin,
        'employee': rol_employee,
        'client' : rol_client
    })


@login_required
def Factura_compra(request, id_purchase):
    compra = Purchase.objects.filter(cod_purchase = id_purchase).get(cod_purchase = id_purchase)

    return render(request, 'reports/factura_compra.html', {
        'compra' : compra
    })


# Eliminacion Admin

@login_required
@permission_required('core.delete_product', login_url='sinacceso')
def AdminEliminarProd(request):
    return render(request, 'administrador/eliminarproducto.html', {
        # context
    })
# Fin: Eliminacion Admin

# Actualizacion Admin

@login_required
@permission_required('auth.add_user', login_url='sinacceso')
def AdminUpdateE(request, id_profile):

    profile = Profile.objects.filter(id_profile = id_profile).first()

    return render(request, 'administrador/actualizarempleado.html', {
        'profile': profile
    })

@login_required
@permission_required('auth.change_user', login_url='sinacceso')
def ActualizarEmpleado(request):
    if request.method == 'POST':
        id_profile = int(request.POST.get('id_profile'))
        id_user = int(request.POST.get('id_user'))
        username = request.POST.get('nombre_usuario')
        first_name = request.POST.get('nombres')
        last_name = request.POST.get('apellidos')
        telephone_number = request.POST.get('telefono')
        address = request.POST.get('direccion')
        email = request.POST.get('correo')

        profile = Profile.objects.get(id_profile= id_profile)
        profile.telephone_number = telephone_number
        profile.address = address

        profile.save()

        user = User.objects.get(id= id_user)
        user.username = username
        user.first_name = first_name
        user.last_name = last_name
        user.email = email

        user.save()
    rol_employee = Rol.objects.get(cod_rol = 2)
    rol_client = Rol.objects.get(cod_rol = 3)
    if profile.cod_rol == rol_employee:
        return redirect('AdminConsultaE')
    elif profile.cod_rol == rol_client:
        return redirect('ActualizarInfo')

@login_required
@permission_required('core.change_product', login_url='sinacceso')
def AdminUpdateProd(request):
    return render(request, 'administrador/actualizarproducto.html', {
        # context
    })
# Fin: Actualizacion Admin

# Fin: Admnistrador vistas

# Empleado vistas
# sys.setrecursionlimit(2500)


@login_required
def Empleado(request):
    return render(request, 'empleado/Empleado.html', {
        # context
    })
# Registros Empleado


@login_required
@permission_required('core.add_sales', login_url='sinacceso')
def EResgistroVen(request):

    user = request.user if request.user.is_authenticated else None
    profile = Profile.objects.get(user=user)
    id = request.session.get('id')
    venta = Sales.objects.filter(pk=id).first()

    if venta is None:
        venta = Sales.objects.create(id_user=profile)

    if profile and venta.id_user is None:
        venta.id_user = profile
        venta.save()

    request.session['id'] = venta.cod_sale

    products = Product.objects.all().order_by('cod_product')
    clients = Client.objects.all()

    return render(request, 'empleado/ventaempleado.html', {
        'products': products,
        'venta': venta,
        'client': clients,
    })

@login_required
def add_products_emp(request):

    usuario = request.user if request.user.is_authenticated else None
    perfil = Profile.objects.get(user=usuario)

    empleado = Rol.objects.get(cod_rol = 2)
    administrador = Rol.objects.get(cod_rol = 1)

    add_products_sales(request)

    if perfil.cod_rol == empleado:
        return redirect('EResgistroVen')
    elif perfil.cod_rol == administrador:
        return redirect('AdminRegistroVen')

@login_required
def remove_product_emp(request):
    usuario = request.user if request.user.is_authenticated else None
    perfil = Profile.objects.get(user=usuario)

    empleado = Rol.objects.get(cod_rol = 2)
    administrador = Rol.objects.get(cod_rol = 1)

    remove_products_sales(request)
    if perfil.cod_rol == empleado:
        return redirect('EResgistroVen')
    elif perfil.cod_rol == administrador:
        return redirect('AdminRegistroVen')

@login_required
def save_sale_emp(request):

    usuario = request.user if request.user.is_authenticated else None
    perfil = Profile.objects.get(user=usuario)

    empleado = Rol.objects.get(cod_rol = 2)
    administrador = Rol.objects.get(cod_rol = 1)

    save_sale(request)
    if perfil.cod_rol == empleado:
        return redirect('EConsultaVen')
    elif perfil.cod_rol == administrador:
        return redirect('AdminConsultaVen')

@login_required
def save_sale(request):
    if request.method == 'POST':
        user = request.user if request.user.is_authenticated else None
        profile = Profile.objects.get(user=user)
        id = request.session.get('id')
        venta = Sales.objects.filter(pk=id).first()

        if venta is None:
            venta = Sales.objects.create(id_user=profile)

        if profile and venta.id_user is None:
            venta.id_user = profile
            venta.save()

        request.session['id'] = venta.cod_sale

        client = Client.objects.get(pk=request.POST.get('client'))
        venta.cod_client = client

        for v in venta.products_related():
            v.subtotal = v.product.price_product * v.quantity
            v.save()

        venta.save()

        request.session['id'] = None

        messages.success(request, 'Venta registrada exitosamente')


@login_required
@permission_required('core.add_salesdetail', login_url='sinacceso')
def add_products_sales(request):

    user = request.user if request.user.is_authenticated else None
    profile = Profile.objects.get(user=user)
    id = request.session.get('id')
    venta = Sales.objects.filter(pk=id).first()

    if venta is None:
        venta = Sales.objects.create(id_user=profile)

    if profile and venta.id_user is None:
        venta.id_user = profile
        venta.save()

    request.session['id'] = venta.cod_sale

    if request.method == 'POST':

        product = Product.objects.get(pk=request.POST.get('product_id'))
        #product = get_object_or_404(Product, pk=request.POST.get('product_id'))
        messages.success(request, "Producto Agregado")
        quantity = int(request.POST.get('quantity', 1))
        # carrito.cod_product.add(product, through_defaults={
        # 'quantity' : quantity
        # )

        sale_product = SalesDetail.objects.create_or_update_quantity(sale=venta,
                                                                     product=product,
                                                                     quantity=quantity)

        product.stock = product.stock - quantity
        product.save()
    else:

        product = venta.cod_product.all()
    
    return render(request, 'empleado/ListadoVenta.html', {
        'product': product,
        'compra': venta,
    })

@login_required
@permission_required('core.delete_salesdetail', login_url='sinacceso')
def remove_products_sales(request):

    user = request.user if request.user.is_authenticated else None
    profile = Profile.objects.get(user=user)
    id = request.session.get('id')
    venta = Sales.objects.filter(pk=id).first()

    if venta is None:
        venta = Sales.objects.create(id_user=profile)

    if profile and venta.id_user is None:
        venta.id_user = profile
        venta.save()

    request.session['id'] = venta.cod_sale

    if request.method == 'POST':
        messages.error(request, "Producto Eliminado")
        product = Product.objects.get(pk=request.POST.get('product_remove'))

        for cp in venta.products_related():
            if cp.product == product:
                quantity_eliminated = cp.quantity

        product.stock = product.stock + quantity_eliminated
        product.save()

        venta.cod_product.remove(product)

    return render(request, 'empleado/ListadoVenta.html', {
        'product': product,
        'compra': venta,
    })

@login_required
@permission_required('core.add_inventorymovement', login_url='sinacceso')
def ERegistroInvE(request):
    return render(request, 'empleado/inventarioE.html', {
        # context
    })
# Fin: Registros Empleado
# Consultas Empleado


@login_required
@permission_required('core.view_product', login_url='sinacceso')
def EConsultaProd(request):

    product_list = Product.objects.all().order_by('cod_product')

    page = request.GET.get('page', 1)
    
    try:
        paginator = Paginator(product_list, 5)
        product_list = paginator.page(page)
    except:
        raise Http404

    return render(request, 'empleado/consultaproductoE.html', {
        'product_list' : product_list,
        'paginator': paginator
    })


@login_required
@permission_required('core.view_sales', login_url='sinacceso')
def EConsultaVen(request):
    user = request.user if request.user.is_authenticated else None
    profile = Profile.objects.get(user=user)

    sales = Sales.objects.filter(id_user=profile)

    return render(request, 'empleado/consultaventaE.html', {
        'sales': sales,
    })


@login_required
@permission_required('core.view_order', login_url='sinacceso')
def EConsultaPed(request):
    return render(request, 'empleado/pedidoE.html', {
        # context
    })


@login_required
@permission_required('core.view_delivery', login_url='sinacceso')
def EConsultaDom(request):

    user = request.user if request.user.is_authenticated else None
    profile = Profile.objects.get(user=user)
    state = StateDomicile.objects.get(cod_state_domicile = 2)
    state_domicile_completed = StateDomicile.objects.get(cod_state_domicile = 1)

    delivery = Delivery.objects.filter(id_user = profile, state_domicile = state)
    delivery_completed = Delivery.objects.filter(id_user = profile, state_domicile = state_domicile_completed)

    return render(request, 'empleado/consultadomicilios.html', {
        'delivery' : delivery,
        'deliver_completed' : delivery_completed
    })

@login_required
@permission_required('core.view_delivery', login_url='sinacceso')
def complete_deliver(request, id_deliver):
    completed = Delivery.objects.get(cod_delivery = id_deliver)
    state = StateDomicile.objects.get(cod_state_domicile = 1)

    order_domicile = str(completed.code_order)

    order = Order.objects.get(cod_order = order_domicile)
    
    order.status = OrderStatus.PAYED
    order.save()

    completed.state_domicile = state
    completed.save()

    return redirect('EConsultaDom')
    

@login_required
@permission_required('core.view_inventorymovement', login_url='sinacceso')
def EConsultaInv(request):
    return render(request, 'empleado/consultainventarioE.html', {
        # context
    })
# Fin: Consultas Empleado
# Fin: Empleado vistas

# Recuperar Contraseña Vistas"

# Clientes vista

@login_required
@permission_required('core.add_order', login_url='sinacceso')
def Orden(request):
    user = request.user if request.user.is_authenticated else None
    profile = Profile.objects.get(user=user)
    id = request.session.get('id')
    carrito = Sales.objects.filter(pk=id).first()

    rol_employee = Rol.objects.get(cod_rol = 2)

    if profile.cod_rol == rol_employee:
        return redirect('sinacceso')

    if carrito is None:
        carrito = Sales.objects.create(id_user=profile)

    if profile and carrito.id_user is None:
        carrito.id_user = profile
        carrito.save()

    request.session['id'] = carrito.cod_sale

    order = carrito.order

    if order is None and profile:
        order = Order.objects.create(cod_sale=carrito, id_user=profile)

    if order:
        request.session['order_id'] = order.cod_order

    return render(request, 'cliente/OrdenesVenta.html', {
        'carrito': carrito,
        'order': order
    })

@login_required
@permission_required('core.delete_order', login_url='sinacceso')
def CancelarOrden(request):
    user = request.user if request.user.is_authenticated else None
    profile = Profile.objects.get(user=user)
    id = request.session.get('id')
    carrito = Sales.objects.filter(pk=id).first()

    if carrito is None:
        carrito = Sales.objects.create(id_user=profile)

    if profile and carrito.id_user is None:
        carrito.id_user = profile
        carrito.save()

    request.session['id'] = carrito.cod_sale

    order = carrito.order

    if order is None and profile:
        order = Order.objects.create(cod_sale=carrito, id_user=profile)

    if order:
        request.session['order_id'] = order.cod_order
    
    order.cancel()

    order_deleted = Order.objects.get(pk= request.session['order_id'])
    cart_deleted = Sales.objects.get(pk= request.session['id'])

    order_deleted.delete()
    cart_deleted.delete()

    request.session['id'] = None
    request.session['order_id'] = None

    messages.error(request, 'Orden cancelada')
    return redirect('Catalogo')

@login_required
@permission_required('core.add_order', login_url='sinacceso')
def CompletarOrden(request):
    user = request.user if request.user.is_authenticated else None
    profile = Profile.objects.get(user=user)
    id = request.session.get('id')
    carrito = Sales.objects.filter(pk=id).first()

    if carrito is None:
        carrito = Sales.objects.create(id_user=profile)

    if profile and carrito.id_user is None:
        carrito.id_user = profile
        carrito.save()

    request.session['id'] = carrito.cod_sale

    order = carrito.order

    if order is None and profile:
        order = Order.objects.create(cod_sale=carrito, id_user=profile)

    if order:
        request.session['order_id'] = order.cod_order

    for v in carrito.products_related():
        v.subtotal = v.product.price_product * v.quantity
        v.save()

    order.register()

    request.session['id'] = None
    request.session['order_id'] = None

    messages.success(request, 'Venta completada exitosamente')
    return redirect('Catalogo')

@login_required
@permission_required('core.add_sales', login_url='sinacceso')
def info_cliente(request):
    user = request.user if request.user.is_authenticated else None
    client = Profile.objects.get(user=user)

    return render(request, 'cliente/ActualizarInformacion.html', {
        'cliente': client
    })

@login_required
@permission_required('core.add_sales', login_url='sinacceso')
def pedidos_cliente(request):
    user = request.user if request.user.is_authenticated else None
    client = Profile.objects.get(user=user)

    orders = Order.objects.filter(id_user = client)

    delivery = Delivery.objects.all()

    return render(request, 'cliente/PedidosCliente.html', {
        'ordenes' : orders,
        'domicilio': delivery
    })

@login_required
@permission_required('core.add_sales', login_url='sinacceso')
def Catalogo(request):
    
    user = request.user if request.user.is_authenticated else None
    profile = Profile.objects.get(user=user)
    id = request.session.get('id')
    carrito = Sales.objects.filter(pk=id).first()
    
    rol_employee = Rol.objects.get(cod_rol = 2)

    if profile.cod_rol == rol_employee:
        return redirect('sinacceso')

    if carrito is None:
        carrito = Sales.objects.create(id_user=profile)

    if profile and carrito.id_user is None:
        carrito.id_user = profile
        carrito.save()

    request.session['id'] = carrito.cod_sale

    products = Product.objects.all().order_by('cod_product')

    page = request.GET.get('page', 1)
    
    try:
        paginator = Paginator(products, 6)
        products = paginator.page(page)
    except:
        raise Http404

    return render(request, 'cliente/Catalogo.html', {
        'products': products,
        'carrito': carrito,
        'paginator': paginator
    })



class ProductSearchList(ListView):
    template_name = 'cliente/BuscarProductosCarro.html'

    def query(self):
        return self.request.GET.get('producto')

    def get_queryset(self):
        return Product.objects.filter(name__icontains= self.query())

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['query'] = self.query()
        return context


@login_required
@permission_required('core.add_salesdetail', login_url='sinacceso')
def CarritoCompras(request):

    user = request.user if request.user.is_authenticated else None
    profile = Profile.objects.get(user=user)
    id = request.session.get('id')
    carrito = Sales.objects.filter(pk=id).first()

    if carrito is None:
        carrito = Sales.objects.create(id_user=profile)

    if profile and carrito.id_user is None:
        carrito.id_user = profile
        carrito.save()

    # if request.session.get('id'):
        #carrito = Sales.objects.get(pk= request.session.get('id'))
    # else:
        #carrito = Sales.objects.create(id_user=profile)

    request.session['id'] = carrito.cod_sale

    return render(request, 'cliente/CarritoCompras.html', {
        
    })

@login_required
@permission_required('core.add_sales', login_url='sinacceso')
def DetallesCatalogo(request):
    
    return render(request, 'cliente/DetallesCatalogo.html')
    
@login_required
@permission_required('core.add_salesdetail', login_url='sinacceso')
def add_products(request):

    user = request.user if request.user.is_authenticated else None
    profile = Profile.objects.get(user=user)
    id = request.session.get('id')
    carrito = Sales.objects.filter(pk=id).first()

    rol_employee = Rol.objects.get(cod_rol = 2)

    if profile.cod_rol == rol_employee:
        return redirect('sinacceso')

    if carrito is None:
        carrito = Sales.objects.create(id_user=profile)

    if profile and carrito.id_user is None:
        carrito.id_user = profile
        carrito.save()

    request.session['id'] = carrito.cod_sale

    if request.method == 'POST':

        product = Product.objects.get(pk=request.POST.get('product_id'))
        #product = get_object_or_404(Product, pk=request.POST.get('product_id'))
        messages.success(request, "Producto Agregado")
        quantity = int(request.POST.get('quantity', 1))
        # carrito.cod_product.add(product, through_defaults={
        # 'quantity' : quantity
        # )

        sale_product = SalesDetail.objects.create_or_update_quantity(sale=carrito,
                                                                     product=product,
                                                                     quantity=quantity)

        product.stock = product.stock - quantity
        product.save()
    else:

        product = carrito.cod_product.all()

    return render(request, 'cliente/CarritoCompras.html', {
        'product': product,
        'carrito': carrito,
    })

@login_required
@permission_required('core.delete_salesdetail', login_url='sinacceso')
def remove_products(request):
    user = request.user if request.user.is_authenticated else None
    profile = Profile.objects.get(user=user)
    id = request.session.get('id')
    carrito = Sales.objects.filter(pk=id).first()

    if carrito is None:
        carrito = Sales.objects.create(id_user=profile)

    if profile and carrito.id_user is None:
        carrito.id_user = profile
        carrito.save()

    request.session['id'] = carrito.cod_sale
    messages.error(request, "Producto Eliminado")
    #product = get_object_or_404(Product, pk=request.POST.get('product_id'))
    product = Product.objects.get(pk=request.POST.get('product_remove'))

    for cp in carrito.products_related():
        if cp.product == product:
            quantity_eliminated = cp.quantity

    product.stock = product.stock + quantity_eliminated
    product.save()

    carrito.cod_product.remove(product)

    return render(request, 'cliente/CarritoCompras.html', {
        'product': product,
        'carrito': carrito,
    })
    # return redirect('Agregar')


# Registros Clientes
@login_required
@permission_required('core.add_client', login_url='sinacceso')
def ClienteRegistro(request):
    return render(request, 'registroCliente.html', {
        # context
    })


# Fin: Registros Clientes
# Fin: Clientes vista

# Graficas de ventas
@login_required
def GraficVentas(request):
    return render(request, 'reports/graficaventa.html', {

    })


@login_required
def GraficCompras(request):
    return render(request, 'reports/graficacompra.html', {

    })


# Login Usuarios



def login_view(request):
    if request.method == 'POST':
        username = request.POST.get('nombre')
        password = request.POST.get('contraseña')

        user = authenticate(username=username, password=password)
        
        try:
            profile = Profile.objects.get(user=user)
        except:
            messages.error(request, 'Usuario o contraseña incorrectos')

        rol_admin = Rol.objects.get(cod_rol=1)
        rol_employee = Rol.objects.get(cod_rol = 2)
        rol_client = Rol.objects.get(cod_rol=3)
        
        if user and profile.cod_rol == rol_admin:
            login(request, user)
            messages.success(request, 'Bienvenido {}'.format(user.username))
            return redirect('Administrador')
        elif user and profile.cod_rol == rol_employee:
            login(request, user)
            messages.success(request, 'Bienvenido {}'.format(user.username))
            return redirect('Empleado')
        elif user and profile.cod_rol == rol_client:
            login(request, user)
            messages.success(request, 'Bienvenido {}'.format(user.username))
            return redirect('Catalogo')
        else:
            messages.error(request, 'Usuario o contraseña incorrectos')
            return redirect('login')

    return render(request, 'registration/login.html', {

    })


def logout_view(request):
    logout(request)
    messages.success(request, 'Sesion finalizada correctamente')
    return redirect('login')

# Registro de Usuarios

def send_email(nombre_usuario, nombre, apellido, mail,telefono):

                context = {'nombre_usuario': nombre_usuario, 
                           'nombre' : nombre,
                           'apellido' : apellido,
                           'mail': mail,
                           'telefono' : telefono}

                template = get_template('registration/RCorreo.html')
                content = template.render(context)

                email = EmailMultiAlternatives(
                    'Bienvenido',
                    'Registro de usuario Exitoso',
                    settings.EMAIL_HOST_USER,
                    [nombre_usuario, nombre, apellido, mail, telefono]
                )

                email.attach_alternative(content, 'text/html')
                email.send()

@login_required
@permission_required('core.add_profile', login_url='sinacceso')
def email_for_all_employees(request):
    if request.method == "POST":
        asunto = request.POST.get('asunto')
        message = request.POST.get('mensaje')
        

        correos = []
        rol_empleado = Rol.objects.get(cod_rol = 2)
        empleados = Profile.objects.filter(cod_rol = rol_empleado)

        for emp in empleados:
            correos.append(emp.user.email)
        
        context = {
           'asunto' : asunto,
           'empleado' : empleados,
           'message' : message
       }
        template = get_template('massive_email_template.html')
        content = template.render(context)

        email = EmailMultiAlternatives(
            asunto,
            'Informacion',
            settings.EMAIL_HOST_USER,
            correos
        )

        email.attach_alternative(content, 'text/html')
        email.send()
    return redirect('AdminRegistroE')

def register_user(request):
    if request.method == 'POST':
        #mail = request.POST.get('mail')
        identification_number = request.POST.get('documento')
        username = request.POST.get('nombre_usuario')
        first_name = request.POST.get('nombre')
        last_name = request.POST.get('apellido')
        birthdate = request.POST.get('fecha_nacimiento')
        gender = request.POST.get('genero')
        telephone_number = request.POST.get('telefono')
        address = request.POST.get('direccion')
        email = request.POST.get('correo')
        password = request.POST.get('contraseña')

        group = Group.objects.get(name= 'Clientes')

        user = User.objects.create_user(username=username, email=email, password=password)
        user.is_staff = False
        user.is_superuser = False
        user.groups.add(group)
        user.first_name = first_name
        user.last_name = last_name
        user.save()

        rol = Rol.objects.get(cod_rol=3)
        
        profile = Profile.objects.create(user=user, id_profile=identification_number, birthdate=birthdate, gender=gender,
                                         telephone_number=telephone_number, address=address, cod_rol=rol, state=True)
        profile.save()
        

        if user:
            """ remitente = "juanbohorquez0702@outlook.com"
            destinatario = email
            email_password = "JPBlook2004" """

            send_email(username, first_name,
                       last_name, email, telephone_number)
            messages.success(request, 'Registro exitoso (Sele a enviado un mensaje a su correo)')
            return redirect('login')
            

    return render(request, 'registroCliente.html', {
    })



# Clases para actualizar y eliminar los proveedores
class SupplierUpdate(LoginRequiredMixin, SuccessMessageMixin, UpdateView):
    login_url = '/accounts/login'
    model = Supplier
    form_class = SupplierForm
    template_name = 'administrador/actualizarproveedor.html'
    success_message = 'Proveedor actualizado actualmente'

    def get_success_url(self):
        return reverse('AdminRegistroProv')

class SupplierDelete(LoginRequiredMixin, DeleteView):
    login_url = '/accounts/login'
    model = Supplier
    template_name = 'administrador/eliminarproveedor.html'
    success_url = reverse_lazy('AdminRegistroProv')

# Clases para actualizar, inhabilitar y habilitar los productos

class ProductUpdate(LoginRequiredMixin, SuccessMessageMixin, UpdateView):
    login_url = '/accounts/login'
    model = Product
    form_class = ProductForm
    template_name = 'administrador/actualizarproducto.html'
    success_message = 'Producto actualizado actualmente'

    def get_success_url(self):
        return reverse('AdminConsultaProd')

@login_required
@permission_required('core.delete_product', login_url='sinacceso')
def InhabilitarProducto(request):
    product = request.GET.get('pk')
    disabled_product = Product.objects.get(cod_product = product)

    disabled_product.disable_product()
    return redirect('AdminConsultaProd')

@login_required
@permission_required('core.delete_product', login_url='sinacceso')
def HabilitarProducto(request):
    product = request.GET.get('pk')
    enabled_product = Product.objects.get(cod_product = product)

    enabled_product.enable_product()
    return redirect('AdminConsultaProd')


@login_required
@permission_required('auth.delete_user', login_url='sinacceso')
def AdminEliminarE(request):
    if request.method == 'GET':
        id_profile = int(request.GET.get('id_profile'))
        id_user = int(request.GET.get('id_user'))

        disabled_profile = Profile.objects.get(id_profile= id_profile)
        disabled_user = User.objects.get(id=id_user)

        disabled_profile.state = False
        disabled_profile.save()
        disabled_user.is_active = False
        disabled_user.save()

    return redirect('AdminConsultaE')

@login_required
@permission_required('auth.delete_user', login_url='sinacceso')
def AdminHabilitarE(request):
    if request.method == 'GET':
        id_profile = int(request.GET.get('id_profile'))
        id_user = int(request.GET.get('id_user'))

        enabled_profile = Profile.objects.get(id_profile= id_profile)
        enabled_user = User.objects.get(id=id_user)

        enabled_profile.state = True
        enabled_profile.save()
        enabled_user.is_active = True
        enabled_user.save()

    return redirect('AdminConsultaE')


    ## Graficas
@login_required
@permission_required('auth.delete_user', login_url='sinacceso')
def grafico_ventas(request):

    year = datetime.now().year
    data_venta = []

    for m in range(1, 13):
        total = Sales.objects.filter(date_sale__year = year, date_sale__month = m).aggregate(r=Coalesce(Sum('full_value'), Decimal(0.00))).get('r')
        data_venta.append(float(total))

    return render(request, 'reports/grafico_ventas.html', {
        'data_venta' : data_venta
    })

@login_required
@permission_required('auth.delete_user', login_url='sinacceso')
def productos_vendidos(request):
    try:
        db = MySQLdb.connect(user='root', db='comgstore_django', passwd='', host='localhost')
        cantidad = db.cursor()
        nombres = db.cursor()
        cantidad.execute("select sum(dv.quantity) as cantidades_vendidas from venta v INNER join detalle_venta dv on v.cod_sale = dv.sale_id INNER JOIN producto p on dv.product_id = p.cod_product where v.date_sale BETWEEN '2022-01-01' and '2022-12-31' GROUP BY dv.product_id ORDER BY cantidades_vendidas DESC")
        nombres.execute("select p.name from venta v INNER join detalle_venta dv on v.cod_sale = dv.sale_id INNER JOIN producto p on dv.product_id = p.cod_product where v.date_sale BETWEEN '2022-01-01' and '2022-12-31' GROUP BY dv.product_id ORDER BY sum(dv.quantity) DESC")

        cantidad = [row[0] for row in cantidad.fetchall()]
        nombres = [row[0] for row in nombres.fetchall()]        
        listado_cantidades = []
        for can in cantidad:
            listado_cantidades.append(int(can))

        fig, ax = plt.subplots()
        ax.barh(nombres, listado_cantidades, color=['blue', 'red', 'green', 'orange', 'purple', 'gray'], label=f'{nombres} {listado_cantidades} unidades')
        plt.title('Productos mas vendidos')
        plt.xlabel('Unidades Vendidas')
        plt.ylabel('Productos')
        plt.show()
        plt.legend()

    except:
        pass

    db.close()

    return redirect('AdminConsultaProd')

@login_required
@permission_required('auth.delete_user', login_url='sinacceso')
def grafico_compras(request):

    year = datetime.now().year
    data_compra = []

    for m in range(1, 13):
        total = Purchase.objects.filter(date_purchase__year = year, date_purchase__month = m).aggregate(r=Coalesce(Sum('total_value'), Decimal(0.00))).get('r')
        data_compra.append(float(total))

    return render(request, 'reports/grafico_compras.html', {
        'data_compra' : data_compra
    })
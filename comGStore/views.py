from django.conf import settings
from re import template
from django.shortcuts import render
from django.contrib.auth import authenticate
from django.shortcuts import redirect

from django.contrib.auth import login
from django.contrib.auth import logout

# importacion de modelos
from django.contrib.auth.models import User
from core.models import Order, Profile
from core.models import Rol
from core.models import Sales
from core.models import Supplier
from core.models import Order
from core.models import Product
from core.models import SalesDetail
from django.contrib.auth.decorators import login_required

# importaciones del email
from django.contrib import messages
import smtplib
from email.message import EmailMessage
from django.template.loader import get_template
from django.core.mail import EmailMultiAlternatives
from django.core.mail import send_mail

# Importacion paginator
from django.core.paginator import Paginator
from django.http import Http404

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
from django.views.generic.edit import UpdateView
from django.views.generic.edit import DeleteView
from django.contrib.auth.mixins import LoginRequiredMixin
from django.contrib.messages.views import SuccessMessageMixin


# Inicio Vistas
def index(request):
    return render(request, 'index.html', {
        # context
    })


def informacion(request):
    return render(request, 'informacion.html', {
        # context
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
def Administrador(request):
    return render(request, 'Administrador.html', {
        # context
    })


@login_required
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

        user = User.objects.create_user(
            username=username, email=email, password=password)
        user.is_staff = False
        user.is_superuser = False
        user.first_name = first_name
        user.last_name = last_name
        user.save()

        rol = Rol.objects.get(cod_rol=2)


        
        profile = Profile.objects.create(user=user, id_profile=id_number, birthdate=birthdate, gender=gender,
                                         telephone_number=telephone_number, address=address, cod_rol=rol, state=True)
        profile.save()

    return render(request, 'registroempleado.html', {
        # context
    })


@login_required
def AdminRegistroProv(request):

    form = SupplierForm(request.POST or None)
    supplier_list = Supplier.objects.all().order_by('cod_supplier')

    if request.method == 'POST' and form.is_valid():
        supplier = form.save()
        messages.success(request, "Proveedor creado exitosamente")

    return render(request, 'registroproveedor.html', {
        'form': form,
        'supplier_list': supplier_list
    })


@login_required
def AdminRegistroProd(request):

    form = ProductForm(request.POST or None)

    if request.method == 'POST' and form.is_valid():
        form.save()
        messages.success(request, "Producto creado exitosamente")

    return render(request, 'registroproducto.html', {
        'form' : form
    })


@login_required
def AdminRegistroCom(request):
    return render(request, 'compra.html', {
        # context
    })


@login_required
def AdminRegistroVen(request):
    return render(request, 'venta.html', {
        # context
    })


@login_required
def AdminRegistroInv(request):
    return render(request, 'inventario.html', {
        # context
    })

# Consultas Admin


@login_required
def AdminConsultaE(request):

    rol = Rol.objects.get(cod_rol=2)
    employees_list = Profile.objects.filter(cod_rol = rol).order_by('id_profile')

    return render(request, 'consultaempleado.html', {
        'employees' : employees_list
    })

# Proveedor comparte el apartado en el registro


@login_required
def AdminConsultaProd(request):

    product_list = Product.objects.all().order_by('cod_product')

    page = request.GET.get('page', 1)
    
    try:
        paginator = Paginator(product_list, 5)
        product_list = paginator.page(page)
    except:
        raise Http404

    return render(request, 'consultaproducto.html', {
        'product_list' : product_list,
        'paginator': paginator
    })
    return render(request, 'consultaproducto.html', {
        'product_list' : product_list
    })


@login_required
def AdminConsultaCom(request):
    return render(request, 'consultacompra.html', {
        # context
    })


@login_required
def AdminConsultaVen(request):
    return render(request, 'consultaventa.html', {
        # context
    })


@login_required
def AdminConsultaInv(request):
    return render(request, 'consultainventario.html', {
        # context
    })

# Pedido solo tiene apartado de consulta


def AdminConsultaPed(request):
    return render(request, 'pedidos.html', {
        # context
    })
# Fin: Consultas Admin

# Eliminacion Admin

@login_required
def AdminEliminarProd(request):
    return render(request, 'eliminarproducto.html', {
        # context
    })
# Fin: Eliminacion Admin

# Actualizacion Admin

@login_required
def AdminUpdateE(request, id_profile):

    profile = Profile.objects.filter(id_profile = id_profile).first()

    return render(request, 'actualizarempleado.html', {
        'profile': profile
    })

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

    return redirect('AdminConsultaE')
        #user = User.objects.update_or_create( username= username, first_name= first_name, last_name = last_name, email= email)
        #profile = Profile.objects.update_or_create(pk= id_profile, user=user, telephone_number= telephone_number, address= address)

@login_required
def AdminUpdateProd(request):
    return render(request, 'actualizarproducto.html', {
        # context
    })
# Fin: Actualizacion Admin

# Fin: Admnistrador vistas

# Empleado vistas
# sys.setrecursionlimit(2500)


@login_required
def Empleado(request):
    return render(request, 'Empleado.html', {
        # context
    })
# Registros Empleado


@login_required
def EResgistroVen(request):
    return render(request, 'ventaempleado.html', {
        # context
    })


@login_required
def ERegistroInvE(request):
    return render(request, 'inventarioE.html', {
        # context
    })
# Fin: Registros Empleado
# Consultas Empleado


@login_required
def EConsultaProd(request):
    return render(request, 'consultaproductoE.html', {
        # context
    })


@login_required
def EConsultaVen(request):
    return render(request, 'consultaventaE.html', {
        # context
    })


@login_required
def EConsultaPed(request):
    return render(request, 'pedidoE.html', {
        # context
    })


@login_required
def EConsultaDom(request):
    return render(request, 'consultadomicilios.html', {
        # context
    })


@login_required
def EConsultaInv(request):
    return render(request, 'consultainventarioE.html', {
        # context
    })
# Fin: Consultas Empleado
# Fin: Empleado vistas

# Recuperar Contraseña Vistas"

# Clientes vista


@login_required
def Orden(request):
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

    return render(request, 'OrdenesVenta.html', {
        'carrito': carrito,
        'order': order
    })

@login_required
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

    order.complete()

    request.session['id'] = None
    request.session['order_id'] = None

    messages.success(request, 'Venta completada exitosamente')
    return redirect('Catalogo')

def Catalogo(request):
    
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

    products = Product.objects.all().order_by('cod_product')
    page = request.GET.get('page', 1)

    try:
        paginator = Paginator(products, 6)
        products = paginator.page(page)
    except:
        raise Http404

    return render(request, 'Catalogo.html', {
        'products': products,
        'carrito': carrito,
        'paginator': paginator
    })


class ProductSearchList(ListView):
    template_name = 'BuscarProductosCarro.html'

    def query(self):
        return self.request.GET.get('producto')

    def get_queryset(self):
        return Product.objects.filter(name__icontains= self.query())

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['query'] = self.query()
        return context

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

    return render(request, 'CarritoCompras.html', {
        
    })

def DetallesCatalogo(request):
    
    return render(request, 'DetallesCatalogo.html')
    

def add_products(request):

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
    else:

        product = carrito.cod_product.all()

    return render(request, 'CarritoCompras.html', {
        'product': product,
        'carrito': carrito,
    })


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
    carrito.cod_product.remove(product)

    return render(request, 'CarritoCompras.html', {
        'product': product,
        'carrito': carrito,
    })
    # return redirect('Agregar')


# Registros Clientes
def ClienteRegistro(request):
    return render(request, 'registroCliente.html', {
        # context
    })


# Fin: Registros Clientes
# Fin: Clientes vista

# Graficas de ventas
@login_required
def GraficVentas(request):
    return render(request, 'graficaventa.html', {

    })


@login_required
def GraficCompras(request):
    return render(request, 'graficacompra.html', {

    })

# Login Usuarios


@login_required
def login_view(request):
    if request.method == 'POST':
        username = request.POST.get('nombre')
        password = request.POST.get('contraseña')
        user = authenticate(username=username, password=password)
        if user:
            login(request, user)
            messages.success(request, 'Bienvenido {}'.format(user.username))
            return redirect('admin:index')
        else:
            messages.error(request, 'Usuario o contraseña incorrectos')

    return render(request, 'registration/login.html', {

    })


def logout_view(request):
    logout(request)
    messages.success(request, 'Sesion finalizada correctamente')
    return redirect('/accounts/login')

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
                    'CodigoFacilito',
                    settings.EMAIL_HOST_USER,
                    [nombre_usuario, nombre, apellido, mail, telefono]
                )

                email.attach_alternative(content, 'text/html')
                email.send()

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

        user = User.objects.create_user(
            username=username, email=email, password=password)
        user.is_staff = False
        user.is_superuser = False
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

    return render(request, 'registroCliente.html', {
    })



# Clases para actualizar y eliminar los proveedores
class SupplierUpdate(LoginRequiredMixin, SuccessMessageMixin, UpdateView):
    login_url = '/accounts/login'
    model = Supplier
    form_class = SupplierForm
    template_name = 'actualizarproveedor.html'
    success_message = 'Proveedor actualizado actualmente'

    def get_success_url(self):
        return reverse('AdminRegistroProv')

class SupplierDelete(LoginRequiredMixin, DeleteView):
    login_url = '/accounts/login'
    model = Supplier
    template_name = 'eliminarproveedor.html'
    success_url = reverse_lazy('AdminRegistroProv')

# Clases para actualizar, inhabilitar y habilitar los productos

class ProductUpdate(LoginRequiredMixin, SuccessMessageMixin, UpdateView):
    login_url = '/accounts/login'
    model = Product
    form_class = ProductForm
    template_name = 'actualizarproducto.html'
    success_message = 'Producto actualizado actualmente'

    def get_success_url(self):
        return reverse('AdminConsultaProd')

@login_required
def InhabilitarProducto(request):
    product = request.GET.get('pk')
    disabled_product = Product.objects.get(cod_product = product)

    disabled_product.disable_product()
    return redirect('AdminConsultaProd')

@login_required
def HabilitarProducto(request):
    product = request.GET.get('pk')
    enabled_product = Product.objects.get(cod_product = product)

    enabled_product.enable_product()
    return redirect('AdminConsultaProd')


@login_required
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
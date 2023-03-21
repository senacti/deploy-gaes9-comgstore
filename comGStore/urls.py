"""comGStore URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""

from audioop import add
from django.contrib import admin
from django.urls import path
from django.conf import settings
from django.conf.urls.static import static
from . import views
from django.urls.conf import include
from django.contrib.auth import views as auth_views
from django.urls import path
#from django.contrib.auth.views import 



urlpatterns = [
    path('admin/', admin.site.urls, name='admin'),
    path('', views.index, name='index'),
    path('informacion/', views.informacion, name='informacion'),
    path('contactenos/', views.contactenos, name='FormularioContacto'),
    path('Formularioinicio/', views.login_view, name='Formularioinicio'),
    path('accounts/', include('django.contrib.auth.urls')),
    path('login/', views.login_view, name='login'),
    path('logout/', views.logout_view, name='logout'),
    path('sinacceso/', views.sinacceso, name='sinacceso'),    

    #Enlaces rol Administrador
    # Enlaces registro datos rol Administrador

    path('Administrador/', views.Administrador, name='Administrador'),
    path('RegistroEmpleado/', views.AdminRegistroE, name='AdminRegistroE'),
    path('RegistroProveedor/', views.AdminRegistroProv, name='AdminRegistroProv'),
    path('RegistroProducto/', views.AdminRegistroProd, name='AdminRegistroProd'),
    path('RegistroCompra/', views.AdminRegistroCom, name='AdminRegistroCom'),
    path('CompletarCompra/', views.guardarCompra, name='CompletarCompra'),  
    path('RegistroVenta/', views.AdminRegistroVen, name='AdminRegistroVen'),
    path('RegistroInventario/', views.AdminRegistroInv, name='AdminRegistroInv'),


    path('AsignarDomiciliario/', views.assign_deliver, name='AsignarDomiciliario'), 
    path('ReasignarDomiciliario/', views.reassigned_deliver, name='ReasignarDomiciliario'),
    
    
    # Enlaces consulta datos rol Administrador

    path('ConsultarEmpleados/', views.AdminConsultaE, name='AdminConsultaE'),
    path('ConsultarProductos/', views.AdminConsultaProd, name='AdminConsultaProd'),
    path('ConsultarCompras/', views.AdminConsultaCom, name='AdminConsultaCom'),
    path('ConsultarVentas/', views.AdminConsultaVen, name='AdminConsultaVen'),
    path('Orden/', views.Orden, name='Orden'),
    path('ConsultarPedidos/', views.AdminConsultaPed, name='AdminConsultaPed'),
    path('ConsultarInventario/', views.AdminConsultaInv, name='AdminConsultaInv'),

    # Enlace eliminar datos rol Administrador

    path('InhabilitarEmpleado/', views.AdminEliminarE, name='AdminEliminarE'),
    path('InhabilitarProducto/', views.InhabilitarProducto, name='AdminEliminarProd'),
    path('EliminarProveedor/ <int:pk>', views.SupplierDelete.as_view(), name='AdminEliminarProv'),
    path('EliminarOrden/', views.CancelarOrden, name='EliminarOrden'),
 
    # Enlaces para habilitar datos en Administrador

    path('HabilitarProducto/', views.HabilitarProducto, name='AdminHabilitarProd'),
    path('HabilitarEmpleado/', views.AdminHabilitarE, name='AdminHabilitarE'),

    #Enlaces actualizar datos rol Administrador

    path('ActualizarEmpleado/<int:id_profile>', views.AdminUpdateE, name='AdminUpdateE'),
    path('Actualizar/', views.ActualizarEmpleado, name='ActualizarEmpleado'),
    path('ActualizarProducto/ <int:pk>', views.ProductUpdate.as_view(), name='AdminUpdateProd'),
    path('ActualizarProveedor/<int:pk>', views.SupplierUpdate.as_view() , name='AdminUpdateProv'),    
    #Fin Enlaces datos rol Administrador


    #Enlaces rol Empleado
    # Enlaces registro datos rol Empleado
    
    path('Empleado/', views.Empleado, name='Empleado'),
    path('RegistroVentaEm/', views.EResgistroVen, name='EResgistroVen'),
    path('CompletarVentaEm/', views.save_sale_emp, name='CompletarVentaEm'),    
    path('RegistroInventarioEm/', views.ERegistroInvE, name='ERegistroInvE'),

    # Enlaces consulta datos rol Empleado
    path('ConsultarProductosE/', views.EConsultaProd, name='EConsultaProd'),
    path('ConsultarVentasE/', views.EConsultaVen, name='EConsultaVen'),
    path('ConsultarPedidosE/', views.EConsultaPed, name='EConsultaPed'),
    path('ConsultarDomiciliosE/', views.EConsultaDom, name='EConsultaDom'),
    path('CompletarDomicilio/<int:id_deliver>', views.complete_deliver, name='CompletarDomicilio'),
    path('ConsultarInventarioE/', views.EConsultaInv, name='EConsultaInv'),
    #Fin Enlaces datos rol Empleado

    #Enlaces rol Clientes

    # Graficas
    path('GraficaVenta/', views.GraficVentas, name="GraficVentas"),
    path('GraficaCompra/', views.GraficCompras, name="GraficCompras"),

    #Enlaces rol Cliente
    path('Catalogo/', views.Catalogo, name="Catalogo"),
    path('BuscarProductos/', views.ProductSearchList.as_view(), name="BuscarProductos"),
    path('DetallesCatalogo/',views.DetallesCatalogo, name="DetallesCatalogo"),
    path('CarritoCompra/', views.CarritoCompras, name="CarritoCompras"),
    path('CompletarOrden/', views.CompletarOrden, name="CompletarOrden"),
    path('Registrarse/', views.register_user, name="Registrarse"),
    path('Agregar/', views.add_products , name="Agregar"),
    path('ActualizarInformacion/', views.info_cliente , name="ActualizarInfo"), 
    path('ListadoPedidos/', views.pedidos_cliente , name="ListadoPedidos"),

    path('AgregarProductoCompra/', views.add_products_purchase , name="AgregarProductoCompra"), 
    path('AgregarProductoVentaE/', views.add_products_emp , name="AgregarProductoVentaE"),
    path('Eliminar/', views.remove_products , name="Eliminar"),
    path('EliminarProductoCompra/', views.remove_products_purchase , name="EliminarProductoCompra"),
    path('EliminarProductoVentaE/', views.remove_product_emp , name="EliminarProductoVentaE"),


    path('EnvioCorreo/', views.email_for_all_employees , name="EnvioCorreo"),


    # password_reset
    

    
    path('reset_password/', auth_views.PasswordResetView.as_view(template_name="autenticacion/password-reset.html"), name='password_resett'),
    path('reset_password_send/', auth_views.PasswordResetDoneView.as_view(template_name="autenticacion/password-reset-send.html"), name='password_reset_done'),
    path('reset/<uidb64>/<token>', auth_views.PasswordResetConfirmView.as_view(template_name="autenticacion/password-confirm.html"),name='password_reset_confirm'),
    path('reset_password_complete/', auth_views.PasswordResetCompleteView.as_view(template_name="autenticacion/password-reset-complete.html"), name='password_reset_complete'),

    path('factura/<int:id_sale>', views.Factura , name="Factura"),
    path('facturacompra/<int:id_purchase>', views.Factura_compra , name="FacturaCompra"),

    ## url para las graficas
    path('GraficaVentas/', views.grafico_ventas , name="GraficaVentas"),
    path('GraficaCompras/', views.grafico_compras , name="GraficaCompras"),
    path('ProductosVendidos/', views.productos_vendidos , name="ProductosVendidos"),
]

if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root = settings.MEDIA_ROOT)
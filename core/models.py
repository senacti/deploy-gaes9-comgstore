from dataclasses import fields
from email.policy import default
from pyexpat import model
from random import choices
from unicodedata import decimal
from django.contrib.auth.models import User
from django.db import models
from tabnanny import verbose
from django.test import tag
from django.utils.html import format_html
from django.db.models.signals import m2m_changed
from django.db.models.signals import post_save
from django.db.models.signals import pre_save
from enum import Enum

# Create your models here
class Permissions(models.Model):
    id_permission = models.IntegerField(primary_key=True)
    description = models.TextField(verbose_name="Descripcion del permiso")
    date_creation = models.DateField(verbose_name="Fecha creacion permiso")
    state = models.BooleanField(verbose_name = "Estado del permiso", default = True)
    
    def __str__(self):
        return self.description

    class Meta:
        verbose_name = 'Permiso'
        verbose_name_plural = 'Permisos'
        db_table = 'permiso'
        ordering = ['id_permission']


class Rol(models.Model):
    cod_rol = models.IntegerField(primary_key=True)
    name_rol = models.CharField(max_length = 20, verbose_name="Nombre rol")
    id_permission = models.ManyToManyField(Permissions)

    def __str__(self):
        return self.name_rol

    class Meta:
        verbose_name = 'Rol'
        verbose_name_plural = 'Roles'
        db_table = 'rol'
        ordering = ['cod_rol']





class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    id_profile = models.IntegerField(primary_key=True)
    birthdate = models.DateField(verbose_name="Fecha nacimiento")
    gender = models.CharField(max_length=9, verbose_name="Genero") 
    telephone_number = models.BigIntegerField(verbose_name="Telefono")
    address = models.CharField(max_length=50, verbose_name="Direccion")
    cod_rol = models.ForeignKey(Rol, on_delete=models.CASCADE)
    state = models.BooleanField(verbose_name = "Estado del usuario", default = True)

    def __int__(self):
        return self.id_profile
    
    class Meta:
        verbose_name = 'Usuario'
        verbose_name_plural = 'Usuarios'
        db_table = 'usuario'
        ordering = ['id_profile']


class StateDomicile(models.Model):
        cod_state_domicile = models.AutoField(primary_key=True) 
        name_state = models.CharField(max_length=20,verbose_name='Estado del Domicilio')
        def __str__(self):
            return self.name_state
        class Meta:
            verbose_name = 'EstadoDomicilio'
            verbose_name_plural = 'EstadoDomicilios'
            db_table = 'estado_domicilio'
            ordering = ['cod_state_domicile']


class Client(models.Model):
    cod_client = models.IntegerField(primary_key=True) 
    client_name = models.CharField(max_length=20,verbose_name='Nombre del cliente')
    client_address = models.CharField(max_length=50,verbose_name='Direccion del cliente')
    id_user = models.ForeignKey(Profile, on_delete=models.CASCADE)
    
    def __str__(self):
        return self.client_name

    class Meta:
        verbose_name = 'Cliente'
        verbose_name_plural = 'Clientes'
        db_table = 'cliente'
        ordering = ['cod_client']


class Product(models.Model):
    cod_product = models.AutoField(primary_key=True)
    name = models.CharField(max_length = 30, verbose_name = "Nombre del producto")
    brand = models.CharField(max_length =20,verbose_name = "Marca del producto")
    price_product = models.DecimalField(verbose_name = "Precio de Venta", default=0, max_digits=8, decimal_places=2)
    price_supplier = models.DecimalField(verbose_name = "Precio del proveedor", default=0, max_digits=8, decimal_places=2)
    net_content = models.CharField(max_length=15,verbose_name="Contenido neto")
    product_image = models.ImageField(upload_to='media' ,verbose_name = "Imagen del producto")
    stock = models.SmallIntegerField(verbose_name="Unidades_stock", default=0)
    state = models.BooleanField(verbose_name = "Estado Producto", default = True)
    
    def __str__(self):
        return self.name
    
    class Meta:
        verbose_name = 'Producto'
        verbose_name_plural = 'Productos'
        db_table = 'producto'
        ordering = ['cod_product']

    def disable_product(self):
        self.state = False
        self.save()

    def enable_product(self):
        self.state = True
        self.save()

    def imagen_producto(self):
        return format_html('<img src={} width="100" /> ', self.product_image.url)  



class Sales(models.Model):
    cod_sale = models.AutoField(primary_key=True)
    date_sale = models.DateField(auto_now_add=True, verbose_name="Fecha Venta")
    full_value = models.DecimalField(default=0, max_digits=8, decimal_places=2)
    id_user = models.ForeignKey(Profile, on_delete=models.CASCADE, null= True)
    cod_client = models.ForeignKey(Client, on_delete=models.CASCADE, null= True)
    #cod_order = models.ForeignKey(Order, on_delete=models.CASCADE, null=True)
    cod_product = models.ManyToManyField(Product, through='SalesDetail')

    def __str__(self):
        return str(self.cod_sale)
    
    @property
    def order(self):
        return self.order_set.first()

    def update_total(self):
        self.full_value = sum([ 
            cp.quantity * cp.product.price_product for cp in self.products_related()
         ])
        
        if self.order:
            self.order.update_total()

        self.save()

    

    def products_related(self):
        return self.salesdetail_set.select_related('product')
        
    class Meta:
        verbose_name = 'Venta'
        verbose_name_plural = 'Ventas'
        db_table = 'venta'
        ordering = ['cod_sale']

class SalesDetailManager(models.Manager):
    def create_or_update_quantity(self, sale, product, quantity=1):
        object, created = self.get_or_create(sale=sale, product=product)

        if not created:
            quantity = object.quantity + quantity
        
        object.update_quantity(quantity)
        return object

class SalesDetail(models.Model):
    sale = models.ForeignKey(Sales, on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    quantity = models.IntegerField(default=1, verbose_name="Cantidad")
    subtotal = models.DecimalField(default=0, max_digits=8, decimal_places=2)

    objects = SalesDetailManager()

    def update_quantity(self, quantity=1):
        self.quantity = quantity
        self.save()

    def update_subtotal(self):
        self.subtotal = self.product.price_product * self.quantity 

        self.save()

    class Meta:
        verbose_name = 'DetalleVenta'
        verbose_name_plural = 'Detalle_Ventas'
        db_table = 'detalle_venta'
        ordering = ['id']

def update_totals(sender, instance, action, *args, **kwargs):
    if action == 'post_add' or action == 'post_remove' or action == 'post_clear':
        instance.update_total()

def post_save_update_totals(sender, instance, *args, **kwargs):
    instance.sale.update_total()

post_save.connect(post_save_update_totals, sender=SalesDetail)
m2m_changed.connect(update_totals, sender=Sales.cod_product.through)


class OrderStatus(Enum):
    CREATED = 'Creado'
    PAYED = 'Pagado'
    COMPLETED = 'Completado'
    CANCELED = 'Cancelado'

choices = [ (tag, tag.value) for tag in OrderStatus ]

class Order(models.Model):
    cod_order = models.AutoField(primary_key=True) 
    status = models.CharField(max_length=50,choices=choices, default=OrderStatus.CREATED)
    id_user = models.ForeignKey(Profile, on_delete=models.CASCADE, null= True)
    deliver_cost = models.DecimalField(default=1000, max_digits=8, decimal_places=2)
    full_value = models.DecimalField(default=0, max_digits=8, decimal_places=2)
    date_order = models.DateField(auto_now_add=True, verbose_name='Fecha del Pedido')
    cod_sale = models.ForeignKey(Sales, on_delete=models.CASCADE, null = True)
    
    def __str__(self):
        return str(self.cod_order)

    def get_total(self):
        return self.cod_sale.full_value + self.deliver_cost

    def update_total(self):
        self.full_value = self.get_total()
        self.save()

    def cancel(self):
        self.status = OrderStatus.CANCELED
        self.save()

    def complete(self):
        self.status = OrderStatus.COMPLETED
        self.save()

    def register(self):
        self.status = OrderStatus.CREATED

    class Meta:
        verbose_name = 'Orden'
        verbose_name_plural = 'Ordenes'
        db_table = 'orden'
        ordering = ['cod_order']



def set_total(sender, instance, *args, **kwargs):
    instance.full_value = instance.get_total()

pre_save.connect(set_total, sender=Order)

class Delivery(models.Model):
    cod_delivery = models.AutoField(primary_key=True)
    date = models.DateField(auto_now_add=True, blank=True, verbose_name="Fecha Domicilio")
    state_domicile = models.ForeignKey(StateDomicile, on_delete=models.CASCADE)
    id_user = models.ForeignKey(Profile, verbose_name="Domiciliario", on_delete=models.CASCADE)
    code_order = models.ForeignKey(Order, on_delete=models.CASCADE)
        
    def __str__(self):
        return str(self.cod_delivery)
        
    class Meta:
        verbose_name = 'Domicilio'
        verbose_name_plural = 'Domicilios'
        db_table = 'domicilio'
        ordering = ['cod_delivery']

class Supplier(models.Model):
    cod_supplier = models.IntegerField(primary_key=True)
    name_supplier = models.CharField(max_length = 30, verbose_name = "Nombre del proveedor")
    enterprise = models.CharField(max_length = 20, verbose_name = "Nombre de la empresa")
    telephone_number = models.BigIntegerField(verbose_name = "Numero de telefono")
    
    def __str__(self):
        return self.name_supplier
    
    class Meta:
        verbose_name = 'Proveedor'
        verbose_name_plural = 'Proveedores'
        db_table = 'proveedor'
        ordering = ['cod_supplier']


class Purchase(models.Model):
    cod_purchase = models.AutoField(primary_key=True)
    total_value = models.DecimalField(default=0, max_digits=8, decimal_places=2, verbose_name = 'Valor Total')
    date_purchase = models.DateField(auto_now_add=True, blank=True, verbose_name="Fecha Compra")
    supplier = models.ForeignKey(Supplier, on_delete=models.CASCADE, null = True)
    id_user = models.ForeignKey(Profile, on_delete=models.CASCADE)
    cod_product = models.ManyToManyField(Product, through='PurchaseDetail')

    def __str__(self):
        return str(self.cod_purchase)

    def update_total_purchase(self):
        self.total_value = sum([ 
            cp.quantity * cp.product.price_supplier for cp in self.products_related_purchase()
         ])

        self.save()

    def products_related_purchase(self):
        return self.purchasedetail_set.select_related('product')
    
    class Meta:
        verbose_name = 'Compra'
        verbose_name_plural = 'Compras'
        db_table = 'compra'
        ordering = ['cod_purchase']

class PurchaseDetailManager(models.Manager):
    def create_or_update_quantity_purchase(self, purchase, product, quantity=1):
        object, created = self.get_or_create(purchase=purchase, product=product)

        if not created:
            quantity = object.quantity + quantity
        
        object.update_quantity_purchase(quantity)
        return object

class PurchaseDetail(models.Model):
    purchase = models.ForeignKey(Purchase, on_delete=models.CASCADE)
    product = models.ForeignKey(Product, on_delete=models.CASCADE)
    quantity = models.IntegerField(default=1, verbose_name="Cantidad")
    subtotal = models.DecimalField(default=0, max_digits=8, decimal_places=2)
    
    def update_subtotal(self):
        self.subtotal = self.product.price_supplier * self.quantity 
        self.save()
        
    subtotal = models.DecimalField(default=0, max_digits=8, decimal_places=2)
    objects = PurchaseDetailManager()

    def update_quantity_purchase(self, quantity=1):
        self.quantity = quantity
        self.save()


    def update_subtotal(self):
        self.subtotal = self.product.price_product * self.quantity 

        self.save()

    class Meta:
        verbose_name = 'DetalleCompra'
        verbose_name_plural = 'Detalle_Compras'
        db_table = 'detalle_compra'
        ordering = ['id']

def update_totals_purchase(sender, instance, action, *args, **kwargs):
    if action == 'post_add' or action == 'post_remove' or action == 'post_clear':
        instance.update_total_purchase()

def post_save_update_totals_purchase(sender, instance, *args, **kwargs):
    instance.purchase.update_total_purchase()

post_save.connect(post_save_update_totals_purchase, sender=PurchaseDetail)
m2m_changed.connect(update_totals_purchase, sender=Purchase.cod_product.through)

class InventoryMovement(models.Model):
    cod_inventory = models.IntegerField(primary_key=True)
    previous_units = models.IntegerField(verbose_name="Unidades anteriores")
    units = models.IntegerField(verbose_name="Unidades entrantes y/o salientes")
    kind_of_movement = models.CharField(max_length=15, verbose_name="Tipo de Movimiento")
    date_inventory = models.DateField(auto_now_add=True, blank=True, verbose_name="Fecha Inventario")
    cod_product = models.ForeignKey(Product, on_delete=models.CASCADE)

    def __str__(self):
        return str(self.cod_inventory)
    
    class Meta:
        verbose_name = 'Inventario'
        verbose_name_plural = 'Inventarios'
        db_table = 'inventario'
        ordering = ['cod_inventory']
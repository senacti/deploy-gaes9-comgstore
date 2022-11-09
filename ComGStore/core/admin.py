from sre_parse import State
from django.contrib import admin
from import_export import resources
from import_export.admin import ImportExportModelAdmin

# Register your models here.
from.models import Permissions, Rol, Profile, StateDomicile, Client, Order, Delivery, Product, Sales, Supplier, Purchase, InventoryMovement

""" 
admin.site.register(Permissions)
admin.site.register(Rol)
admin.site.register(User)
admin.site.register(StateDomicile)
admin.site.register(Client)
admin.site.register(Order)
admin.site.register(Delivery)
admin.site.register(Product)
admin.site.register(Sales)
admin.site.register(Supplier)
admin.site.register(Purchase)
admin.site.register(InventoryMovement) 

, InventoryMovementResources , PurchaseResources, SalesResources, SupplierResources

"""

@admin.register(Permissions)
class PermissionsAdmin(admin.ModelAdmin):
  list_display = ["id_permission","description", "date_creation", "state"]
  list_editable = ['date_creation']
  search_fields = ['id_permission']
  list_per_page = 5

@admin.register(Rol)
class RolAdmin(admin.ModelAdmin):
  list_display = ['cod_rol','name_rol']
  search_fields = ['name_rol']
  list_per_page = 5
  
@admin.register(Profile)
class UserAdmin(admin.ModelAdmin):
  list_display = ['id_profile',  'birthdate', 'gender', 'telephone_number', 'address', "cod_rol", "state"]
  list_editable = ['telephone_number', 'address', "state"]
  search_fields = ['id_profile']
  list_filter = ['cod_rol']
  list_per_page = 5

@admin.register(StateDomicile)
class StateDomicileAdmin(admin.ModelAdmin):
  list_display = ['cod_state_domicile','name_state']
  search_fields = ['name_state']
  
  list_per_page = 5

@admin.register(Client)
class ClientAdmin(admin.ModelAdmin):
  list_display = ['cod_client','client_name','client_address']
  list_editable = ['client_address']
  search_fields = ['cod_client','client_name']
  list_per_page = 5
  
@admin.register(Order)
class OrderAdmin(admin.ModelAdmin):
  list_display = ['cod_order','status', 'id_user', 'full_value', 'date_order', 'cod_sale']
  list_filter = ['date_order']
  search_fields = ['status']
  list_per_page = 5

@admin.register(Delivery)
class DeliveryAdmin(admin.ModelAdmin):
  list_display = ['cod_delivery','date','state_domicile','id_user','code_order']
  list_editable = ['state_domicile']
  search_fields = ['cod_delivery','date','state_domicile','code_order']
  list_per_page = 5

@admin.register(Product)
class ProductAdmin(ImportExportModelAdmin):
  list_display = ['cod_product', 'name', 'brand', 'price_product', 'net_content', 'imagen_producto', 'stock', 'state']
  list_editable = ['stock', 'price_product', 'state']
  list_display_link = ['product_image']
  search_fields = ['name']
  list_filter = ['brand']
  list_per_page = 5

@admin.register(Sales)
class SalesAdmin(ImportExportModelAdmin):
  list_display = ["cod_sale","full_value", "date_sale", "cod_client", "id_user"]
  search_fields = ['cod_sale','cod_client']
  list_filter = ['cod_client','date_sale']
  list_per_page = 5
  
@admin.register(Supplier)
class SupplierAdmin(ImportExportModelAdmin):
  list_display = ['cod_supplier','name_supplier','enterprise', 'telephone_number']
  list_editable = ['name_supplier','enterprise','telephone_number']
  search_fields = ['name_supplier','enterprise']
  list_filter = ['enterprise']
  list_per_page = 5
  
@admin.register(Purchase)
class PurchaseAdmin(ImportExportModelAdmin):
  list_display = ['cod_purchase','total_value','date_purchase','supplier','id_user']
  search_fields = ['supplier']
  list_filter = ['date_purchase']
  list_per_page = 5
  
@admin.register(InventoryMovement)
class InventoryMovementAdmin(ImportExportModelAdmin):
  list_display = ['cod_inventory','kind_of_movement','previous_units','units','date_inventory','cod_product']
  search_fields = ['units','date_inventory']
  list_filter = ['date_inventory','kind_of_movement']
  list_per_page = 5


# Modelos para importar y exportar datos de las distintas tablas de la bd

class ProductResources(resources.ModelResource):
    class Meta:
        model = Product
        fields = ("cod_product","name", "brand", "price_product", "net_content", "stock")
        export_order = ('cod_product', 'name', 'brand', 'price_product', 'net_content', 'product_image', 'stock')

class InventoryMovementResources(resources.ModelResource):
    class Meta:
        model = InventoryMovement
        fields = ('cod_inventory', 'previous_units', 'units', 'kind_of_movement', 'date_inventory', 'cod_product')
        export_order = ('cod_inventory', 'previous_units', 'units', 'kind_of_movement', 'date_inventory', 'cod_product')
      
class PurchaseResources(resources.ModelResource):
    class Meta:
        model = Purchase
        fields = ('cod_purchase', 'total', 'value', 'date_purchase', 'supplier', 'id_user', 'cod_product')
        export_order = ('cod_purchase', 'total', 'value', 'date_purchase', 'supplier', 'id_user', 'cod_product')

class SalesResources(resources.ModelResource):
    class Meta:
        model = Sales
        fields = ('cod_sale', 'date_sale', 'full_value', 'id_user', 'cod_client', 'cod_product')
        export_order = ('cod_sale', 'date_sale', 'full_value', 'id_user', 'cod_client', 'cod_product')

class SupplierResources(resources.ModelResource):
    class Meta:
        model = Supplier
        fields = ('cod_supplier', 'name_supplier', 'enterprise', 'telephone_number')
        export_order = ('cod_supplier', 'name_supplier', 'enterprise', 'telephone_number')
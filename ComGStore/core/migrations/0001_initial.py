# Generated by Django 4.1 on 2022-10-26 23:45

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Client',
            fields=[
                ('cod_client', models.IntegerField(primary_key=True, serialize=False)),
                ('client_name', models.CharField(max_length=20, verbose_name='Nombre del cliente')),
                ('client_address', models.CharField(max_length=50, verbose_name='Direccion del cliente')),
            ],
            options={
                'verbose_name': 'Cliente',
                'verbose_name_plural': 'Clientes',
                'db_table': 'cliente',
                'ordering': ['cod_client'],
            },
        ),
        migrations.CreateModel(
            name='Order',
            fields=[
                ('cod_order', models.IntegerField(primary_key=True, serialize=False)),
                ('date_order', models.DateField(auto_now_add=True, verbose_name='Fecha del Pedido')),
                ('full_value', models.FloatField(verbose_name='Valor Total')),
                ('cod_client', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='core.client')),
            ],
            options={
                'verbose_name': 'Orden',
                'verbose_name_plural': 'Ordenes',
                'db_table': 'orden',
                'ordering': ['cod_order'],
            },
        ),
        migrations.CreateModel(
            name='Permissions',
            fields=[
                ('id_permission', models.IntegerField(primary_key=True, serialize=False)),
                ('description', models.TextField(verbose_name='Descripcion del permiso')),
                ('date_creation', models.DateField(verbose_name='Fecha creacion permiso')),
                ('state', models.BooleanField(default=True, verbose_name='Estado del permiso')),
            ],
            options={
                'verbose_name': 'Permiso',
                'verbose_name_plural': 'Permisos',
                'db_table': 'permiso',
                'ordering': ['id_permission'],
            },
        ),
        migrations.CreateModel(
            name='Product',
            fields=[
                ('cod_product', models.IntegerField(primary_key=True, serialize=False)),
                ('name', models.CharField(max_length=30, verbose_name='Nombre del producto')),
                ('brand', models.CharField(max_length=20, verbose_name='Marca del producto')),
                ('price_product', models.FloatField(verbose_name='Precio del producto')),
                ('net_content', models.CharField(max_length=15, verbose_name='Contenido neto')),
                ('product_image', models.ImageField(upload_to='media', verbose_name='Imagen del producto')),
                ('stock', models.SmallIntegerField(verbose_name='Unidades_stock')),
                ('state', models.BooleanField(default=True, verbose_name='Estado Producto')),
            ],
            options={
                'verbose_name': 'Producto',
                'verbose_name_plural': 'Productos',
                'db_table': 'producto',
                'ordering': ['cod_product'],
            },
        ),
        migrations.CreateModel(
            name='Profile',
            fields=[
                ('id_profile', models.IntegerField(primary_key=True, serialize=False)),
                ('birthdate', models.DateField(verbose_name='Fecha nacimiento')),
                ('gender', models.CharField(max_length=9, verbose_name='Genero')),
                ('telephone_number', models.BigIntegerField(verbose_name='Telefono')),
                ('address', models.CharField(max_length=50, verbose_name='Direccion')),
                ('state', models.BooleanField(default=True, verbose_name='Estado del usuario')),
            ],
            options={
                'verbose_name': 'Usuario',
                'verbose_name_plural': 'Usuarios',
                'db_table': 'usuario',
                'ordering': ['id_profile'],
            },
        ),
        migrations.CreateModel(
            name='Sales',
            fields=[
                ('cod_sale', models.AutoField(primary_key=True, serialize=False)),
                ('date_sale', models.DateField(auto_now_add=True, verbose_name='Fecha Venta')),
                ('full_value', models.FloatField(null=True, verbose_name='Valor Total')),
                ('cod_client', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='core.client')),
                ('cod_order', models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='core.order')),
            ],
            options={
                'verbose_name': 'Venta',
                'verbose_name_plural': 'Ventas',
                'db_table': 'venta',
                'ordering': ['cod_sale'],
            },
        ),
        migrations.CreateModel(
            name='StateDomicile',
            fields=[
                ('cod_state_domicile', models.IntegerField(primary_key=True, serialize=False)),
                ('name_state', models.CharField(max_length=20, verbose_name='Estado del Domicilio')),
            ],
            options={
                'verbose_name': 'EstadoDomicilio',
                'verbose_name_plural': 'EstadoDomicilios',
                'db_table': 'estado_domicilio',
                'ordering': ['cod_state_domicile'],
            },
        ),
        migrations.CreateModel(
            name='Supplier',
            fields=[
                ('cod_supplier', models.IntegerField(primary_key=True, serialize=False)),
                ('name_supplier', models.CharField(max_length=30, verbose_name='Nombre del proveedor')),
                ('enterprise', models.CharField(max_length=20, verbose_name='Nombre de la empresa')),
                ('telephone_number', models.BigIntegerField(verbose_name='Numero de telefono')),
            ],
            options={
                'verbose_name': 'Proveedor',
                'verbose_name_plural': 'Proveedores',
                'db_table': 'proveedor',
                'ordering': ['cod_supplier'],
            },
        ),
        migrations.CreateModel(
            name='SalesDetail',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('quantity', models.IntegerField(default=1, verbose_name='Cantidad')),
                ('product', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='core.product')),
                ('sale', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='core.sales')),
            ],
            options={
                'verbose_name': 'DetalleVenta',
                'verbose_name_plural': 'Detalle_Ventas',
                'db_table': 'detalle_venta',
                'ordering': ['id'],
            },
        ),
        migrations.AddField(
            model_name='sales',
            name='cod_product',
            field=models.ManyToManyField(through='core.SalesDetail', to='core.product'),
        ),
        migrations.AddField(
            model_name='sales',
            name='id_user',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='core.profile'),
        ),
        migrations.CreateModel(
            name='Rol',
            fields=[
                ('cod_rol', models.IntegerField(primary_key=True, serialize=False)),
                ('name_rol', models.CharField(max_length=20, verbose_name='Nombre rol')),
                ('id_permission', models.ManyToManyField(to='core.permissions')),
            ],
            options={
                'verbose_name': 'Rol',
                'verbose_name_plural': 'Roles',
                'db_table': 'rol',
                'ordering': ['cod_rol'],
            },
        ),
        migrations.CreateModel(
            name='Purchase',
            fields=[
                ('cod_purchase', models.IntegerField(primary_key=True, serialize=False)),
                ('total_value', models.FloatField(verbose_name='Valor Total')),
                ('date_purchase', models.DateField(auto_now_add=True, verbose_name='Fecha Compra')),
                ('cod_product', models.ManyToManyField(to='core.product')),
                ('id_user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='core.profile')),
                ('supplier', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='core.supplier')),
            ],
            options={
                'verbose_name': 'Compra',
                'verbose_name_plural': 'Compras',
                'db_table': 'compra',
                'ordering': ['cod_purchase'],
            },
        ),
        migrations.AddField(
            model_name='profile',
            name='cod_rol',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='core.rol'),
        ),
        migrations.AddField(
            model_name='profile',
            name='user',
            field=models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL),
        ),
        migrations.CreateModel(
            name='InventoryMovement',
            fields=[
                ('cod_inventory', models.IntegerField(primary_key=True, serialize=False)),
                ('previous_units', models.IntegerField(verbose_name='Unidades anteriores')),
                ('units', models.IntegerField(verbose_name='Unidades entrantes y/o salientes')),
                ('kind_of_movement', models.CharField(max_length=15, verbose_name='Tipo de Movimiento')),
                ('date_inventory', models.DateField(auto_now_add=True, verbose_name='Fecha Inventario')),
                ('cod_product', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='core.product')),
            ],
            options={
                'verbose_name': 'Inventario',
                'verbose_name_plural': 'Inventarios',
                'db_table': 'inventario',
                'ordering': ['cod_inventory'],
            },
        ),
        migrations.CreateModel(
            name='Delivery',
            fields=[
                ('cod_delivery', models.IntegerField(primary_key=True, serialize=False)),
                ('date', models.DateField(auto_now_add=True, verbose_name='Fecha Domicilio')),
                ('code_order', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='core.order')),
                ('id_user', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='core.profile')),
                ('state_domicile', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='core.statedomicile')),
            ],
            options={
                'verbose_name': 'Domicilio',
                'verbose_name_plural': 'Domicilios',
                'db_table': 'domicilio',
                'ordering': ['cod_delivery'],
            },
        ),
        migrations.AddField(
            model_name='client',
            name='id_user',
            field=models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='core.profile'),
        ),
    ]

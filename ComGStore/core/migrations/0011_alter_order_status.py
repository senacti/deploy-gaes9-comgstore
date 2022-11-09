# Generated by Django 4.1 on 2022-11-09 15:31

import core.models
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0010_alter_delivery_id_user'),
    ]

    operations = [
        migrations.AlterField(
            model_name='order',
            name='status',
            field=models.CharField(choices=[(core.models.OrderStatus['CREATED'], 'Creado'), (core.models.OrderStatus['PAYED'], 'Pagado'), (core.models.OrderStatus['COMPLETED'], 'Completado'), (core.models.OrderStatus['CANCELED'], 'Cancelado')], default=core.models.OrderStatus['CREATED'], max_length=50),
        ),
    ]
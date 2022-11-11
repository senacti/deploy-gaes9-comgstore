# Generated by Django 4.1 on 2022-10-29 05:04

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('core', '0005_remove_sales_cod_order_order_cod_sale_order_status_and_more'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='order',
            name='cod_client',
        ),
        migrations.AddField(
            model_name='order',
            name='id_user',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='core.profile'),
        ),
    ]
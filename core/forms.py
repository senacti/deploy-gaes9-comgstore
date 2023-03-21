from django.forms import ModelForm
from core.models import Supplier, Product, User, Profile


class SupplierForm(ModelForm):
    class Meta:
        model = Supplier
        fields = [
            'cod_supplier', 'name_supplier', 'enterprise', 'telephone_number'
        ]

        labels = {'cod_supplier': 'Codigo Proveedor'}
    
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        self.fields['cod_supplier'].widget.attrs.update({
            'class' : 'form-control',
            'placeholder' : 'Identificacion del proveedor'
        })

        self.fields['name_supplier'].widget.attrs.update({
            'class' : 'form-control',
            'placeholder' : 'Nombres proveedor'
        })

        self.fields['enterprise'].widget.attrs.update({
            'class' : 'form-control',
            'placeholder' : 'Nombre de la empresa'
        })

        self.fields['telephone_number'].widget.attrs.update({
            'class' : 'form-control'
        })
        
class ProductForm(ModelForm):
    class Meta:
        model = Product
        fields = [
            'name' , 'brand' ,  'price_supplier', 'price_product', 'net_content' ,'product_image'
        ]
    
    def __init__(self, *args, **kwargs):
        super().__init__(*args, **kwargs)

        self.fields['name'].widget.attrs.update({
            'class' : 'form-control',
        })

        self.fields['brand'].widget.attrs.update({
            'class' : 'form-control',
        })

        self.fields['price_product'].widget.attrs.update({
            'class' : 'form-control'
        })

        self.fields['price_supplier'].widget.attrs.update({
            'class' : 'form-control'
        })

        self.fields['net_content'].widget.attrs.update({
            'class' : 'form-control'
        })

        self.fields['product_image'].widget.attrs.update({
            'class' : 'form-control',
            'required' : None
        })
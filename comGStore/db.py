import os

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

MYSQL = {
    'default' : {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'comgstore_django',
        'USER': 'admin_juanp@serv-juanp',
        'PASSWORD': 'ServJPB2004',
        'HOST': 'serv-juanp.mysql.database.azure.com',
        'PORT': '3306'
    }
}
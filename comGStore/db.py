import os

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

MYSQL = {
    'default' : {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'comgstore_django',
        'USER': 'juan_pablo',
        'PASSWORD': 'ServComG22*',
        'HOST': 'dbcomgstore.mysql.database.azure.com',
        'PORT': '3306'
    }
}
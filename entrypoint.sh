#!/bin/sh

# Aguarda o banco de dados estar pronto
echo "Aguardando o banco de dados..."
while ! nc -z db 5432; do
    sleep 1
done
echo "Banco de dados pronto!"

# Aplica as migrações do Django
python manage.py migrate

# Coleta os arquivos estáticos
python manage.py collectstatic --noinput

# Inicia o servidor Django
gunicorn django_docker.wsgi:application --bind 0.0.0.0:8000
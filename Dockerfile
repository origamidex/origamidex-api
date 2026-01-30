FROM php:8.2-apache

# Habilita o mod_rewrite do Apache (útil para rotas amigáveis)
RUN a2enmod rewrite

# Copia o seu código para a pasta padrão do servidor web
COPY . /var/www/html/

# O Render usa a porta 10000 ou 80. Vamos configurar para a 10000
RUN sed -i 's/80/10000/g' /etc/apache2/sites-available/000-default.conf /etc/apache2/ports.conf

EXPOSE 10000

# O Apache já inicia automaticamente

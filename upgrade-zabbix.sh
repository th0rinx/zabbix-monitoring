#!/bin/bash

# Variables de configuración
BACKUP_DIR="/backup-zabbix-server-6"
DB_USER="zabbix"
DB_PASS="zabbix"
DB_NAME="zabbix"
ZABBIX_REPO_URL="https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_7.0-2+ubuntu24.04_all.deb"

# Crear directorios de respaldo
echo "Creando directorios de respaldo..."
mkdir -p ${BACKUP_DIR}/{conf-files,bin-files,doc-files,web-files,database-files}

# Copia de archivos de configuración
echo "Copiando archivos de configuración..."
cp -rp /etc/zabbix/zabbix_server.conf ${BACKUP_DIR}/conf-files/
cp -rp /etc/httpd/conf.d/zabbix.conf ${BACKUP_DIR}/conf-files/ 2>/dev/null
cp -rp /etc/apache2/conf-enabled/zabbix.conf ${BACKUP_DIR}/conf-files/ 2>/dev/null
cp -rp /etc/zabbix/php-fpm.conf ${BACKUP_DIR}/conf-files/ 2>/dev/null

# Copia de archivos binarios
echo "Copiando archivos binarios..."
cp -rp /usr/sbin/zabbix_server ${BACKUP_DIR}/bin-files/

# Copia de documentación
echo "Copiando archivos de documentación..."
cp -rp /usr/share/doc/zabbix-* ${BACKUP_DIR}/doc-files/

# Copia de archivos web
echo "Copiando archivos web..."
cp -rp /usr/share/zabbix/ ${BACKUP_DIR}/web-files/

# Copia de la base de datos
echo "Copiando base de datos..."
mysqldump -u${DB_USER} -p${DB_PASS} --single-transaction ${DB_NAME} > ${BACKUP_DIR}/database-files/zabbix-backup.sql

# Descargar e instalar el paquete de repositorio de Zabbix 7.0
echo "Descargando el repositorio de Zabbix..."
wget -O /tmp/zabbix-release.deb ${ZABBIX_REPO_URL}
echo "Instalando el repositorio de Zabbix..."
dpkg -i /tmp/zabbix-release.deb

# Actualización de paquetes de Zabbix
echo "Actualizando paquetes de Zabbix..."
apt update
apt install --only-upgrade zabbix-server-mysql zabbix-frontend-php zabbix-agent zabbix-apache-conf -y

# Limpieza
echo "Eliminando el archivo del repositorio descargado..."
rm -f /tmp/zabbix-release.deb

echo "Actualización y respaldo de Zabbix completados."

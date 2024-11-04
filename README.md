# Script de Actualización de Zabbix: 6.4 a 7.0 LTS en Ubuntu 24.04

## Requisitos
- Ubuntu 24.04 LTS
- Zabbix 6.4 instalado actualmente
- MySQL o MariaDB como base de datos


## Notas Importantes
Permiso de MySQL para mysqldump
Durante el proceso de respaldo, el script utiliza mysqldump para crear una copia de seguridad de la base de datos de Zabbix. Si encuentras un error relacionado con permisos insuficientes, es posible que necesites otorgar el privilegio PROCESS al usuario de Zabbix en MySQL.



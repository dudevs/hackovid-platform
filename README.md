# hackovid-platform
Platform (conté la base de dades)

1. Descarregar el Postgre a https://www.postgresql.org/download/. Hem estat utilitznt la última versió actual, la 12.
2. Instal·lar l'extensió postgis al final de l'instal·lació per tenir les funcions de geolocalització.
3. Creem l'esquema `CREATE SCHEMA supermarket;`
4. Dins el Postgre afegir l'extensió plpgsql dins de l'esquema supermarket si no hi és: Apretarem el botó dret a extensions/create/extensions i, primerament, posar l'extensió supermarquet a la segona pestanya i, finalment, plpgsqla a la primera pestanya.
5. Executar script tables.sql
6. Executar script views.sql
7. Executar functions.sql
8. Executar script init data.sql


## Docker (opcional)

Descarregar la versió més recent de Docker des de https://www.docker.com/products/docker-desktop

Obrir una consola i anar dins la carpeta Docker del projecte.

Executeu les següents comandes:

### Crear una xarxa on es connectarà el contenidor de docker
``` shell
docker network create hackovid-network
```

### Construir la imatge
``` shell
docker-compose build
```

### Posar en marxa el contenidor
``` shell
docker-compose up
```
Podeu afegir el parametre -d per tal que una vegada aixecat el contenidor pogueu continuar fent servir el terminal

### Aturar el contenidor
``` shell
docker-compose down
```

**Informació adicional:** si voleu connectar-vos des de qualsevol client de PostgreSQL al contenidor, descomenteu les següents línies del fitxer docker-compose.yml
```shell
#expose:
#  - 5432
```

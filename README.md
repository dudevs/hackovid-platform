# hackovid-platform
Platform (conté la base de dades)

Descarregar el Postgre a https://www.postgresql.org/download/ 

Instal·lar l'extensió postgis al final de l'instal·lació per tenir les funcions de geolocalització.

Creem l'esquema `CREATE SCHEMA supermarket;`

Dins el Postgre afegir l'extensió plpgsql dins de l'esquema supermarket.


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

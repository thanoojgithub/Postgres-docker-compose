
.env
```
POSTGRES_HOST=postgres
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
POSTGRES_DB=mydb
PGADMIN_DEFAULT_EMAIL=admin@pgadmin.com
PGADMIN_DEFAULT_PASSWORD=password
```
Steps:
```
PS C:\Users\Admin\codebase\docker_images> dir


Directory: C:\Users\Admin\codebase\docker_images


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----        12/22/2024  11:53 PM            168 .env
-a----        12/22/2024  11:52 PM           1003 docker-compose.yml
-a----        12/22/2024  11:44 PM           1023 init.sql


PS C:\Users\Admin\codebase\docker_images> docker compose up -d
[+] Running 32/32
 ✔ postgres Pulled                                                                                                                                    36.3s
   ✔ bc0965b23a04 Pull complete                                                                                                                       15.5s
   ✔ 002e1a8eb6f9 Pull complete                                                                                                                       15.5s
   ✔ a24f300391ed Pull complete                                                                                                                       15.9s
   ✔ 627f580b7ad7 Pull complete                                                                                                                       15.9s
   ✔ cfb3c2203f88 Pull complete                                                                                                                       16.7s
   ✔ 9e592465b243 Pull complete                                                                                                                       16.9s
   ✔ 8d4265d09d9c Pull complete                                                                                                                       16.9s
   ✔ e3a8293e92fd Pull complete                                                                                                                       17.0s
   ✔ 2cb801c39436 Pull complete                                                                                                                       28.2s
   ✔ c5fdb20d8658 Pull complete                                                                                                                       28.3s
   ✔ 67c5fe618f0c Pull complete                                                                                                                       28.3s
   ✔ c9cdd1fe82e4 Pull complete                                                                                                                       28.3s
   ✔ 8f152c4aceed Pull complete                                                                                                                       28.3s
   ✔ 2cd360f3b7db Pull complete                                                                                                                       28.4s
 ✔ pgadmin Pulled                                                                                                                                     38.9s
   ✔ 38a8310d387e Pull complete                                                                                                                        1.7s
   ✔ 087843ea2956 Pull complete                                                                                                                       25.6s
   ✔ 6db836a75a2d Pull complete                                                                                                                       25.8s
   ✔ 5d0e4706d110 Pull complete                                                                                                                       25.9s
   ✔ 31ebcef82521 Pull complete                                                                                                                       26.0s
   ✔ 91551c39a7c3 Pull complete                                                                                                                       26.0s
   ✔ 210d55276a54 Pull complete                                                                                                                       26.1s
   ✔ 0f3a11d54a10 Pull complete                                                                                                                       26.1s
   ✔ dcd3056dbb91 Pull complete                                                                                                                       28.6s
   ✔ 545d1f431f52 Pull complete                                                                                                                       29.3s
   ✔ 48449e1741e8 Pull complete                                                                                                                       29.4s
   ✔ 1213e95defdb Pull complete                                                                                                                       29.4s
   ✔ 55c17a7b26f0 Pull complete                                                                                                                       29.5s
   ✔ 31af12c6548e Pull complete                                                                                                                       29.5s
   ✔ 93a2e5af292e Pull complete                                                                                                                       29.5s
   ✔ 609a99bd4f87 Pull complete                                                                                                                       31.0s
[+] Running 5/5
 ✔ Network docker_images_default       Created                                                                                                         0.1s
 ✔ Volume "docker_images_pgadmin"      Created                                                                                                         0.0s
 ✔ Volume "docker_images_postgres"     Created                                                                                                         0.0s
 ✔ Container docker_images-postgres-1  Started                                                                                                         1.6s
 ✔ Container docker_images-pgadmin-1   Started                                                                                                         1.0s
PS C:\Users\Admin\codebase\docker_images> docker compose images
CONTAINER                  REPOSITORY          TAG                 IMAGE ID            SIZE
docker_images-pgadmin-1    dpage/pgadmin4      latest              199b8ca63523        507MB
docker_images-postgres-1   postgres            latest              810c36706d00        435MB
PS C:\Users\Admin\codebase\docker_images> docker compose ps -a
NAME                       IMAGE                   COMMAND                  SERVICE    CREATED          STATUS                    PORTS
docker_images-pgadmin-1    dpage/pgadmin4:latest   "/entrypoint.sh"         pgadmin    11 seconds ago   Up 10 seconds             443/tcp, 0.0.0.0:15432->80/tcp
docker_images-postgres-1   postgres:latest         "docker-entrypoint.s…"   postgres   12 seconds ago   Up 11 seconds (healthy)   0.0.0.0:5432->5432/tcp
PS C:\Users\Admin\codebase\docker_images> docker compose config
name: docker_images
services:
  pgadmin:
    depends_on:
      postgres:
        condition: service_started
        required: true
    environment:
      PGADMIN_DEFAULT_EMAIL: admin@pgadmin.com
      PGADMIN_DEFAULT_PASSWORD: password
      PGADMIN_LISTEN_PORT: "80"
    image: dpage/pgadmin4:latest
    networks:
      default: null
    ports:
      - mode: ingress
        target: 80
        published: "15432"
        protocol: tcp
    volumes:
      - type: volume
        source: pgadmin
        target: /var/lib/pgadmin
        volume: {}
  postgres:
    environment:
      PGADMIN_DEFAULT_EMAIL: admin@pgadmin.com
      PGADMIN_DEFAULT_PASSWORD: password
      POSTGRES_DB: mydb
      POSTGRES_HOST: postgres
      POSTGRES_PASSWORD: postgres
      POSTGRES_USER: postgres
    healthcheck:
      test:
        - CMD-SHELL
        - sh -c 'pg_isready -U postgres -d mydb'
      timeout: 3s
      interval: 10s
      retries: 3
    image: postgres:latest
    networks:
      default: null
    ports:
      - mode: ingress
        target: 5432
        published: "5432"
        protocol: tcp
    restart: always
    volumes:
      - type: bind
        source: C:\Users\Admin\codebase\docker_images\init.sql
        target: /docker-entrypoint-initdb.d/init.sql
        bind:
          create_host_path: true
      - type: volume
        source: postgres
        target: /var/lib/postgresql/data
        volume: {}
networks:
  default:
    name: docker_images_default
volumes:
  pgadmin:
    name: docker_images_pgadmin
  postgres:
    name: docker_images_postgres
PS C:\Users\Admin\codebase\docker_images>
```

`init.sql` SQL script file execution on server startup
```
2024-12-22 19:20:37.517 UTC [48] LOG:  database system is ready to accept connections
 done
server started
CREATE DATABASE


/usr/local/bin/docker-entrypoint.sh: running /docker-entrypoint-initdb.d/init.sql
                                                       version                                                       
---------------------------------------------------------------------------------------------------------------------
 PostgreSQL 17.2 (Debian 17.2-1.pgdg120+1) on x86_64-pc-linux-gnu, compiled by gcc (Debian 12.2.0-14) 12.2.0, 64-bit
(1 row)

 current_date 
--------------
 2024-12-22
(1 row)

CREATE TABLE
CREATE TABLE
INSERT 0 3
INSERT 0 4
 customerid | customername |          email          | branchid 
------------+--------------+-------------------------+----------
          1 | John Doe     | john.doe@example.com    |        1
          2 | Jane Smith   | jane.smith@example.com  |        1
          3 | Alice Brown  | alice.brown@example.com |        2
          4 | Bob Johnson  | bob.johnson@example.com |        3
(4 rows)

PostgreSQL init process complete; ready for start up.
```


#### git clone and build
```
git clone https://github.com/thanoojgithub/SpringBootDataREST2.git
gradle clean build --no-build-cache
```

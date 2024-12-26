
.env
```
POSTGRES_HOST=postgres
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
POSTGRES_DB=postgres
PGADMIN_DEFAULT_EMAIL=admin@pgadmin.com
PGADMIN_DEFAULT_PASSWORD=password
```
Steps:
```
PS C:\Users\Admin\codebase\docker_images\20241226_1> dir


    Directory: C:\Users\Admin\codebase\docker_images\20241226_1


Mode                 LastWriteTime         Length Name
----                 -------------         ------ ----
-a----        12/26/2024   7:37 AM            172 .env
-a----        12/26/2024   7:55 AM           1290 docker-compose.yml
-a----        12/26/2024   7:55 AM           1652 Dockerfile
-a----        12/26/2024   7:18 AM           1084 init.sql


PS C:\Users\Admin\codebase\docker_images\20241226_1> docker compose config
name: "20241226_1"
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
      POSTGRES_DB: postgres
      POSTGRES_HOST: postgres
      POSTGRES_PASSWORD: postgres
      POSTGRES_USER: postgres
    healthcheck:
      test:
        - CMD-SHELL
        - sh -c 'pg_isready -U postgres -d postgres'
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
        source: C:\Users\Admin\codebase\docker_images\20241226_1\init.sql
        target: /docker-entrypoint-initdb.d/init.sql
        bind:
          create_host_path: true
      - type: volume
        source: postgres
        target: /var/lib/postgresql/data
        volume: {}
  ubuntu:
    build:
      context: C:\Users\Admin\codebase\docker_images\20241226_1
      dockerfile: Dockerfile
    container_name: ubuntu
    environment:
      PGADMIN_DEFAULT_EMAIL: admin@pgadmin.com
      PGADMIN_DEFAULT_PASSWORD: password
      POSTGRES_DB: postgres
      POSTGRES_HOST: postgres
      POSTGRES_PASSWORD: postgres
      POSTGRES_USER: postgres
    networks:
      default: null
    ports:
      - mode: ingress
        target: 5433
        published: "5433"
        protocol: tcp
    volumes:
      - type: volume
        source: ubuntu
        target: /var/lib/postgresql/data
        volume: {}
networks:
  default:
    name: 20241226_1_default
volumes:
  pgadmin:
    name: 20241226_1_pgadmin
  postgres:
    name: 20241226_1_postgres
  ubuntu:
    name: 20241226_1_ubuntu
PS C:\Users\Admin\codebase\docker_images\20241226_1>

PS C:\Users\Admin\codebase\docker_images\20241226_1> docker compose build
[+] Building 0/1
 - Service ubuntu  Building                                                                                                                            0.5s
[+] Building 2.2s (12/12) FINISHED                                                                                                     docker:desktop-linux
 => [ubuntu internal] load build definition from Dockerfile                                                                                            0.0s
 => => transferring dockerfile: 1.69kB                                                                                                                 0.0s
 => [ubuntu internal] load metadata for docker.io/library/ubuntu:latest                                                                                2.1s
 => [ubuntu auth] library/ubuntu:pull token for registry-1.docker.io                                                                                   0.0s
 => [ubuntu internal] load .dockerignore                                                                                                               0.0s
 => => transferring context: 2B                                                                                                                        0.0s
 => [ubuntu 1/6] FROM docker.io/library/ubuntu:latest@sha256:80dd3c3b9c6cecb9f1667e9290b3bc61b78c2678c02cbdae5f0fea92cc6734ab                          0.0s
 => CACHED [ubuntu 2/6] RUN apt update && apt install -y     software-properties-common     git     build-essential     curl     wget     unzip     n  0.0s
 => CACHED [ubuntu 3/6] RUN wget https://services.gradle.org/distributions/gradle-8.12-bin.zip -P /tmp     && unzip -d /opt/gradle /tmp/gradle-8.12-b  0.0s
 => CACHED [ubuntu 4/6] RUN git --version     && gradle -v     && java -version     && javac -version                                                  0.0s
 => CACHED [ubuntu 5/6] RUN echo "host all all 0.0.0.0/0 trust" >> /etc/postgresql/16/main/pg_hba.conf  && echo "listen_addresses='*'" >> /etc/postgr  0.0s
 => CACHED [ubuntu 6/6] RUN mkdir -p /var/lib/postgresql/data && chown -R postgres:postgres /var/lib/postgresql                                        0.0s
 => [ubuntu] exporting to image                                                                                                                        0.0s
 => => exporting layers                                                                                                                                0.0s
 => => writing image sha256:e249a0a38dd8e55287b10432e0ec217c19667253eb0a67d6557201781445a7d1                                                           0.0s
[+] Building 1/1 docker.io/library/20241226_1-ubuntu                                                                                                   0.0s
 ✔ Service ubuntu  Built                                                                                                                               2.3s
PS C:\Users\Admin\codebase\docker_images\20241226_1>


PS C:\Users\Admin\codebase\docker_images\20241226_1> docker-compose up -d
[+] Running 32/2
 ✔ pgadmin Pulled                                                                                                                                                                                  23.0s 
 ✔ postgres Pulled                                                                                                                                                                                 23.3s 
[+] Running 7/7
 ✔ Network 20241226_1_default       Created                                                                                                                                                         0.0s 
 ✔ Volume "20241226_1_pgadmin"      Created                                                                                                                                                         0.0s 
 ✔ Volume "20241226_1_ubuntu"       Created                                                                                                                                                         0.0s 
 ✔ Volume "20241226_1_postgres"     Created                                                                                                                                                         0.0s 
 ✔ Container 20241226_1-postgres-1  Started                                                                                                                                                         1.4s 
 ✔ Container ubuntu                 Started                                                                                                                                                         1.3s 
 ✔ Container 20241226_1-pgadmin-1   Started                                                                                                                                                         1.0s 
PS C:\Users\Admin\codebase\docker_images\20241226_1>


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

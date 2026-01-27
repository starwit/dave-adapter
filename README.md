# dave-adapter
Adapter to get values from analytics database for traffic analysis in dave

## How to Build

__Prerequisites__ 

* Java JDK 21 or later
* Maven 3
* PostgreSQL (available for development via docker-compose scripts)
* Keycloak for authentication (optional)
* `vision-api` maven repository setup (see https://github.com/starwit/vision-api?tab=readme-ov-file#java--maven for guidance)

See section [neccessary infra](#run-necessary-infra) for how to run necessary components with Docker Compose.

In order to run a local development environment execute the following steps.
__Please note__: all steps need to be executed from base folder of repositories.

1) build the project

    ```bash
    mvn clean install
    ```

2) start project

    ```bash
    java -jar application/target/application-0.0.1-SNAPSHOT.jar
    ```

Once all steps ran successfully application will be reachable with the following coordinates:

* swagger under <http://localhost:8081/urbalytix/swagger-ui/>
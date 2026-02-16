# Dave Adapter
Adapter to get values from analytics database for traffic analysis in DAVe. It runs periodically and adds new data to a defined DAVe instance.

## Concept

In traffic statistics possible directions on intersections needs to be addressable unambiguously. 

In [DAVe](https://opensource.muenchen.de/de/software/dave.html) directions are defined as shown in the following table. Top side is pointing north. Following image shows an example for a configured intersection counting. 

![](doc/dave-directions.jpg)

The for active directions can then be mapped like so:
```json
[
  {
    "observationAreaId": "9", //id for data source
    "daveCountingId": "339f992e-0925-4f6d-9e75-099bc520ad2c", //id in DAVe 
    "intersectionMapping": {
        //map id strings to each activated intersection
        "dave-meckauer-nordost" : "1",
        "dave-meckauer-nordwest" : "2",
        "dave-meckauer-sued" : "3",
        "dave-meckauer-ost" : "4",
        "5" : "",
        "6" : "",
        "7" : "",
        "8" : ""
    }
  }
]
```


## How to Build

__Prerequisites__ 

* Java JDK 21 or later
* Maven 3
* PostgreSQL (available for development via docker-compose scripts)

See section [neccessary infra](#run-necessary-infra) for how to run necessary components with Docker Compose.

In order to run a local development environment execute the following steps.
__Please note__: all steps need to be executed from base folder of repositories.

1) build the project

    ```bash
    mvn clean install
    ```

2) start project

    ```bash
    java -jar target/dave-adapter-0.0.1-SNAPSHOT.jar
    ```

Once all steps ran successfully application will be reachable with the following coordinates:

* swagger under <http://localhost:8088/swagger-ui/>
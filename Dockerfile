FROM maven:latest
WORKDIR /app

COPY pom.xml /app/

COPY . /app/

RUN mvn package

ENTRYPOINT ["java", "-jar", "target/tripcostcalculator.jar"]
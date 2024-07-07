FROM maven:3.8.5-openjdk-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean install

FROM openjdk:17
WORKDIR /app
COPY --from=build /app/target/credential-service-1.0.jar /app/credential-service.jar
ENTRYPOINT ["java", "-jar", "credential-service.jar"]

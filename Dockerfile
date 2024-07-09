# Use an official Maven image to run Maven commands
FROM maven:3.8.1-openjdk-11 AS build

# Set the working directory
WORKDIR /app

# Copy the pom.xml file and the source code
COPY pom.xml .
COPY src ./src

# Use build arguments for GitHub credentials
ARG GITHUB_USERNAME
ARG GITHUB_TOKEN

# Replace placeholders in the settings.xml with the credentials
RUN sed -i 's/\${env.GITHUB_USERNAME}/'"$GITHUB_USERNAME"'/g' /root/.m2/settings.xml && \
    sed -i 's/\${env.GITHUB_TOKEN}/'"$GITHUB_TOKEN"'/g' /root/.m2/settings.xml

# Build the project and package it
RUN mvn clean package

# Deploy the package to GitHub Packages
RUN mvn deploy -Dusername=${GITHUB_USERNAME} -Dpassword=${GITHUB_TOKEN}

# Use a minimal base image
FROM openjdk:11-jre-slim

# Set the working directory
WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=build /app/target/credential-service-0.0.13-SNAPSHOT.jar /app/credential-service.jar

# Expose the port the app runs on
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "/app/credential-service.jar"]

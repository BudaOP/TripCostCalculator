# Stage 1: Build the application using Maven
FROM --platform=linux/amd64 maven:3.9.6-eclipse-temurin-21 AS build

WORKDIR /app

# Copy project files
COPY pom.xml . 
COPY src ./src

# Build the project (skip tests to speed up the build)
RUN mvn clean package -DskipTests

# Stage 2: Create a lightweight Java runtime container
FROM openjdk:21-jdk-slim

WORKDIR /app

# Copy only the built JAR file from the first stage
COPY --from=build /app/target/tripcalaculator.jar app.jar

# Expose application port (Change to 8081 if needed)
EXPOSE 8081

# Run the application
ENTRYPOINT ["java", "-jar", "/app/tripcalaculator.jar"]


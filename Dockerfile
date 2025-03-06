# Stage 1: Build the application using Maven
FROM maven:3.8.5 AS build

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

# Expose application port
EXPOSE 8080

# Set entrypoint to run the application
ENTRYPOINT ["java", "-jar", "tripcalaculator.jar"]

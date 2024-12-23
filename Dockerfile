# Use the official Maven image to build the project
FROM maven:3.8.6-openjdk-17-slim AS build

# Set the working directory inside the container
WORKDIR /app

# Copy the pom.xml and the src directory to the container
COPY pom.xml .
COPY src ./src

# Build the Spring Boot application using Maven
RUN mvn clean package -DskipTests

# Use the OpenJDK image to run the Spring Boot application
FROM openjdk:17-jdk-slim

# Set the working directory in the new container
WORKDIR /app

# Copy the JAR file from the build stage to the new container
COPY --from=build /app/target/*.jar app.jar

# Expose port 8080 for the Spring Boot application
EXPOSE 8080

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "/app/app.jar"]

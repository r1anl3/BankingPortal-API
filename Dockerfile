# ---- Stage 1: Build using Maven ----
FROM docker.io/maven:3.9-eclipse-temurin-17 AS builder

# Set working directory inside container
WORKDIR /app

# Copy pom.xml and download dependencies (cache optimization)
COPY pom.xml .
COPY .mvn .mvn
RUN mvn dependency:go-offline

# Copy source code
COPY src ./src

# Package the application
RUN mvn clean package -DskipTests
# ---- Stage 2: Run with JRE only ----
FROM docker.io/openjdk:11-jre-slim
# Set working directory
WORKDIR /app

# Copy the jar from the build stage
COPY --from=builder /app/target/*.jar app.jar

# Expose port (default Spring Boot)
EXPOSE 8180

# Run the app
ENTRYPOINT ["java", "-jar", "app.jar"]


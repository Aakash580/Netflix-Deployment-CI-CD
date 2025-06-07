# Build stage
FROM maven:3.9.5-eclipse-temurin-17 AS builder

WORKDIR /app

# Copy source code and build
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Runtime stage
FROM eclipse-temurin:17-jre

WORKDIR /app

# Copy built JAR file
COPY --from=builder /app/target/*.jar app.jar

# Expose the port your app uses
EXPOSE 3000

# Run the app
ENTRYPOINT ["java", "-jar", "app.jar"]

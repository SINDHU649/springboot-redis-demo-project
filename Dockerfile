# Use OpenJDK 17 as base image
FROM eclipse-temurin:17-jdk-alpine

# Set working directory
WORKDIR /app

# Copy Maven build files
COPY target/springboot-redis-demo.jar app.jar

# Expose port 8084
EXPOSE 8084

# Run the jar
ENTRYPOINT ["java", "-jar", "app.jar"]

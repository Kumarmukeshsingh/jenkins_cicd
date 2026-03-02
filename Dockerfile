# Step 1: Use an official JDK image to build the app
FROM eclipse-temurin:17-jdk-alpine AS build

# Set working directory
WORKDIR /app

# Copy project files
COPY . .

# Build the application (Maven example)
RUN ./mvnw clean package -DskipTests

# Step 2: Use a lightweight JRE image for running the app
FROM eclipse-temurin:17-jre-alpine

# Set working directory
WORKDIR /app

# Copy the built JAR from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose application port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java","-jar","app.jar"]

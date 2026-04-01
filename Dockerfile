# Build stage
FROM openjdk:21-jdk-slim AS builder
WORKDIR /app
COPY .mvn/ .mvn/
COPY mvnw pom.xml ./
RUN ./mvnw dependency:go-offline
COPY src ./src
RUN ./mvnw clean package -DskipTests

# Run stage
FROM openjdk:21-jdk-slim
WORKDIR /app
COPY --from=builder /app/target/springboot-cicd-github-actions.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]

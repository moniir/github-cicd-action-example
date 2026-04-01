# Spring Boot CI/CD with GitHub Actions

A hands-on project demonstrating a complete CI/CD pipeline for a Spring Boot application using GitHub Actions and Docker.

## What This Project Does

Every push or pull request to the `master` branch automatically:

1. Checks out the source code
2. Sets up JDK 21 (Eclipse Temurin) with Maven dependency caching
3. Builds the Spring Boot JAR using Maven
4. Builds a Docker image using the pre-built JAR
5. Pushes the Docker image to Docker Hub with two tags:
   - `latest`
   - The commit SHA (for traceability)
6. Submits the dependency graph to GitHub for Dependabot alerts

## Tech Stack

- **Java 21** — Spring Boot application
- **Maven** — Build tool
- **Docker** — Containerization (`eclipse-temurin:21-jre-jammy`)
- **GitHub Actions** — CI/CD pipeline
- **Docker Hub** — Container registry

## Project Structure

```
├── src/                        # Spring Boot application source
├── Dockerfile                  # Container image definition
├── .github/
│   └── workflows/
│       └── maven.yml           # CI/CD pipeline definition
└── pom.xml                     # Maven build configuration
```

## GitHub Actions Pipeline

```
push/PR to master
       │
       ▼
  Checkout code
       │
       ▼
  Setup JDK 21
       │
       ▼
  mvn clean package
       │
       ▼
  Docker build & push ──► moniir/springboot-cicd-github-actions:latest
                     └──► moniir/springboot-cicd-github-actions:<sha>
```

## Required GitHub Configuration

### Repository Secret
| Name | Description |
|---|---|
| `DOCKERHUB_TOKEN` | Docker Hub access token |

### Repository Variable
| Name | Value |
|---|---|
| `DOCKERHUB_USERNAME` | Your Docker Hub username |

> To set these: **Settings → Secrets and variables → Actions**

## Running Locally with Docker

```bash
# Pull the latest image
docker pull moniir/springboot-cicd-github-actions:latest

# Run the container
docker run -p 8080:8080 moniir/springboot-cicd-github-actions:latest
```

Then visit: http://localhost:8080/welcome

## Running Locally with Maven

```bash
./mvnw spring-boot:run
```

Then visit: http://localhost:8080/welcome

# ---- Stage 1: build the JAR with the full JDK ----
FROM eclipse-temurin:25-jdk-alpine AS build
WORKDIR /app

# Copy the Maven wrapper and pom first so dependencies are cached
# between builds when only source code changes
COPY mvnw pom.xml ./
COPY .mvn .mvn
RUN chmod +x mvnw && ./mvnw dependency:go-offline -B

# Copy the source and build (tests skipped: they'd need a database)
COPY src src
RUN ./mvnw package -DskipTests -B

# ---- Stage 2: run it with a smaller JRE-only image ----
FROM eclipse-temurin:25-jre-alpine
WORKDIR /app
COPY --from=build /app/target/*.jar app.jar

# No port or secrets here: Render sets PORT and SPRING_DATASOURCE_URL,
# and application.properties reads PORT via server.port=${PORT:8080}
ENTRYPOINT ["java", "-jar", "app.jar"]

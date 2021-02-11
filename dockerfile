FROM maven:3.5.2-jdk-8-alpine AS MAVEN_ENV
WORKDIR /build/
COPY pom.xml /build
COPY src /build/src
RUN mvn clean package -DskipTests=true

FROM openjdk:13-jdk-alpine3.10
COPY  --from=MAVEN_ENV /build/target/demo-*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
FROM maven:3.5.2-jdk-14-alpine AS MAVEN_ENV
WORKDIR /build/
COPY pom.xml /build
COPY src /build/src
RUN mvn clean package -DskipTests=true

FROM openjdk:14.0-jdk-buster
COPY  --from=MAVEN_ENV /build/target/demo-0.0.1-SNAPSHOT-*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
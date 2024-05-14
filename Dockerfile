FROM openjdk:11-jre-slim

WORKDIR /app

COPY target/maven-demo-one-1.0.0.jar .

CMD ["java", "-jar", "maven-demo-one-1.0.0.jar"]

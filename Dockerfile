# You can change this base image to anything else
# But make sure to use the correct version of Java
FROM openjdk:11-jre-slim

# Simply the artifact path
#ARG artifact=target/maven-demo.jar

WORKDIR /app

COPY target/maven-demo.jar .

CMD ["java", "-jar", "maven-demo.jar"]

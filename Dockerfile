# You can change this base image to anything else
# But make sure to use the correct version of Java
FROM adoptopenjdk/openjdk11:alpine-jre

# Simply the artifact path
#ARG artifact=target/maven-demo.jar

WORKDIR /app

COPY target/maven-demo.jar .

CMD ["java", "-jar", "maven-demo.jar"]

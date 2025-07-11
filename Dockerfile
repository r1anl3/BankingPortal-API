FROM image-registry.openshift-image-registry.svc:5000/openshift/java:openjdk-11-ubi8
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "/app.jar"]

FROM openjdk:8-jre-alpine
WORKDIR /app
COPY app/build/libs/*.jar app.jar
CMD ["java", "-jar", "app.jar"]

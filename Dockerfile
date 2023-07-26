# Dockerfile Spring
# build environment
FROM openjdk:17-jdk-slim as build
COPY src /home/app/src
COPY pom.xml /home/app
COPY mvnw /home/app
COPY .mvn /home/app/.mvn
RUN /home/app/./mvnw -f /home/app/pom.xml clean package
ENV PORT 8080

# production environment
FROM openjdk:17-jdk-slim
COPY --from=build /home/app/target/*.jar /usr/local/lib/webapp.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/local/lib/webapp.jar"]

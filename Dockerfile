# Pull base image 
FROM openjdk:17
EXPOSE 8080
ADD target/demo-SNAPSHOT-1.jar hello-world.jar
ENTRYPOINT ["java","-jar","/hello-world.jar"]
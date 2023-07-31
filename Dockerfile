# Pull base image 
FROM openjdk:17
#FROM mintya/jre17-alpine:3.15.0
#FROM nginx
EXPOSE 8081
ADD target/demo-SNAPSHOT-1.war hello-world.war
ENTRYPOINT ["java","-jar","/hello-world.war"]

FROM maven:3.8.6-amazoncorretto-17
WORKDIR /app
COPY ./app/pom.xml .
COPY ./app/src ./src
EXPOSE 8080
CMD ["mvn", "clean", "spring-boot:run"]
# Етап 1: Збірка (Build Stage)
# Беремо образ з Maven та Java 21 для того, щоб зібрати наш проект
FROM maven:3.9.6-eclipse-temurin-21 AS build
WORKDIR /app
# Копіюємо всі файли проекту в контейнер
COPY . .
# Запускаємо збірку .jar файлу, пропускаючи тести (тести ми проженемо окремо в Jenkins)
RUN mvn clean package -DskipTests

# Етап 2: Запуск (Runtime Stage)
# Тепер беремо дуже легкий образ лише з Java (без Maven), щоб наш фінальний образ був маленьким
FROM eclipse-temurin:21-jre-alpine
WORKDIR /app
# Копіюємо тільки готовий .jar файл з першого етапу
COPY --from=build /app/target/*.jar app.jar
# Відкриваємо порт 8080
EXPOSE 8080
# Команда для запуску додатка
ENTRYPOINT ["java", "-jar", "app.jar"]
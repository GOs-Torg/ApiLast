# Этап 1: Стадия сборки
FROM ubuntu:latest AS build

# Установка зависимостей, Java и Maven
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk maven && \
    apt-get clean;

# Установка MySQL
RUN apt-get update && \
    apt-get install -y mysql-server && \
    apt-get clean;

# Установка пароля для root пользователя
RUN echo "mysql-server mysql-server/root_password password 123" | debconf-set-selections && \
    echo "mysql-server mysql-server/root_password_again password 123" | debconf-set-selections

# Запуск MySQL сервера и открытие порта 3306
RUN service mysql start && \
    mysql -uroot -p123 -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY '123'; FLUSH PRIVILEGES;" && \
    service mysql restart

# Установка рабочей директории
WORKDIR /app

# Копирование файлов проекта Maven и сборка приложения
COPY . .

# Сборка приложения с помощью Maven
RUN mvn clean package

# Этап 2: Стадия выполнения
FROM openjdk:17-jdk-slim

# Открытие порта 8080 (предполагается, что ваше приложение слушает на этом порту)
EXPOSE 27004

# Установка рабочей директории
WORKDIR /app

# Копирование собранного JAR-файла из стадии сборки
COPY --from=build /app/target/*.jar app.jar



# Команда для запуска приложения
ENTRYPOINT ["java", "-jar", "app.jar"]
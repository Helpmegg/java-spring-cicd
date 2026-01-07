pipeline {
    agent any

    stages {
        stage('1. Checkout') {
            steps {
                // Завантажуємо код з  репозиторію
                checkout scm
            }
        }

        stage('2. Build & Test') {
            steps {
                // Надаємо права для викоання Maven
                sh 'chmod +x mvnw'
                // Запускаємо Maven для збірки та тестування
                // Використовуємо ./mvnw (Maven Wrapper)
                sh './mvnw clean package'
            }
        }

        stage('3. Docker Build') {
            steps {
                // Створюємо Docker-образ на основі нашого Dockerfile
                sh 'docker build -t java-app-diploma:latest .'
            }
        }

        stage('4. Run Container') {
            steps {
                // Зупиняємо старий контейнер, якщо він був, і запускаємо новий
                sh 'docker stop my-running-app || true'
                sh 'docker rm my-running-app || true'
                sh 'docker run -d --name my-running-app -p 8081:8080 java-app-diploma:latest'
            }
        }
    }
}
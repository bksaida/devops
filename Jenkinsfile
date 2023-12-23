pipeline {
    agent any
    tools {
      nodejs 'nodejs'
    //   dockerTool 'docker'

    }

    stages {
        stage('Clone') {
            steps {
                echo 'Cloning the repo'
                git branch: 'main', url: 'https://github.com/Chamssiddine/rdenewdocumentation.git'
            }
        }
        
        stage('Npm Install') {
            steps {
                nodejs('nodejs') {
                    npm 'install'
                }
            }
        }
        stage('Quality Gate') {
            steps {
                   withSonarQubeEnv(credentialsId: 'sonarqube token',installationName: 'sonar') {
                        nodejs('nodejs') {
                            sh 'sonar-scanner -Dsonar.projectKey=doc -Dsonar.sources=. -Dsonar.host.url=http://localhost:9000/ -Dsonar.login=sqp_95dc8e4c7edb94a8ac16ca65b430c33e48e51802'
                        }
                
            }
        }
        stage('SonarQube analysis') {
        environment {
            scannerHome = tool 'SonarQube_4.3.0'
        }
        steps {
            withSonarQubeEnv('Scanner') {
                sh '''
                ${scannerHome}/bin/sonar-scanner \
                -D sonar.projectKey=doc \
                -D sonar.projectName=doc \
                -D sonar.sources=./src \
                -Dsonar.host.url=http://localhost:9000/ \
                -Dsonar.login=sqp_95dc8e4c7edb94a8ac16ca65b430c33e48e51802
                '''
            }
        }
    }
        }
        stage('npm run build') {
            steps {
                nodejs('nodejs') {
                    npm 'run build'
                }
            }
        }
 

    }
}
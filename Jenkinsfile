pipeline {
    parameters {
        string(name: 'imageName', defaultValue: 'documentation', description: 'Name of the Docker image')
        string(name: 'imageTag', defaultValue: '2013.1.9', description: 'Tag for the Docker image (format: year.month.hotfix)')
    }

    agent any
    tools {
        nodejs 'nodejs'
        dockerTool 'docker'
    }

    environment {
        def registryUrl = 'localhost:8087'
        def fullImageName = "${registryUrl}/${params.imageName}:${params.imageTag}"
    }

    stages {
        stage('Validate Image Tag') {
            steps {
                script {
                    // Define the expected format for the imageTag (year.month.hotfix)
                    def regexPattern = /^[0-9]{4}\.[0-9]{1,2}\.[0-9]+$/
                    // image tag : 2023.1.9 
                    // Check if the imageTag matches the expected format
                    if (!(params.imageTag =~ regexPattern)) {
                        error "Invalid imageTag format. Please use the format: year.month.hotfix"
                    }
                }
            }
        }
/* 
        stage('Npm Install') {
            steps {
                sh 'npm install'
            }
        }

        stage('npm run build') {
            steps {
                sh 'npm run build'
            }
        } */
        stage('SonarQube Analysis') {
                environment {
                    SONAR_PROJECT_KEY = 'SonarProject'
                    SONAR_SOURCES_DIR = './src'
                    SONAR_HOST_URL = 'http://sonarqube:9000'
                }
                agent {
                    docker {
                        image 'sonarsource/sonar-scanner-cli'
                        args "-v /var/run/docker.sock:/var/run/docker.sock --network rdenewdocumentation-main_my_network"
                    }
                }
                steps {
                    withCredentials([string(credentialsId: 'sonarqubetoken', variable: 'SONAR_TOKEN')]) {
                        script {
                            sh """
                            sonar-scanner \\
                                -Dsonar.projectKey=${SONAR_PROJECT_KEY} \\
                                -Dsonar.sources=${SONAR_SOURCES_DIR} \\
                                -Dsonar.host.url=${SONAR_HOST_URL} \\
                                -Dsonar.token=${SONAR_TOKEN}
                            """
                        }
                    }
                }
                
        }
                        
        stage('docker build') {
            steps {
                sh "docker build -t ${fullImageName} --target=deploy ."
            }
        }

        stage('Docker Login') {
            steps {
                script {
                    // Your Nexus credentials ID
                    def nexusCredentialsId = 'nexuspwd'
                    // Docker registry URL
                    def registryUrl = 'localhost:8087'

                    // Docker login
                    withCredentials([usernamePassword(credentialsId: nexusCredentialsId, usernameVariable: 'NEXUS_USERNAME', passwordVariable: 'NEXUS_PASSWORD')]) {
                        sh "docker login  ${registryUrl} -u ${NEXUS_USERNAME} -p ${NEXUS_PASSWORD}"
                    }
                }
            }
        }

        stage('Docker Push') {
            steps {
                script {
                    // Docker push
                    sh "docker push ${fullImageName}"
                }
            }

        }
    }
}

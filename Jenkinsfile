pipeline {
    agent any
    tools {
      nodejs 'nodejs'
      dockerTool 'docker'

    }

    stages {    
        stage('Npm Install') {
            steps {
                  sh 'npm install'
            }
        }
        
        stage('npm run build') {
            steps {
                 sh '''
                 npm run build
                 '''
                
            }
        }
        stage('docker build'){
            steps{
                sh 'docker build -t documentcode:1.0.0 --target=deploy .'
            }
        }


       
         stage("deploying docker image to nexus") {
              steps {
                sh "docker login localhost:8087 -u admin -p nexus"
                sh "docker tag documentcode:1.0.0 localhost:8087/documentcode:1.0.0"
                sh "docker push  localhost:8087/documentcode:1.0.0"
                
              }
            }
    }
}
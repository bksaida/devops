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
                sh 'docker build -t documentcode:1.0.0 --target=deploy'
            }
        }
 
// --target=deploy
    }
}
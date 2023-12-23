pipeline {
    agent any
    tools {
      nodejs 'nodejs'
      dockerTool 'docker'

    }

    stages {
        
        stage('Npm Install') {
            steps {
                sh 'ls'
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
 

    }
}
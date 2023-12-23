pipeline {
    agent any
    tools {
      nodejs 'nodejs'
    //   dockerTool 'docker'

    }

    stages {
        
        stage('Npm Install') {
            steps {
                nodejs('nodejs') {
                   npm 'install'
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
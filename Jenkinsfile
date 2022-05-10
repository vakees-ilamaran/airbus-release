def status = true
node("ubuntu-vakees"){
    
    environment {
        if ( env.BRANCH_NAME == main) {
            tag = "latest" 
        } else {
            tag = "dev"
        }
    }
    stage('Preparation') { 
        sh "rm -rf * && \
            git clone -b ${env.BRANCH_NAME} https://github.com/vakees-ilamaran/airbus-release.git"
        if ( env.BRANCH_NAME == 'main' ) {
            currentBuild.description = "#${env.BUILD_NUMBER}, branch ${env.BRANCH_NAME}"
            echo 'The Official release is processing'
        } else {
            currentBuild.description = "#${env.BUILD_NUMBER}, branch ${env.BRANCH_NAME}"
            echo 'The development release is processing'
        }
    }
    stage('Building Docker Image') {
        // Build the docker image
        try { 
            dir("${env.WORKSPACE}/airbus-release") {
                docker.build("airbus-release:${env.tag}") 
            }
        } catch (exc) {
            echo "Docker build failed"
            status = false
        }
    }
    stage("Deploy"){
        try{
            dir("${env.WORKSPACE}/airbus-release") {
                ansiColor('xterm') {
                    if ( status == true ){
                        sh 'terraform init'
                        sh 'terraform plan'
                        sh 'terraform apply'
                    }
                    else {
                        echo "Deploy skipped due to failure in the previous steps"
                    }
                }
            }
        } catch (exc) {
            echo "Deployment failed"
        }
    }
}

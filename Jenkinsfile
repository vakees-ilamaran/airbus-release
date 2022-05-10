def status = true
node("ubuntu-vakees"){
    stage('Preparation') { 
        sh 'git clone -b ${env.BRANCH_NAME} https://github.com/vakees-ilamaran/airbus-release'
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
            def customImage = docker.build("airbus-release:latest") 
        } catch (exc) {
            echo "Docker build failed"
            status = false
        }
    }
    stage("Deploy"){
        try{
            if ( status == true ){
                sh 'terraform init'
                sh 'terraform plan'
                sh 'terraform apply'
            }
            else {
                echo "Deploy skipped due to failure in the previous steps"
            }
        } catch (exc) {
            echo "Deployment failed"
        }
    }
}

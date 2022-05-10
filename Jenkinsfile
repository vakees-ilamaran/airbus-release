def status = true
node("ubuntu-vakees"){
    def mvnHome
    stage('Preparation') { 
        if (env.BRANCH_NAME == 'main') {
            currentBuild.description = "#${BUILD_NUMBER}, branch ${BRANCH}"
            echo 'The Official release is processing'
        } else {
            currentBuild.description = "#${BUILD_NUMBER}, branch ${BRANCH}"
            echo 'The development release is processing'
        }
    }
    stage('Building Docker Image') {
        // Build the docker image
        try { 
            def customImage = docker.build("airbus-release:${env.BUILD_ID}") 
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
        }
    }
}

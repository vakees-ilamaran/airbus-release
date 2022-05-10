def status = true
node("ubuntu-vakees"){
    stage('Preparation') { 
        sh "rm -rf * && \
            git clone -b ${env.BRANCH_NAME} https://github.com/vakees-ilamaran/airbus-release.git"
        if ( env.BRANCH_NAME == 'main' ) {
            currentBuild.description = "#${env.BUILD_NUMBER}, branch ${env.BRANCH_NAME}"
            def tag = "latest"
            echo 'The Official release is processing'
        } else {
            currentBuild.description = "#${env.BUILD_NUMBER}, branch ${env.BRANCH_NAME}"
            def tag = "dev"
            echo 'The development release is processing'
        }
    }
    stage('Building Docker Image') {
        // Build the docker image
        try { 
            dir("${env.WORKSPACE}/airbus-release") {
                docker.build("airbus-release:${tag}") 
            }
        } catch (exc) {
            echo "Docker build failed"
            status = false
        }
    }
    withEnv(['TF_VAR_tag=${tag}']) {
    stage("Deploy"){
        try{
            dir("${env.WORKSPACE}/airbus-release") {
                ansiColor('xterm') {
                    if ( status == true ){
                        sh '''
                            terraform init
                            terraform plan
                            terraform apply --auto-approve
                            '''
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
}

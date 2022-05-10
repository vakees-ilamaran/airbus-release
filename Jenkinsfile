def status = true
def tag = "latest"
def port = 8081
if (env.BRANCH_NAME != 'main') {
    tag = "dev"
    echo "The development release is processing"
    port = 8082
} else {
    echo "The Official release is processing"
}

node("ubuntu-vakees"){
    stage('Preparation') { 
        currentBuild.description = "#${env.BUILD_NUMBER}, branch ${env.BRANCH_NAME}"
        sh "rm -rf * && \
            git clone -b ${env.BRANCH_NAME} https://github.com/vakees-ilamaran/airbus-release.git && \
            docker rm -f manager-${tag} && \
            docker rmi -f airbus-release:${tag}"
    }
    stage('Building Docker Image') {
        // Build the docker image
        try { 
            dir("${env.WORKSPACE}/airbus-release") {
                docker.build("airbus-release:${tag}", "-e PORT=${port}") 
            }
        } catch (exc) {
            echo "Docker build failed"
            status = false
        }
    }
    withEnv(["TF_VAR_tag=${tag}", "TF_VAR_port=${port}"]) {
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
                        echo "Deploy skipped due to image building failure"
                    }
                }
            }
        } catch (exc) {
            echo "Deployment failed"
        }
    }
    }
}

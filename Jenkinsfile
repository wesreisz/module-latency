#!groovy

pipeline {
  agent none
  options {
    skipDefaultCheckout true
  }
  stages {
    stage('Build and Push') {
      agent { label 'docker' }
      steps {
        dir ('delivery.kubernetes') {
          checkout([
            $class: 'GitSCM',
            branches: [[name: '*/version/new_perimeterx_build']],
            userRemoteConfigs: [[
              credentialsId: 'jenkins-github-delivery.kubernetes',
              url: 'git@github.com:section-io/delivery.kubernetes.git'
            ]]
          ])
        }
        dir ('perimeterx-module') {
          checkout scm
        }
        withCredentials([file(
            credentialsId: '5390e8c4-e92a-4d9c-96a9-efdaccbb4469', // gcr-push@section-io.iam.gserviceaccount.com
            variable: 'GCR_PUSH_KEY_FILE'
        )]) {
          sh 'bash delivery.kubernetes/ci/build-module-image-specifications.sh perimeterx-module'
        }
        archiveArtifacts artifacts: '**/*.build.log'
      }
    }
  }
}

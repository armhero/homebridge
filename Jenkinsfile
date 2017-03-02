#!groovy

node('armv7') {
  stage('Checkout') {
    checkout scm
  }

  stage('Build') {
    sh 'sudo docker build -t armhero/homebridge:\044{BRANCH_NAME} .'
  }

  stage('Push') {
    withCredentials([
      usernamePassword(credentialsId: '1d448f61-46d6-4af8-a517-9a06866447bb',
      passwordVariable: 'DOCKER_PASSWORD',
      usernameVariable: 'DOCKER_USERNAME')
    ]) {
      sh '''#!/bin/bash -xe
        sudo docker login -u \044{DOCKER_USERNAME} -p \044{DOCKER_PASSWORD}

        if [[ "\044{BRANCH_NAME}" == "master" ]]; then
          # when we are in the master branch, then set a new tag
          sudo docker tag armhero/homebridge:\044{BRANCH_NAME} armhero/homebridge:latest

          sudo docker push armhero/homebridge:latest
        else
          sudo docker push armhero/homebridge:${BRANCH_NAME}
        fi
      '''
    }
  }
}

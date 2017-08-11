#!/usr/bin/env groovy
import java.text.SimpleDateFormat

def gitCommit

pipeline {

    agent any

    environment {
        IMAGE_NAME = "yordex-ruby"
        REPO_URL = credentials('AWS_REPO_URL')
        CURRENT_JOB = ""
    }

    stages {
        stage('Checkout') {
            steps {
                sendNotifications 'STARTED'
                checkout scm
            }
        }

        stage('Get Git Commit') {
            steps {
                script {
                    gitCommit = sh(returnStdout: true, script: 'git rev-parse HEAD').trim().take(6)
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    def sdf = new SimpleDateFormat("EEE-d-MMM-yyyy(HH:mm:ss)")
                    def date = sdf.format(new Date())
                    CURRENT_JOB = "Build-" + env.BUILD_NUMBER + "-" + date
                }
                sh "docker build -t '${env.IMAGE_NAME}':v_'${env.BUILD_NUMBER}' ."
            }
        }

        stage('Tag Image') {
            steps {
                sh "docker tag '${env.IMAGE_NAME}':v_'${env.BUILD_NUMBER}' '${env.REPO_URL}'/'${env.IMAGE_NAME}':v_'${env.BUILD_NUMBER}'"
                sh "docker tag '${env.IMAGE_NAME}':v_'${env.BUILD_NUMBER}' '${env.REPO_URL}'/'${env.IMAGE_NAME}':v_'${gitCommit}'"
            }
        }

        stage('ECR Login') {
            steps {
                sh "'${JENKINS_HOME}'/aws_scripts/login.sh"
            }
        }

        stage('Push Image') {
            steps {
                sh "docker push '${env.REPO_URL}'/'${env.IMAGE_NAME}':v_'${env.BUILD_NUMBER}'"
                sh "docker push '${env.REPO_URL}'/'${env.IMAGE_NAME}':v_'${gitCommit}'"
            }
        }

        stage('Deploy') {
            steps {
                script {
                    println "\u001B[1;32m*****************************************************************************"
                    println "\u001B[1;32mDeploying docker Image"
                    println "\u001B[1;32m*****************************************************************************"
                    def workspace = pwd()

                    sh "bash -c \" source '${JENKINS_HOME}'/aws_scripts/ecsDeploy.sh \"handle-web\" \"${env.BUILD_NUMBER}\" " + "\"${workspace}\" \"Dev\" \"dev\" \"2\"\""
                    println "\u001B[1;32m*****************************************************************************"
                    println "\u2705 \u001B[1;32mDone"
                    println "\u001B[1;32m*****************************************************************************"
                }
            }
        }
    }

    post {
        always {
            sendNotifications currentBuild.result
        }
    }
}

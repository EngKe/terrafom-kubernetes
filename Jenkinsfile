pipeline {
    agent any

    stages {
        stage('Deploy') {
            steps {
                sh 'helm install postgresql bitnami/postgresql'
                sh 'kubectl port-forward --namespace default svc/postgresql 5432:5432 &'
        }
    }
}
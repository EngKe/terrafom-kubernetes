pipeline {
    agent any

    stages {
        stage('Deploy') {
            steps {
                sh 'helm install postgresql bitnami/postgresql'
                sh 'kubectl port-forward --namespace default svc/postgresql 5432:5432 &'
                sh 'helm install redis bitnami/redis'
                sh 'kubectl port-forward --namespace default svc/redis-master 6379:6379 &'
                sh '**********app deployed**********'
            }
        }
    }
}
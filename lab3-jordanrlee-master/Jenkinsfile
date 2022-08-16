// Jenkinsfile for CS 3030

//#################################################################
//   Students: Make absolutely no changes to this file whatsoever.
//#################################################################

pipeline {
	agent {
        node { label 'ubuntuvps' }
	}

	stages {
		stage('Test') {
			steps {
				sh 'cs3030'
			}
		}
	}
}


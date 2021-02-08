pipeline {
    agent any
    stages {
        stage('Create target folder') {
            steps {
                sh "mkdir build/mov"
            }
        }
        stage('Build target') {
            steps {
                sh "xcodebuild -workspace Ligup.xcworkspace -scheme mov archive -sdk iphoneos -archivePath build/mov/mov.xcarchive | xcpretty"
            }
        }
        stage('Archive target') {
            steps {
                sh "xcodebuild -exportArchive -archivePath build/$client/$client.xcarchive -allowProvisioningUpdates -exportOptionsPlist build/exportOptions.plist -exportPath build/$client | xcpretty"
            }
        }
        stage('Fix archive name') {
            steps {
                sh "for f in build/mov/*.ipa; do mv "$f" "build/mov/ipa.ipa"; done"
            }
        }
        stage('Upload to the store') {
            steps {
                sh "xcrun altool --upload-app -f "build/mov/ipa.ipa" -u concrete@concrete.com -p conc-rete-pass-word"
            }
        }
    }
}

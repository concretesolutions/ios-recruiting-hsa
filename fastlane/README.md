fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
## iOS
### ios unit_test
```
fastlane ios unit_test
```
Runs all the unit tests
### ios ui_test
```
fastlane ios ui_test
```
Runs all the UI tests
### ios beta
```
fastlane ios beta
```
Submit a new Beta Build to Apple TestFlight
### ios create_temporary_keychain
```
fastlane ios create_temporary_keychain
```


----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).

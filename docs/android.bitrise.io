---
format_version: '5'
default_step_lib_source: https://github.com/bitrise-io/bitrise-steplib.git
project_type: fastlane
app:
  envs:
  - opts:
      is_expand: false
    FASTLANE_WORK_DIR: android
  - opts:
      is_expand: false
    FASTLANE_LANE: android test
  - opts:
      is_expand: false
    GITHUB_USER_NAME: CI-AND
  - opts:
      is_expand: false
    GITHUB_USER_EMAIL: redcom@gmail.com
  - opts:
      is_expand: false
    TEST_PLATFORM: Android
trigger_map:
- push_branch: master
  workflow: primary-master
- push_branch: feature/*
  workflow: test-branches
- pull_request_source_branch: "*"
  workflow: primary-master
- tag: release/*
  workflow: release-tag
workflows:
  primary-master:
    steps:
    - activate-ssh-key@3.1.1:
        run_if: '{{getenv "SSH_RSA_PRIVATE_KEY" | ne ""}}'
    - git-clone@4.0.11: {}
    - file-downloader@1.0.1:
        title: Download keystore file
        inputs:
        - destination: "$ANDROID_RELEASE_STORE_FILE"
        - source: "$BITRISEIO_ANDROID_KEYSTORE_URL"
    - file-downloader@1.0.1:
        title: Download JSON file
        inputs:
        - source: "$BITRISEIO_JSON_SECRET_URL"
        - destination: "$GOOGLE_JSON_SECRET_KEY"
    - cache-pull@2.0.1: {}
    - install-react-native@0.9.1: {}
    - yarn@0.0.7: {}
    - fastlane@2.3.12:
        inputs:
        - lane: "$FASTLANE_LANE"
        - work_dir: "$FASTLANE_WORK_DIR"
        title: fastlane build upload to saucelabs
    - script@1.1.5:
        inputs:
        - content: |-
            #!/usr/bin/env bash
            # fail if any commands fails
            set -e
            # debug log
            set -x


            echo "I am staring tests on android"
            yarn test:e2e:saucelabs
        title: Run Test on Android
    - fastlane@2.3.12:
        inputs:
        - work_dir: "$FASTLANE_WORK_DIR"
        - lane: hockeyApp --env stage release:beta
        title: fastlane release beta to HockeyApp
    - script@1.1.5:
        inputs:
        - content: |-
            #!/usr/bin/env bash
            # fail if any commands fails
            set -e
            # debug log
            set -x

            git push origin HEAD:$BITRISE_GIT_BRANCH
        title: update repository
    - cache-push@2.0.5: {}
  test-branches:
    steps:
    - activate-ssh-key@3.1.1:
        run_if: '{{getenv "SSH_RSA_PRIVATE_KEY" | ne ""}}'
    - git-clone@4.0.11: {}
    - file-downloader@1.0.1:
        title: Download keystore file
        inputs:
        - destination: "$ANDROID_RELEASE_STORE_FILE"
        - source: "$BITRISEIO_ANDROID_KEYSTORE_URL"
    - file-downloader@1.0.1:
        title: Download JSON file
        inputs:
        - source: "$BITRISEIO_JSON_SECRET_URL"
        - destination: "$GOOGLE_JSON_SECRET_KEY"
    - cache-pull@2.0.1: {}
    - install-react-native@0.9.1: {}
    - yarn@0.0.7: {}
    - fastlane@2.3.12:
        inputs:
        - lane: "$FASTLANE_LANE"
        - work_dir: "$FASTLANE_WORK_DIR"
        title: fastlane build and  upload saucelab
    - script@1.1.5:
        inputs:
        - content: |-
            #!/usr/bin/env bash
            # fail if any commands fails
            set -e
            # debug log
            set -x


            echo "I am staring tests on android"
            yarn test:e2e:saucelabs
        title: Run Test on Android
    - cache-push@2.0.5: {}
  release-tag:
    steps:
    - activate-ssh-key@3.1.1:
        run_if: '{{getenv "SSH_RSA_PRIVATE_KEY" | ne ""}}'
    - git-clone@4.0.11: {}
    - file-downloader@1.0.1:
        title: Download keystore file
        inputs:
        - destination: "$ANDROID_RELEASE_STORE_FILE"
        - source: "$BITRISEIO_ANDROID_KEYSTORE_URL"
    - file-downloader@1.0.1:
        title: Download JSON file
        inputs:
        - source: "$BITRISEIO_JSON_SECRET_URL"
        - destination: "$GOOGLE_JSON_SECRET_KEY"
    - cache-pull@2.0.1: {}
    - install-react-native@0.9.1: {}
    - yarn@0.0.7: {}
    - fastlane@2.3.12:
        inputs:
        - lane: "$FASTLANE_LANE"
        - work_dir: "$FASTLANE_WORK_DIR"
        title: fastlane build and  upload apk
    - script@1.1.5:
        inputs:
        - content: |-
            #!/usr/bin/env bash
            # fail if any commands fails
            set -e
            # debug log
            set -x


            echo "I am staring tests on android"
            yarn test:e2e:saucelabs
        title: Run Test on Android
    - fastlane@2.3.12:
        inputs:
        - work_dir: "$FASTLANE_WORK_DIR"
        - lane: hockeyApp
        title: fastlane push to HockeyApp
    - script@1.1.5:
        inputs:
        - content: |-
            #!/usr/bin/env bash
            # fail if any commands fails
            set -e
            # debug log
            set -x

            git push origin HEAD:$BITRISE_GIT_BRANCH
        title: update repository
    - cache-push@2.0.5: {}
  release-master-alpha:
    steps:
    - activate-ssh-key@3.1.1:
        run_if: '{{getenv "SSH_RSA_PRIVATE_KEY" | ne ""}}'
    - git-clone@4.0.11: {}
    - file-downloader@1.0.1:
        title: Download keystore file
        inputs:
        - destination: "$ANDROID_RELEASE_STORE_FILE"
        - source: "$BITRISEIO_ANDROID_KEYSTORE_URL"
    - file-downloader@1.0.1:
        title: Download JSON file
        inputs:
        - source: "$BITRISEIO_JSON_SECRET_URL"
        - destination: "$GOOGLE_JSON_SECRET_KEY"
    - cache-pull@2.0.1: {}
    - install-react-native@0.9.1: {}
    - yarn@0.0.7: {}
    - fastlane@2.3.12:
        inputs:
        - lane: "$FASTLANE_LANE"
        - work_dir: "$FASTLANE_WORK_DIR"
        title: fastlane build and  upload apk
    - script@1.1.5:
        inputs:
        - content: |-
            #!/usr/bin/env bash
            # fail if any commands fails
            set -e
            # debug log
            set -x


            echo "I am staring tests on android"
            yarn test:e2e:saucelabs
        title: Run Test on Android
    - fastlane@2.3.12:
        inputs:
        - work_dir: "$FASTLANE_WORK_DIR"
        - lane: hockeyApp --env stage release:alpha
        title: fastlane release alpha to HockeyApp
    - script@1.1.5:
        inputs:
        - content: |-
            #!/usr/bin/env bash
            # fail if any commands fails
            set -e
            # debug log
            set -x

            git push origin HEAD:$BITRISE_GIT_BRANCH
        title: update repository
    - cache-push@2.0.5: {}

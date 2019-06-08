# NPM Library

This Jenkinsfile builds and publishes an Angular library. It leverages Docker as an ephemeral build environment and publishes to a private Artifactory repository using JFrog's awesome CLI.

You'll notice that the agent uses the `docker` directive which tells Jenkins to build inside of the chosen container. In this example, we leverage CircleCI's Node container which contains Chrome for unit testing. Karma was used to run the tests using `ChromeHeadless`.

## Permissions

To assist with permissions issues when communicating with the container using Jenkins, `-u root:root` is passed as an arg to the Docker container.

# NPM Library

## Topics Covered

- Building an Angular library.
- Using Docker as a build environment.
- Publishing to a private Artifactory repo via the JFrog CLI.
- Sending notifications to Slack.

## Walk-through

### Agent

The agent uses the `docker` directive which allows you to use Docker as an ephemeral build environment. In this example, we leverage CircleCI's Node container which contains Chrome for unit testing. This example was derived from a real-world example where Karma was used to run the tests using `ChromeHeadless`.

A `label` is not required, but helpful to ensure that Jenkins uses the appropriate node where Docker is available.

To assist with permissions issues, `-u root:root` is passed as an arg to the Docker container.

```groovy
agent {
  docker {
    image 'circleci/node:10.16.0-stretch-browsers'
    label 'linux-jenkins-node'
    args '-u root:root'
  }
}
```

### Environment

- `RT_AUTH` is assigned to the credentials method which grants us access to the stored username and password.
- `RT_URL` is set to the artifactory instance where your private repo is hosted.
- `JFROG_CLI_OFFER_CONFIG` is set to `false`. The JFrog CLI has a help feature for first-time users. However, this isn't very helpful in continuous integration, so you'll need to disable it.

```groovy
environment {
  // Credentials for the private repository.
  RT_AUTH = credentials('artifactory')
  // URL for the private artifactory server.
  RT_URL = 'https://artifactory.com'
  // The CLI prompts the user for input on first-run. This disables that
  // feature for CI pipelines.
  JFROG_CLI_OFFER_CONFIG = false
}
```

### Options

Retention is set in Jenkins to only keep the _last 5 builds_, a timeout is set for _30 minutes_, and timestamps are enabled in the Jenkins console logs.

### Stages

- **Stage(Prepare)** - In this example this stage is used to set the appropriate repository for the NPM package based on the branch name.
- **Stage(Install Dependencies)** - Here are pre-requisites for the build pipeline are met by installing the JFrog CLI, the Angular CLI, and our actual application. Additionally, you'll notice that we set the default user for the NPM CLI (`npm -g config set user root`). This is to avoid a permissions issue that arises when building in a container. In short, globally installed packages are installed as a user named `nobody`. Because we're running this container as `root`, we bump into an issue where some packages will fail when installed globally. This is discussed in greater length on [Stack Overflow](https://stackoverflow.com/questions/44633419/no-access-permission-error-with-npm-global-install-on-docker-image).
- **Stage(Build Application)** - This stage simply builds the library that we're wanting to publish.
- **Stage(Unit Test)** - Unit tests are executed against the library. In the original pipeline, the `karma-junit-reporter` plugin is used to generate the report. JUnit reports are natively supported by Jenkins and results can be captured using the `junit` method which is exactly what is implemented in this sample.
- **Stage(Publish)** - This stage only runs when the branch is set to `master` or `develop`. The JFrog CLI is used to publish the package to a private NPM repository.

### Post-Build

Finally, the build is cleaned up by the workspace. Pass/Fail alerts are sent to a Slack channel.

> Note: Cleaning up the workspace **does not** remove containers from the build node. Be sure to watch out for space consumption.

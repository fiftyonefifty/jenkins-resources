# Simple Docker Container

## Topics Covered

- Building a Docker Container in Jenkins.
- Publishing to a private Artifactory repo.
- Sending notifications to Slack.

## Walk-through

### Agent

The agent is defined using the label `linux&&docker`. This will select a Jenkins Node containing the labels `linux` and `docker`. There are many different ways to leverage Jenkins nodes.

### Environment

- `AUTH` - Uses the Jenkins credential store to obtain the username and password for the private docker repository. The credential store will provide you with two variables, `AUTH_USR` and `AUTH_PSW`.
- `APPLICATION_NAME` - This is used as the container name. It's recommend that you use all lowercase, with hyphens `(-)` as separators.
- `VERSION` - Semantic version numbers are preferred. Will be used as the version label.
- `RT_DOCKER_PROD` - The private repo name. Artifactory is used in this example.

### Options

Retention is set in Jenkins to only keep the _last 5 builds_, a timeout is set for _1 hour_, and timestamps are enabled in the Jenkins console logs.

### Stages

- **Stage(Prepare)** - In this example this stage is used to set a default repo name of `local`. This gets used with feature branches. When the branch is set to `master`, the production container repo is used.
- **Stage(Build Container)** - This stage builds the docker container using the versioned tag.
- **Stage(Publish Container)** - This stage only runs when the branch is set to `master`. It logs into the private repo (Artifactory in this example) and publishes two instances. It published the versioned container as well as a `latest` tag.

### Post-Build

Finally, the build is cleaned up by the workspace. Pass/Fail alerts are sent to a Slack channel.

> Note: Cleaning up the workspace **does not** remove containers from the build node. Be sure to watch out for space consumption.

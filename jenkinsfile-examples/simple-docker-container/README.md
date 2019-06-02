# Simple Docker Container

## Topics Covered

- Building a Docker Container in Jenkins.
- Publishing to a private Artifactory repo.
- Sending notifications to Slack.

## Walk-through

- **Agent** - The agent is defined using the label `linux&&docker`. This ensures that a Jenkins Node is used that contains the labels `linux` and `docker`.
- **Environment** - The environment block contains three variables; `AUTH`, `APPLICATION_NAME`, and `VERSION`. `AUTH` uses the Jenkins credential store to obtain the username and password for the private docker repository. `APPLICATION_NAME` and `VERSION` are used to define the container name and version tag. Feel free to replace this with any convention that meets your needs.
- **Options** - Retention is set in Jenkins to only keep the last **5** builds. Timestamps are also enabled in the Jenkins console logs.
- **Stage(Prepare)** - In this example this stage is used to set a default repo name of `local`. This gets used with feature branches. When the branch is set to `master`, the production container repo is used.
- **Stage(Build Container)** - This stage builds the docker container using the versioned tag.
- **Stage(Publish Container)** - This stage only runs when the branch is set to `master`. It logs into the private repo (Artifactory in this example) and publishes two instances. It published the versioned container as well as a `latest` tag.
- **Post** - Finally, we clean up by removing the workspace and send an alert to a Slack channel.

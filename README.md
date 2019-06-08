# Jenkins Resources

Jenkins is an incredibly helpful continuous integration system with many different ways to implement a build, or pipeline. And while there are some incredible alternatives, if you are working at a company that likes to keep their builds private, then you'll likely run in Jenkins.

The examples here are derived from real-world scenarios and serve as a great starting point for those of you using Jenkins pipelines to manage your application's builds.

Each example includes a README containing a brief description of the use case and any caveats.

## Topics

In addition to covering Jenkinsfiles and pipelines, these examples include:

- Artifactory
- Bitbucket (GIT)
- Docker
- Slack Integration

## Jenkinsfile Examples

All the examples in this repo leverage the Declarative Syntax. Where needed, you will see some script blocks which are also supported by declarative Jenkinsfiles.

- [Simple Dockerized App](jenkinsfile-examples/simple-docker-container/)
- [Angular NPM Library](jenkinsfile-examples/angular-npm-lib/)
- [Golang CLI with Dockerfile as a Build Env](jenkinsfile-examples/golang-cli-app/)

## Other Great Resources

- [Jenkins Pipeline Examples Github Repo](https://github.com/jenkinsci/pipeline-examples)
- [JFrog Examples Github Repo](https://github.com/jfrog/project-examples)
- [Jenkins Syntax Documentation](https://jenkins.io/doc/book/pipeline/syntax/)

# Golang CLI App

This pipeline is interesting in that it leverages a Dockerfile as the build environment. This is a really cool feature of Jenkins. By setting the node to a Dockerfile, Jenkins will first build the container and then start running the build inside of it.

Why do this? Well, this is excellent when you have a build that warrants a unique environment. In this example, we use this feature to create and use a `jenkins` user account in the container itself.

## GoReleaser

This build uses [GoReleaser](https://github.com/goreleaser/goreleaser) to generate the binaries. GoReleaser is a very powerful tool and can help with not just compilation, but distribution as well. While this repo doesn't take advantage of everything it has to offer, you should definitely check it out.

## A Note about the Imports

This Jenkinsfile leverages two libraries; `JsonBuilder` and `hudson.Util`. If you choose to use the Jenkinsfile, you will need to grant permissions in your Jenkins Master. They are only used for the Slack alerts so you could also omit them if you're not using the slack example seen here.

```groovy
import groovy.json.JsonBuilder
import hudson.Util
```

# This Dockerfile is used as the build environment in Jenkins.
# Typically, Docker containers expect the user to be 'root' by default which
# causes permission issues when running in Jenkins where permission for files
# are granted to the 'jenkins' user. That's what we're attempting to avoid.

FROM golang:1.11

ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000
ARG homedir=/home/jenkins

# Jenkins is run with user `jenkins`, uid = 1000
# If you bind mount a volume from the host or a data container,
# ensure you use the same uid
RUN mkdir -p ${homedir} \
  && chown -R ${uid}:${gid} ${homedir} \
  && groupadd -g ${gid} ${group} \
  && useradd -d "${homedir}" -u ${uid} -g ${gid} -m -s /bin/bash ${user}

USER ${user}
WORKDIR ${homedir}

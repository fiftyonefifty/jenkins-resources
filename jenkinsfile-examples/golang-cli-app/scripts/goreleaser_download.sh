#!/bin/sh
set -e

RELEASES_URL="https://artifactory.company.com/artifactory/third-party-bin/goreleaser"

download() {
  curl -O ${RELEASES_URL}
  ls -laF
}

download

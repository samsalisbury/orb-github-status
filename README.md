[![CircleCI](https://circleci.com/gh/samsalisbury/orb-github-status.svg?style=svg)](https://circleci.com/gh/samsalisbury/orb-github-status)

# CircleCI Orb: Custom GitHub Status Checks

A CircleCI orb to send simple GitHub status check results.

The current default CircleCI implementation
of GitHub status checks
only allows you to send a check for every job in a workflow, or none of them.
Using this orb, you can send custom status checks for individual jobs.
Which means you can structure your workflow in whichever way makes sense,
separately from considering which jobs should notify GitHub of changes.

This orb is published in the [CircleCI Orb Registry as github-status](https://circleci.com/orbs/registry/orb/samsalisbury/github-status)

## Usage

Usage is documented on the [github-status page](https://circleci.com/orbs/registry/orb/samsalisbury/github-status) in the CircleCI Orb Registry.

## Development

1. Edit the source file: orbs/github-status.yml
2. Run `make test`
3. When happy with the results, publish.

## Publishing

1. Add an annotated git tag in the format `M.m.p` (major, minor, patch semver fields).
   (You must not use a preceding `v`, and the tag must be annotated.)
2. Push this tag `git push origin M.m.p`
3. Run `make publish`.


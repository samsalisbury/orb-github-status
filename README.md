# CircleCI Orb: Custom GitHub Status Checks

A CircleCI orb to send simple GitHub status check results.

The current default CircleCI implementation
of GitHub status checks
only allows you to send a check for every job in a workflow, or none of them.
Using this orb, you can send custom status checks for individual jobs.
Which means you can structure your workflow in whichever way makes sense,
separately from considering which jobs should notify GitHub of changes.

This orb is published to https://circleci.com/orbs/registry/orb/samsalisbury/github-status

## Usage


# `veracode-pipeline`
> an example of a GitHub action for initiating a Veracode pipeline scan and returning the results.json as code scanning alerts in GitHub's Security tab

## Contents
- [About](#about)
- [How it works](#how-it-works)
- [Getting started](#getting-started)
- [Additional resources](#additional-resources)

## About
This is an example

## How it works
- The Veracode pipeline scan analysis workflow runs on commit, takes the artifact from your build and submits it to the Veracode pipeline scan service
- The results.json ouput is transformed into SARIF
- The SARIF report is submitted to GitHub via the [`github/codeql-action/upload-sarif`](https://github.com/github/codeql-action/tree/main/upload-sarif) action

## Getting started
1. Setup an API users for your Veracode account
2. Implement this action
3. Push a commit
4. Observe any results being represented as a security alert

## Additional resources
- ..

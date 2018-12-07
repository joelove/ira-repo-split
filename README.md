# Repo Split Scripts

A set of shell and Perl scripts to re-write Git commit history and re-wire Webpack.

## Pre-requisites

MacOS gets a very, _very_ old version of `sed`. We need something better.

```shell
brew install gnu-sed --with-default-names
```

## Starting the re-write

1. Open `repo-split.sh` and modify the `WORKING_DIR` and `REPO_NAME` variables to match your development environment. The working directory is the folder in which you want to clone the repository. The repository name is the name of the new repository in that folder.

2. Run `./repo-split.sh` from any folder (the script will use the working directory and repo name to ensure the magic happens in the right place).

## Building the application

Building the application after the re-write is simple, just install and run the build task. This can be done locally for testing purposes and will need to happen on the CI before deployment.

```shell
npm install
npm run build
```

Once this is complete, the production application will be available in the `dist/` folder.

```
- /dist
  - employee-portal.aspx
  - employee-portal.min.js
  - employee-portal.min.css
```

The `employee-portal.aspx` file will need to be served by the server. The build is self-contained so nothing else is required.

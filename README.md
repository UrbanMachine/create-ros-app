# create-ros-app

A template for creating robust ROS (Robot Operating System) applications, designed for large-scale, end-to-end robotics projects. This template is optimized for maintaining consistency and quality across multiple ROS packages and project components.

## What? Why?

When you build a robot, you have to juggle a **ton** of opinionated decisions before you so much as tell an actuator to move.

This template helps streamline the development of ROS applications by setting up a standardized project structure, tooling, and configuration for ROS packages, ensuring that every project starts with consistent settings and follows best practices. It also includes a centralized linting and testing setup to ensure code quality across packages.

## Features

The full documentation for the project features can be found in [about_template.md](%7B%7Bcookiecutter.project_name%7D%7D/docs/about_template.md)

- **Containerized ROS Environment**: The project only needs `docker` to run. You only need to know a few simple commands to launch your project. 
  - **Launch** specific ROS components or full stacks with `docker/launch`.
  - **Run** components in isolation using `docker/run`.
  - **Execute** commands within running containers using `docker/exec`.
  - **Test** all ROS packages with `docker/test`.
- **Logging Made Easy**: Projects come pre-configured with `grafana`, `loki` and `promtail`, so you can search and browse logs easily under `http://localhost` after launching.
- **Standardized ROS Project Structure**: Pre-organized packages under `pkgs.`
- **Launch and Configuration Structure**: The `launch-profiles/` directory lets you create separate ROS "apps" where launchfiles, configuration, model files can live in one place separate from the package code.
- **Dependencies are Organized**: ROS dependencies go in a `package.xml`, python dependencies go in the `pyproject.toml`, and the `Dockerfile` has a spot for apt dependencies.
- **Centralized Linting and Testing**: Enter `poetry shell` at the root of the project, and you can use the `lint` command which covers tooling for `python`, `C++`, and `JS` code.
- **GitHub Actions CI/CD**: Pre-configured workflows for continuous integration, including linting, testing, and optional Codecov integration to monitor code coverage.
- **Cruft Integration for Template Sync**: Ensures projects remain up-to-date with the latest template improvements, allowing the team to adopt new best practices with minimal effort.


## Quick Start Guide

### Adding the Template to an Existing Project

If you have an existing git repository and you want it to follow this template, 
use these instructions, start from **Step 1**. If you are starting a new project,
start from **Step 3**.

1. **Create a `template` branch:**
   ```shell
   git checkout --orphan template 
   ```
2. Clear files in this branch
   ```shell
   git reset --hard 
   ```
3. Install Cruft (if not already installed):

   This tool allows you to create projects from 'cookiecutter' repositories, such as this one. 
   ```shell
   pip install cruft
   ```
4. Initialize the template. This will create a new directory where the project files will
   be dumped.
   
   Fill in the form with the appropriate values for your project. The values in the 
   parameters are the default values that will be used if you don't fill in your own.
   ```shell
   cruft create git@github.com:UrbanMachine/create-ros-app.git
   ```
5. Add the generated files into the project directory and commit them to git.
6. Check that everything is synced with the template repository
   ```shell
   cruft check
   ```
7. Merge `template` into your `main` branch:

   You may need to use:
   ```shell
   git merge --allow-unrelated-histories
   ```
8. Delete the `template` branch
   
### Updating a Template on an Existing Project 
To pull in the latest template changes:
1.Run the following:
   ```shell
   cruft update --allow-untracked-files
   ```
2. Follow the prompts and resolve any merge conflicts that arise.

## Post Set-Up Guide
### Lock the Root pyproject.toml File

This project requires poetry for linting. You can get it [here](https://python-poetry.org/docs/). 

After adding the template to your project, you should lock the `pyproject.toml` file to ensure that all developers use the same dependencies. This file is generated by Poetry and should be committed to the repository. To lock the file, run:
```shell
poetry lock
```


Then commit the `pyproject.lock` file to the repository.

### Fixing the `lint` Github Action
This template automatically runs CI via github actions on every pull request. 

The CI uses cruft to check if there's been upstream changes on the template repository. If not
fixed, the lint action will fail because because `cruft` is unable to clone the template repo. 
Set up SSH keys as follows:

1. Generate an SSH Key
   ```shell
   ssh-keygen
   ```
2. Add the private key (`id_rsa`) to your Github repository's sectrets under the name `SSH_KEY`. Settings can be found under: 
   https://github.com/GITHUB_ORG/PROJECT_NAME/settings/secrets/actions

3. Add a public key (`id_rsa.pub`) to your repository's deploy keys on github. Settings can be found under: 
   https://github.com/GITHUB_ORG/PROJECT_NAME/settings/keys


### Optional: Adding Codecov Support
Codecov let's your project report on test coverage on every pull request. This process requires being an Admin on the github org this project lives in.

1. Sign in to [Codecov](https://about.codecov.io/sign-up/) with your Github account.
2. Under your repository in Codecov, select "Activate".
3. Get a codecov API token. Settings can be found under:
   https://app.codecov.io/gh/GITHUB_ORG/PROJECT_NAME/
4. Add a secret named `CODECOV_TOKEN` to your Github repositories secrets. Settings can be found under: 
   https://github.com/GITHUB_ORG/PROJECT_NAME/settings/secrets/actions
6. You should now be able to see code coverage under codecov!


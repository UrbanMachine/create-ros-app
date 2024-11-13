# create-ros-app

A template for creating robust ROS (Robot Operating System) applications, designed for large-scale, end-to-end robotics projects. This template is optimized for maintaining consistency and quality across multiple ROS packages and project components.

## Purpose

This template helps streamline the development of ROS applications by setting up a standardized project structure, tooling, and configuration for ROS packages, ensuring that every project starts with consistent settings and follows best practices. It also includes a centralized linting and testing setup to ensure code quality across packages.

## Features

- **Standardized ROS Project Structure**: Organizes packages under a unified `pkgs/` directory with separate dependency management per package, making it easy to develop, test, and deploy individual components.
- **Launch File Management**: Provides a recommended structure for organizing launch files, allowing for clear separation of configurations and ensuring consistent deployment setups.
- **Configuration Standardization**: Centralized location for configuration files, ensuring that all packages follow a consistent approach to setting parameters, environment variables, and ROS-specific configurations.
- **Containerized ROS Environment**: Includes a `docker/` directory with scripts for streamlined container management, allowing you to:
  - **Run** components in isolation using `docker/run`.
  - **Execute** commands within containers using `docker/exec`.
  - **Launch** specific ROS components or full stacks with `docker/launch`.
  This setup ensures consistent environments across development, testing, and deployment, reducing setup time and avoiding dependency conflicts.
- **Centralized Linting and Testing**: A `pyproject.toml` in the root directory handles linting and testing for all packages, enforcing quality standards and catching issues early across the entire project.
- **Code Quality Tools**:
  - *ruff* for comprehensive linting with rules for style, security, and common pitfalls.
  - *mypy* in strict mode for robust type checking.
  - *black* and *isort* for consistent formatting across the codebase.
- **Security Scanning**: Integrates *bandit* to catch potential security vulnerabilities, especially valuable for software handling robotics hardware.
- **GitHub Actions CI/CD**: Pre-configured workflows for continuous integration, including linting, testing, and optional Codecov integration to monitor code coverage.
- **Cruft Integration for Template Sync**: Ensures projects remain up-to-date with the latest template improvements, allowing the team to adopt new best practices with minimal effort.


## Quick Start Guide

### Adding the Template to an Existing Project

1. **Create a `template` branch:**
   ```shell
   git checkout --orphan template 
   ```
2. Clear files in this branch
   ```shell
   git reset --hard 
   ```
3. Install Cruft (if not already installed):
   ```shell
   pip install cruft
   ```
4. Initialize the template
   ```shell
   cruft create git@github.com:UrbanMachine/create-python-lib.git
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
### Adding Codecov Support
This process requires being an Admin on the github org.
1. Sign in to [Codecov](https://about.codecov.io/sign-up/) with your Github account.
2. Under your repository in Codecov, select "Activate".
3. Get a codecov API token. Settings can be found under:
   https://app.codecov.io/gh/UrbanMachine/PROJECT_NAME/
4. Add a secret named `CODECOV_TOKEN` to your Github repositories secrets. Settings can be found under: 
   https://github.com/UrbanMachine/PROJECT_NAME/settings/secrets/actions
6. You should now be able to see code coverage under codecov!

### Fixing the `lint` Github Action
`cruft` requires access to the upstream template repository for `lint` to function. If not
fixed, the lint action will fail because because `cruft` is unable to clone the template repo. 
Set up SSH keys as follows:

1. Generate an SSH Key
   ```shell
   ssh-keygen
   ```
2. Add the private key (`id_rsa`) to your Github repository's sectrets under the name `SSH_KEY`. Settings can be found under: 
   https://github.com/UrbanMachine/PROJECT_NAME/settings/secrets/actions

3. Add a public key (`id_rsa.pub`) to your repository's deploy keys on github. Settings can be found under: 
   https://github.com/UrbanMachine/PROJECT_NAME/settings/keys

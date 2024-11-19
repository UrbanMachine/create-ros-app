#!/usr/bin/env bash
# Shared functions used in multiple deployment scripts

PROJECT_NAME="{{cookiecutter.project_name}}"
BASE_IMAGE="ubuntu:24.04"

# Builds our Docker images
function build_images {
  docker compose build --build-arg BASE_IMAGE="${BASE_IMAGE}"
}

# Removes an existing Docker Compose deployment, if one exists
function undeploy {
  if is_stack_running; then
    echo "" >&2
    echo 'Waiting for robot stack to come down' >&2
    docker compose down
    while is_stack_running; do
      sleep 0.1
    done
    echo " done!" >&2
  fi
}

# Pulls necessary images for offline building and deployment
function pull_images {
  # Pull all the non-locally-built images
  docker compose pull grafana loki promtail

  # Pull the base images for (for image building purposes)
  # Doing this explicitly tags the base
  # image, preventing `docker build` from checking for updates itself. That
  # way, if the user chooses to skip this step, builds can be done offline.
  docker pull "${BASE_IMAGE}"
}

# Enables display passthrough of windows. Other passthrough (such as pulseaudio) can also
# be configured in this function.
function enable_display_passthrough {
  xhost +local:root
}

# This is automatically called when the user presses Ctrl+C. It will bring down the stack.
function _catch_sigint {
  trap '' INT
  undeploy
}

# Checks if the stack is running
function is_stack_running() {
    [ -n "$(docker compose ps --services)" ]
}

# Starts a Docker Compose deployment, and waits until the user presses Ctrl+C.
# Then, the stack will be brought down.
function deploy_and_wait {
  # Start the stack non-blockingly, because logs are best accessed via the web interface
  LAUNCH_PROFILE="${1}" docker compose up --detach

  trap _catch_sigint INT

  echo "" >&2
  echo "Deployment of '${PROJECT_NAME}' has started! Press Ctrl+C to stop." >&2
  echo "Logs are viewable at http://localhost/" >&2

  while is_stack_running; do
    sleep 1
  done
  echo "Another process brought down the stack." >&2
  return 1
}
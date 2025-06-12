#!/bin/bash

build_docker_images() {
  if ! command -v docker &> /dev/null; then
    echo "✗ Docker not found"
    echo "Please install Docker and try again"
    exit 1
  fi

  echo "✓ Docker already installed ($(docker --version))"

  local COMMAND
  COMMAND="docker-compose"
  $COMMAND version
  if [ $? -ne 0 ]; then
    COMMAND="docker compose"
  fi
  $COMMAND version
  if [ $? -ne 0 ]; then
    echo "✗ Docker Compose not found"
    echo "Please install Docker Compose and try again"
    exit 1
  fi

  echo "Would you like to build the Docker images? (y/n)"
  read -r response
  if [[ $response == "y" || $response == "Y" ]]; then
    echo "Building Docker images..."
    $COMMAND build
    if [ $? -ne 0 ]; then
      echo "✗ Docker image build failed"
      exit 1
    fi
    echo "✓ Docker images built"
    echo "You can run '$COMMAND up [-d]' to start the XKaliBurr"
  else
    echo "Skipping Docker image build"
    echo "You can run '$COMMAND build' to build the images later"
    echo "or run '$COMMAND up --build' to build and start the XKaliBurr"
  fi
}

setup_environment() {
  local editor
    if [ -n "$EDITOR" ]; then
      editor="$EDITOR"
    elif [ -n "$VISUAL" ]; then
      editor="$VISUAL"
    else
      for possible_editor in nano gedit code kate vim vi; do
        if command -v "$possible_editor" >/dev/null 2>&1; then
          editor="$possible_editor"
          break
        fi
      done

      if [ -z "$editor" ]; then
        echo "Error: No text editor found. Please install some editor or set the EDITOR variable with your preferred text editor."
        exit 1
      fi
    fi

  if [ ! -f front/.env ]; then
    echo "Creating .env file for front-end"
    cp front/.env.template front/.env

    echo "Please check its content and update the values as needed"
    echo "Press enter to continue..."
    read -r asw
    $editor front/.env
    echo "✓ .env file for front-end created at front/.env"
  else
    echo "✓ .env file for front-end already exists"
  fi

  if [ ! -f api/.env ]; then
    echo "Creating .env file for back-end"
    cp api/.env.template api/.env

    echo "Please check its content and update the values as needed"
    echo "Press enter to continue..."
    read -r asw
    $editor api/.env
    echo "✓ .env file for api created at front/.env"
  else
    echo "✓ .env file for api already exists"
  fi

  echo "Merging front-end and back-end .env files"
  rm .env
  cat api/.env >> .env

  echo "" >> .env
  cat front/.env >> .env

  echo "✓ .env file created"

  echo "✓ Environment setup completed"
}

print_header() {
  echo "__          __  _            _  __     _ _ _                            ___    ___"
  echo " \\ \\        / / | |          | |/ /    | (_) |                          |__ \\  / _ \\"
  echo "  \\ \\  /\\  / /__| |__   __  _| ' / __ _| |_| |__  _   _ _ __ _ __  __   __ ) || | | |"
  echo "   \\ \\/  \\/ / _ \\ '_ \\  \\ \\/ /  < / _\` | | | '_ \\| | | | '__| '__| \\ \\ / // / | | | |"
  echo "    \\  /\\  /  __/ |_) |  >  <| . \\ (_| | | | |_) | |_| | |  | |     \\ V // /_ | |_| |"
  echo "     \\/  \\/ \\___|_.__/  /_/\\_\\_|\\_\\__,_|_|_|_.__/ \\__,_|_|  |_|      \\_/|____(_)___/"
  echo ""
  echo "By round table team"
}

main() {
  print_header
  echo "setup with Docker"
  setup_environment
  build_docker_images
}

main

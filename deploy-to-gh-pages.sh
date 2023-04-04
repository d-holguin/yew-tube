#!/bin/sh

# Exit immediately if a command exits with a non-zero status.
set -e

if ! command -v trunk &> /dev/null; then
  echo "Trunk command not found. Please install it using 'cargo install trunk'."
  exit 1
fi

# Check if we're on the gh-pages branch.
if [ "$(git rev-parse --abbrev-ref HEAD)" != "gh-pages" ]; then
  # If not, create the gh-pages branch if it doesn't exist.
  if ! git show-ref --verify --quiet refs/heads/gh-pages; then
    if ! git branch gh-pages; then
      echo "Failed to create gh-pages branch"
      exit 1
    fi
  fi

  # Checkout the gh-pages branch.
  if ! git checkout gh-pages; then
    echo "Failed to checkout gh-pages branch"
    exit 1
  fi
fi


# Build the Yew application using Trunk
trunk build --release

# Remove old build files
rm -rf docs

# Create the docs directory if it doesn't exist
mkdir -p docs

# Copy the contents of the dist directory to the docs directory
cp -Rf dist/* docs

#Commit and push changes to the gh-pages branch.
git add .
git commit -m "Deploy to gh-pages"
git push origin gh-pages

# Checkout the previous branch.
git checkout -

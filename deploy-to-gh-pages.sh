#!/bin/sh

echo "This script will deploy to GitHub Pages. Are you sure you want to continue? (y/n)"
read answer

if [ "$answer" = "${answer#[Yy]}" ]; then
    echo "Aborted."
    exit 0
fi

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

# Set the TRUNK_CONFIG environment variable to use the release configuration
export TRUNK_CONFIG=trunk-release.toml

# Build the Yew application using trunk with the release configuration
trunk build --release

# Commit and push changes to the gh-pages branch.
git add .
git commit -m "Deploy to gh-pages"
git push origin gh-pages

echo "Finished deploying to gh-pages"

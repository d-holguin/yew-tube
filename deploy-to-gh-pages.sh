#!/bin/sh

# Exit immediately if a command exits with a non-zero status.
set -e

echo "This script will deploy to github pages. Are you sure you want to continue? (y/n)"
read answer

if [ !"$answer" != "${answer#[Yy]}" ]; then
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

# Remove the docs directory if it exists.
if [ -d "docs" ]; then
  rm -rf docs
fi

# Build the Yew application using trunk
trunk build --release

# Copy the index.html file to the docs directory
cp index.html docs/

# Create the .nojekyll file to disable Jekyll processing
touch docs/.nojekyll

# Commit and push changes to the gh-pages branch.
git add .
git commit -m "Deploy to gh-pages"
git push origin gh-pages

# Remove the docs directory
echo "Removing artifacts..."
#rm -rf docs
echo "Artifacts removed"
echo "Finished deploying to gh-pages"
else
    echo "Aborted."
fi
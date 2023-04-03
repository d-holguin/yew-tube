#!/bin/bash

# Build the Yew application
wasm-pack build --target web --release

# Check if the gh-pages branch exists
if ! git show-ref --quiet refs/heads/gh-pages; then
  # Create the gh-pages branch if it doesn't exist
  git branch gh-pages
fi

# Checkout gh-pages branch
git checkout gh-pages

# Copy the contents of the pkg directory to the docs directory
mkdir -p docs
cp -R pkg/* docs

# Commit the changes
git add .
git commit -m "Deploy to GitHub Pages"

# Switch back to the main branch
git checkout main

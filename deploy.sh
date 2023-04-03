#!/bin/bash

# Check if current branch is gh-pages
if [[ $(git symbolic-ref --short HEAD) != "gh-pages" ]]; then
  # Attempt to create gh-pages branch
  if ! git show-ref --quiet refs/heads/gh-pages; then
    git checkout -b gh-pages
  else
    git checkout gh-pages
  fi
fi

# Build the Yew application
wasm-pack build --target web --release

# Copy the contents of the pkg directory to the docs directory
mkdir -p docs
cp -R pkg/* docs

# Commit the changes
git add .
git commit -m "Deploy to GitHub Pages"

# Switch back to the main branch
git checkout -

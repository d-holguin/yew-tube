#!/bin/bash

# Check if current branch is main
if [[ $(git symbolic-ref --short HEAD) != "main" ]]; then
  echo "Error: current branch is not main"
  exit 1
fi

# Build the Yew application
wasm-pack build --target web --release

# Copy the contents of the pkg directory to the docs directory
mkdir -p docs
cp -R pkg/* docs

# Copy index.html to the docs directory
cp index.html docs/

# Commit the changes
git add .
git commit -m "Deploy to GitHub Pages"

# Push changes to remote main branch
git push origin main

#!/bin/bash

# Build the Yew application
wasm-pack build --target web --release

# Install the gh-pages command
npm install -g gh-pages

# Create a new branch named gh-pages
git checkout -b gh-pages-test

# Copy the contents of the pkg directory to the root directory
cp -R pkg/* .

# Copy the index.html file to the root directory
cp index.html .

# Commit the changes
git add .
git commit -m "Deploy to GitHub Pages"

# Deploy to GitHub Pages
gh-pages -d .

# Switch back to the main branch
git checkout main

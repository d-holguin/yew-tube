#!/bin/bash

# Check if current branch is main
if [[ $(git symbolic-ref --short HEAD) != "main" ]]; then
  echo "Error: current branch is not main"
  exit 1
fi

# Build the Yew application using Trunk
trunk build --release

# Remove the old docs folder
rm -rf docs

# Copy the contents of the dist directory to the docs directory
mkdir -p docs
cp -R dist/* docs

# Rename the generated files to match the expected names
js_file=$(find ./docs -name "yew-tube-converter-*.js")
wasm_file=$(find ./docs -name "yew-tube-converter-*_bg.wasm")
mv "$js_file" docs/yew-tube-converter.js
mv "$wasm_file" docs/yew-tube-converter_bg.wasm

# Create a .nojekyll file in the docs directory
touch docs/.nojekyll

# Commit the changes
git add .
git commit -m "Deploy to GitHub Pages"

# Push changes to remote main branch
git push origin main

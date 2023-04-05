#!/bin/sh

echo "This script will deploy to GitHub Pages. Are you sure you want to continue? (y/n)"
read answer

if [ "$answer" = "${answer#[Yy]}" ]; then
    echo "Aborted."
    exit 0
fi

# Check if the trunk command is available
if ! command -v trunk &> /dev/null; then
    echo "Error: trunk command not found. Please ensure Trunk is installed and available in your PATH."
    exit 1
fi

current_branch=$(git rev-parse --abbrev-ref HEAD)

if [ "$current_branch" != "gh-pages" ]; then
    echo "You are not on the gh-pages branch. Please switch to the gh-pages branch before deploying."
    exit 1
else
    echo "You are on the gh-pages branch. Proceeding with the deployment..."
fi

config_file="trunk-gh-pages.toml"

# Check if the trunk-gh-pages.toml file exists
if [ ! -f "$config_file" ]; then
    echo "Error: $config_file not found."
    exit 1
fi

# Set the TRUNK_CONFIG environment variable to use the gh-pages configuration
export TRUNK_CONFIG=$config_file

# Build the Yew application using trunk with the release configuration
trunk build --release

# Commit and push changes to the gh-pages branch.
echo "Committing and pushing changes to gh-pages branch..."
git add .
git commit -m "Deploy to gh-pages"
git push origin gh-pages

# Remove the docs folder
echo "Removing docs folder..."
rm -rf docs

echo "Finished deploying to gh-pages"

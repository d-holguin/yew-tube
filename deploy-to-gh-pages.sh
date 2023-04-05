#!/bin/sh

echo "This script will deploy to GitHub Pages. Are you sure you want to continue? (y/n)"
read answer

if [ "$answer" = "${answer#[Yy]}" ]; then
    echo "Aborted."
    exit 0
fi

current_branch=$(git rev-parse --abbrev-ref HEAD)

if [ "$current_branch" != "gh-pages" ]; then
    echo "You are not on the gh-pages branch. Please switch to the gh-pages branch before deploying."
    exit 1
else
    echo "You are on the gh-pages branch. Proceeding with the deployment..."
fi

# Rest of the script


# Set the TRUNK_CONFIG environment variable to use the gh-pages configuration
export TRUNK_CONFIG=trunk-gh-pages.toml

# Build the Yew application using trunk with the release configuration
trunk build --release

# Commit and push changes to the gh-pages branch.
git add .
git commit -m "Deploy to gh-pages"
git push origin gh-pages
echo "Removing docs folder"
rm -r docs
echo "Finsihed removing docs folder"

echo "Finished deploying to gh-pages"

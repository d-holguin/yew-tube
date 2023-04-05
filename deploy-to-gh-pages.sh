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

# Backup the current directory, excluding the target directory
echo "Backing up current directory..."
backup_dir=".backup_$(date +%Y%m%d%H%M%S)"
mkdir $backup_dir
find . -maxdepth 1 -mindepth 1 -type f -exec cp -t $backup_dir {} \;
find . -maxdepth 1 -mindepth 1 -type d -not -name 'target' -not -name $backup_dir -not -name '.git' -exec cp -a {} $backup_dir/ \;
echo "Backup created at $backup_dir"

# Remove all root files except .git folder
echo "Cleaning root directory..."
find . -maxdepth 1 -mindepth 1 -type f -exec rm -f {} \;
find . -maxdepth 1 -mindepth 1 -type d -not -name '.git' -not -name $backup_dir -exec rm -rf {} \;
echo "Root directory cleaned"

# Build the Yew application using trunk
trunk build --release

# Move the contents of the dist folder to the root
cp -r dist/* .

# Create the .nojekyll file to disable Jekyll processing
touch .nojekyll

# Commit and push changes to the gh-pages branch.
git add .
git commit -m "Deploy to gh-pages"
git push origin gh-pages

echo "Finished deploying to gh-pages"

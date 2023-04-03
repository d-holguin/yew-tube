#!/bin/sh

# Exit immediately if a command exits with a non-zero status.
set -e

if ! command -v trunk &> /dev/null; then
  echo "Trunk command not found. Please install it using 'cargo install trunk'."
  exit 1
fi

# Check if we're on the gh-pages branch.
if [ "$(git rev-parse --abbrev-ref HEAD)" != "gh-pages" ]; then
  # If not, create the gh-pages branch if it doesn't exist.
  if ! git show-ref --verify --quiet refs/heads/gh-pages; then
    git branch gh-pages
  fi

  # Checkout the gh-pages branch.
  git checkout gh-pages
fi

# Remove old build files
rm -rf dist

# Build the Yew application using Trunk
trunk build --release

# Move the contents of the dist directory to the root directory
cp -R dist/* .

# Find the generated file names within the dist directory
js_file=$(find ./dist -name "yew_tube_converter*.js" -exec basename {} \;)
wasm_file=$(find ./dist -name "yew_tube_converter*_bg.wasm" -exec basename {} \;)

# Generate the index.html file with the correct file names
cat << EOF > index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>YewTube Converter</title>
    <link rel="icon" href="assets/favicon.svg" type="image/x-icon">
</head>

<body>
    <noscript>
        <strong>Your browser does not support JavaScript or it is disabled. Please enable JavaScript to use this
            application.</strong>
    </noscript>
    <div id="app"></div>
    <script type="module">
        import init from './${js_file}';
        init('./${wasm_file}');
    </script>
</body>
</html>
EOF

# Commit and push changes to the gh-pages branch.
git add .
git commit -m "Deploy to gh-pages"
git push origin gh-pages

# Checkout the previous branch.
git checkout -

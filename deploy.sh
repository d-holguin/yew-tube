#!/bin/bash

# Check if current branch is gh-pages
if [[ $(git symbolic-ref --short HEAD) != "gh-pages" ]]; then
  echo "Error: current branch is not gh-pages"
  exit 1
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

# Generate a new index.html file with the correct file names
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

# Commit the changes
git add .
git commit -m "Deploy to GitHub Pages"

# Push changes to remote gh-pages branch
git push origin gh-pages

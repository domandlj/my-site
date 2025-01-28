#!/bin/zsh

#!/bin/zsh

# Compile Elm code
elm make src/Main.elm --output=main.js && {
  echo "Elm compilation successful. Starting Python HTTP server..."
  python3 -m http.server 8000
} || {
  echo "Elm compilation failed. Exiting script."
  exit 1
}

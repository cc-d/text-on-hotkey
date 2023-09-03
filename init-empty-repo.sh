
# Initialize Node.js project
npm init -y

# Install required dev dependencies
npm install --save-dev typescript ts-loader webpack webpack-cli webextension-polyfill-ts

# Generate tsconfig.json
cat <<EOL > tsconfig.json
{
  "compilerOptions": {
    "outDir": "./dist/",
    "noImplicitAny": true,
    "module": "es6",
    "moduleResolution": "node",
    "target": "es6",
    "jsx": "react",
    "allowJs": true
  },
  "include": ["*.ts"]
}
EOL

# Generate webpack.config.js
cat <<EOL > webpack.config.js
const path = require('path');

module.exports = {
  entry: {
    background: path.join(__dirname, 'background.ts')
  },
  output: {
    path: path.join(__dirname, 'dist'),
    filename: '[name].js'
  },
  module: {
    rules: [
      {
        test: /\.ts$/,
        loader: 'ts-loader'
      }
    ]
  },
  resolve: {
    extensions: ['.ts', '.js']
  }
};
EOL

# Generate manifest.json
cat <<EOL > manifest.json
{
  "manifest_version": 2,
  "name": "TextOnKeyPress",
  "version": "1.0",
  "description": "Enter text on key press",
  "permissions": ["activeTab"],
  "background": {
    "scripts": ["background.js"],
    "persistent": false
  },
  "commands": {
    "enter-text": {
      "suggested_key": {
        "default": "Ctrl+Shift+U"
      },
      "description": "Enter text"
    }
  }
}
EOL

# Generate background.ts
cat <<EOL > background.ts
import { browser } from "webextension-polyfill-ts";

function enterText() {
  const scriptToExecute = \`
    const activeElement = document.activeElement as HTMLInputElement;
    if (activeElement && (activeElement.tagName === 'INPUT' || activeElement.tagName === 'TEXTAREA')) {
      activeElement.value += 'Auto-entered text';
    }
  \`;

  browser.tabs.executeScript({
    code: scriptToExecute
  });
}

browser.commands.onCommand.addListener((command) => {
  if (command === 'enter-text') {
    enterText();
  }
});
EOL

# Build project
npx webpack

const path = require('path');

module.exports = {
  entry: {
    background: path.join(__dirname, "background.ts"),
    content: path.join(__dirname, "content.ts")
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

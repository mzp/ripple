var path = require('path');

module.exports = {
  entry: "./src/react/index.js",
  devtool: "inline-source-map",
  output: {
    filename: "index.js",
    library: "ripple",
    libraryTarget: "umd"
  },
  module: {
    rules: [
      {
        test: /\.jsx?$/,
        include: [
          path.resolve(__dirname, "src/react"),
        ],
        use: 'babel-loader'
      }
    ]
  },
  resolve: {
    modules: [
      "node_modules"
    ],
    extensions: ['.js', '.jsx']
  }
};

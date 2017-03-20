var path = require('path');

module.exports = {
  entry: "./src/react/index.js",
  devtool: "inline-source-map",
  output: {
    path: ".",
    filename: "index.js"
  },
  module: {
    rules: [
      {
        test: /\.jsx?$/,
        include: [
          path.resolve(__dirname, "src/react"),
        ],
        exclude: /node_modules/,
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

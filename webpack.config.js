var path = require('path');

module.exports = {
  entry: "./src/view/index.jsx",
  devtool: "inline-source-map",
  output: {
    path: "public",
    filename: "bundle.js"
  },
  module: {
    rules: [
      {
        test: /\.jsx?$/,
        include: [
          path.resolve(__dirname, "src/view"),
        ],
        exclude: /node_modules/,
        use: 'babel-loader'
      }
    ]
  },
  resolve: {
    modules: [
      path.join(__dirname, "lib/js/src"),
      "node_modules"
    ],
    extensions: ['.js', '.jsx']
  }
};

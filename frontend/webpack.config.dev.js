const webpack = require('webpack');
const HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
  entry: {
    js: './app/driver.js'
  },
  module: {
    loaders: [
      {
        test: /\.js?$/,
        exclude: /node_modules/,
        loaders: ["babel-loader"]
      },
      {
        test: /\.css$/,
        use: [ 'style-loader', 'css-loader' ]
      },
      {
        test: /\.html$/,
        loader: 'underscore-template-loader',
        query: {
          engine: 'lodash',
        }
      }
    ]
  },
  output: {
    path: __dirname + "/../public/dist",
    filename: "./js/app.js"
  },
  plugins: [
    new webpack.ProvidePlugin({
      _: 'underscore',
      $: 'jquery',
      jQuery: 'jquery'
    })
  ],
  plugins: [
    new HtmlWebpackPlugin(
      {
        filename: 'index.html',
        template: 'app/index.html'
      }
    ),
    new webpack.DefinePlugin({
      API_URL: JSON.stringify("http://192.168.33.10:3000"),
      APP_ID: JSON.stringify("e2d7ab339951cc3661b2432042fc64bd"),
      FORECAST_API_URL: JSON.stringify("http://api.openweathermap.org")
    })
  ],
  devtool: 'source-map',
  devServer: {
    contentBase: 'dist',
    inline: true,
    hot:true,
    port: 8081
  },
  watchOptions: {
    poll: true
  }
};
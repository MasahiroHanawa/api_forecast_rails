const webpack = require('webpack');
const HtmlWebpackPlugin = require('html-webpack-plugin');

module.exports = {
  entry: {
    js: './coffee_app/driver.coffee'
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
      },
      {
        test: /\.coffee$/,
        use: [
          {
            loader: 'coffee-loader',
            options: { sourceMap: true }
          }
        ]
      },
      {
        test: /\.pug$/, loader: 'pug-loader'
      },
      {
        test: /\.jade$/, loader: 'jade-loader'
      },
      {
        test: /\.(woff|woff2)(\?v=\d+\.\d+\.\d+)?$/, loader: 'url?limit=10000&mimetype=application/font-woff'
      },
      {
        test: /\.ttf(\?v=\d+\.\d+\.\d+)?$/, loader: 'url?limit=10000&mimetype=application/octet-stream'
      },
      {
        test: /\.eot(\?v=\d+\.\d+\.\d+)?$/, loader: 'file'
      },
      {
        test: /\.svg(\?v=\d+\.\d+\.\d+)?$/, loader: 'url?limit=10000&mimetype=image/svg+xml'
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
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
        use: [ 'style-loader', 'css-loader', 'sass-loader' ]
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
        test: /\.pug$/,
        loader: 'pug-loader'
      },
      {
        test: /\.jade$/,
        loader: 'jade-loader'
      },
      {
        test: /\.svg$/,
        loader: 'url-loader?mimetype=image/svg+xml'
      },
      {
        test: /\.woff$/,
        loader: 'url-loader?mimetype=application/font-woff'
      },
      {
        test: /\.woff2$/,
        loader: 'url-loader?mimetype=application/font-woff'
      },
      {
        test: /\.eot$/,
        loader: 'url-loader?mimetype=application/font-woff'
      },
      {
        test: /\.ttf$/,
        loader: 'url-loader?mimetype=application/font-woff'
      }
    ]
  },
  output: {
    path: __dirname + '/dist',
    filename: './js/app.js'
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
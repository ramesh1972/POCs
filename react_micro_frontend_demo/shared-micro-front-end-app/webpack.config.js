const HtmlWebpackPlugin = require('html-webpack-plugin');
const ModuleFederationPlugin = require('webpack/lib/container/ModuleFederationPlugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');
const NodePolyfillPlugin = require('node-polyfill-webpack-plugin');
const webpack = require('webpack');
const Dotenv = require('dotenv-webpack');

const path = require('path');
const dotenv = require('dotenv');

// Load environment variables
const mode = process.env.NODE_ENV === 'production' ? 'prod' : 'dev';
const envFile = path.resolve(__dirname, `envs/${mode}.env`);
const env = dotenv.config({ path: envFile }).parsed || {};

console.log('---------------------------------');
console.log('mode', mode);
console.log('environment file', envFile);
console.log('environment variables', env);
console.log('---------------------------------');

module.exports = {
  mode: process.env.NODE_ENV || 'development',
  entry: './src/index.js',
  output: {
    publicPath: env.SHARED_MFE_URL || 'http://localhost:8083/',
  },
  resolve: {
    extensions: ['.js', '.jsx'],
    alias: {
      path: 'path-browserify', // Use path-browserify instead of the Node.js path module
    },
    fallback: {
      process: require.resolve('process/browser'), // Use the process polyfill
    },
  },
  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        use: {
          loader: 'babel-loader',
        },
      },
      {
        test: /\.css$/,
        exclude: /node_modules/,
        use: ['style-loader', 'css-loader'],
      },
      {
        test: /\.(png|jpg|jpeg|gif|svg)$/,
        exclude: /node_modules/,
        use: [
          {
            loader: 'file-loader'
          },
        ],
      },
    ],
  },
  plugins: [
    new webpack.ProvidePlugin({
      process: 'process/browser', // Automatically provide process when referenced
    }),
    new Dotenv({
      path: envFile
    }),
    new NodePolyfillPlugin(), // Add polyfills for Node.js modules

    new ModuleFederationPlugin({
      name: 'sharedMFE',
      filename: 'remoteEntry.js',
      exposes: {
        './AboutComponent': './src/components/AboutComponent',
        './getUserCount': './src/utils',
        './getCurrentTime': './src/utils',
        './commonStyles': './src/styles/commonStyles.css', // Expose the common style file
      },
    }),
    new HtmlWebpackPlugin({
      template: './public/index.html',
    }),
    new CopyWebpackPlugin({
      patterns: [
        {
          from: 'public', // Source folder (where your images are stored)
          to: '.', // Destination folder inside dist
          globOptions: {
            ignore: ['**/index.html'], // Ignore index.html if it's in public
          },
        },
      ],
    }),
  ],
  devServer: {
    port: env.MY_PORT || 8083,
    historyApiFallback: true,
  },
};
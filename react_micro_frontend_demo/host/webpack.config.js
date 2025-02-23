const ModuleFederationPlugin = require('webpack/lib/container/ModuleFederationPlugin');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const NodePolyfillPlugin = require('node-polyfill-webpack-plugin');
const webpack = require('webpack');

const path = require('path');
const os = require('os');
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
    publicPath: env.HOST_URL || 'http://localhost:8085/',
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
        test: /\.(js|jsx)$/, // Process JS and JSX files
        exclude: /node_modules/, // Ignore node_modules
        use: {
          loader: 'babel-loader',
          options: {
            presets: ['@babel/preset-env', '@babel/preset-react']
          }
        }
      },
      {
        test: /\.css$/,
        exclude: /node_modules/,
        use: ['style-loader', 'css-loader'],
      },
    ],
  },
  plugins: [
    new webpack.ProvidePlugin({
      process: 'process/browser', // Automatically provide process when referenced
    }),
    new NodePolyfillPlugin(), // Add polyfills for Node.js modules

    new ModuleFederationPlugin({
      name: 'host',
      remotes: {
        dashboard: `dashboard@${env.DASHBOARD_URL}remoteEntry.js`,
        userManagement: `userManagement@${env.USER_MANAGEMENT_URL}remoteEntry.js`,
        sharedMFE: `sharedMFE@${env.SHARED_MFE_URL}remoteEntry.js`,
        footer: `footer@${env.FOOTER_URL}remoteEntry.js`,
        header: `header@${env.HEADER_URL}remoteEntry.js`,
      },
      shared: {
        react: {
          singleton: true, // Ensure a single instance of React
          requiredVersion: '^18.0.0',
          eager: true
        },
        'react-dom': {
          singleton: true, // Ensure a single instance of ReactDOM
          requiredVersion: '^18.0.0',
          eager: true
        }
      },
    }),
    new HtmlWebpackPlugin({
      template: path.resolve(__dirname, 'index.html'),
    }),
  ],
  devServer: {
    port: env.MY_PORT || 8085,
    historyApiFallback: true,
  },
};
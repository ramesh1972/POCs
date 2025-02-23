import React from 'react';
import './Migrate.css';

const Migrate = () => {
  console.log("Shared MFE URL:", process.env.SHARED_MFE_URL);
  const baseURL = process.env.SHARED_MFE_URL || 'http://localhost:8083';

  return (
    <div className="common-container" style={{border: '3px dashed blue'}}>
      <div className="common-header">
        Host MFE Application's Migrate Component
      </div>
      <section className="migration-notes">
        <h2>Migration Notes</h2>
        <div className="section">
          <p className="title">
            1) You can convert an existing monolith frontend webapp to micro front-end architecture with minimal code changes:
          </p>
          <ul className="list">
            <li>Split your code into multiple Micro Front Ends (MFEs).</li>
            <li>Move your common components, styles, scripts, and assets to a shared MFE.</li>
            <li>
              Design your new MFEs in a modular way where one MFE can compose others, yet they should work independently and be reusable.
            </li>
          </ul>
        </div>

        <div className="section">
          <p className="title">2) Decide on a micro front-end framework:</p>
          <ul className="list">
            <li>Webpack Module Federation</li>
            <li>Vite Module Federation</li>
            <li>Parcel</li>
            <li>Etc.</li>
          </ul>
        </div>

        <div className="section">
          <p className="title">3) This demo app uses Webpack Module Federation.</p>
        </div>

        <div className="section">
          <p className="title">4) After splitting your monolith into MFEs:</p>
          <ul className="list">
            <li>Import components from other MFEs instead of local ones.</li>
            <li>Set up `webpack.config.js` for Module Federation.</li>
            <li>Steps: Split into MFEs, import components from other MFEs, set up Webpack.</li>
          </ul>
        </div>

        <div className="section">
          <p className="title">5) Use shared state management libraries like redux-micro-frontend:</p>
          <ul className="list">
            <li>Share state between MFEs.</li>
            <li>Subscribe to state changes in other MFEs.</li>
            <li>Publish state changes to other MFEs.</li>
          </ul>
        </div>

        <div className="section">
          <p className="title">6) Sample webpack.config.js:</p>
          <pre className="code-block">
            {`// webpack.config.js (Dashboard Micro Frontend)
const HtmlWebpackPlugin = require('html-webpack-plugin');
const ModuleFederationPlugin = require('webpack/lib/container/ModuleFederationPlugin');
const NodePolyfillPlugin = require('node-polyfill-webpack-plugin');
const webpack = require('webpack');
const path = require('path');
const dotenv = require('dotenv');

// Load environment variables
const mode = process.env.NODE_ENV === 'production' ? 'prod' : 'dev';
const envFile = path.resolve(__dirname, \`envs/\${mode}.env\`);
const env = dotenv.config({ path: envFile }).parsed || {};

console.log('Environment:', env);

module.exports = {
  mode: process.env.NODE_ENV || 'development',
  entry: './src/index.js',
  output: {
    publicPath: env.DASHBOARD_URL || 'http://localhost:8089/',
  },
  resolve: {
    extensions: ['.js', '.jsx'],
    alias: { path: 'path-browserify' },
    fallback: { process: require.resolve('process/browser') },
  },
  module: {
    rules: [
      {
        test: /\.(js|jsx)$/,
        exclude: /node_modules/,
        use: { loader: 'babel-loader', options: { presets: ['@babel/preset-env', '@babel/preset-react'] } },
      },
    ],
  },
  plugins: [
    new webpack.ProvidePlugin({ process: 'process/browser' }),
    new NodePolyfillPlugin(),
    new ModuleFederationPlugin({
      name: 'dashboard',
      filename: "remoteEntry.js",
      exposes: { './Dashboard': './src/Dashboard' },
      remotes: { sharedMFE: \`sharedMFE@\${env.SHARED_MFE_URL}remoteEntry.js\` },
      shared: {
        react: { singleton: true, requiredVersion: '^18.0.0', eager: true },
        'react-dom': { singleton: true, requiredVersion: '^18.0.0', eager: true },
      },
    }),
    new HtmlWebpackPlugin({ template: path.resolve(__dirname, 'index.html') }),
  ],
  devServer: { port: env.MY_PORT || 8089, historyApiFallback: true },
};
`}
          </pre>
        </div>
      </section>
    </div>
  );
};

export default Migrate;

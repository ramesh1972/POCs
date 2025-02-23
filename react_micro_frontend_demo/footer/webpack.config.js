const HtmlWebpackPlugin = require('html-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const ModuleFederationPlugin = require('webpack').container.ModuleFederationPlugin;
const NodePolyfillPlugin = require('node-polyfill-webpack-plugin');
const CopyWebpackPlugin = require('copy-webpack-plugin');

const webpack = require('webpack');
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
	entry: './src/main.js',
	resolve: {
		alias: {
			svelte: path.dirname(require.resolve('svelte/package.json')),
			path: 'path-browserify', // Use path-browserify instead of the Node.js path module

		},
		extensions: ['.mjs', '.js', '.svelte'],
		mainFields: ['svelte', 'browser', 'module', 'main'],
		fallback: {
			process: require.resolve('process/browser'), // Use the process polyfill
		},
	},
	output: {
		publicPath: env.FOOTER_URL || 'http://localhost:8081/',
	},
	module: {
		rules: [
			{
				test: /\.svelte$/,
				use: {
					loader: 'svelte-loader',
				}
			},
			{
				test: /\.css$/,
				use: [
					MiniCssExtractPlugin.loader,
					'css-loader'
				]
			},
			{
				// required to prevent errors from Svelte on Webpack 5+
				test: /node_modules\/svelte\/.*\.mjs$/,
				resolve: {
					fullySpecified: false
				}
			}
		]
	},
	plugins: [
		new webpack.ProvidePlugin({
			process: 'process/browser', // Automatically provide process when referenced
		}),
		new NodePolyfillPlugin(), // Add polyfills for Node.js modules
		new ModuleFederationPlugin({
			name: 'footer',
			filename: 'remoteEntry.js',
			exposes: {
				'./footerModule': './src/loadApp.js'
			},
			remotes: {
				sharedMFE: `sharedMFE@${env.SHARED_MFE_URL}remoteEntry.js`,
			},
		}),
		new MiniCssExtractPlugin({
			filename: '[name].css'
		}),
		new CopyWebpackPlugin({
			patterns: [
				{
					from: 'public', // Source folder (where your images are stored)
					to: '.', // Destination folder inside dist
				},
			],
		}),
		new HtmlWebpackPlugin({
			template: path.resolve(__dirname, 'index.html'),
		}),

	],
	devtool: mode == 'production' ? false : 'source-map',
	devServer: {
		port: env.MY_PORT || 8081,
		hot: true
	}
};

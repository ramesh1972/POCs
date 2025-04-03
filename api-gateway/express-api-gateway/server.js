const gateway = require('express-gateway');
const path = require('path');
const dotenv = require('dotenv');

// Determine the environment (LOCAL or DEV or QA or PROD) and load the correct .env file
// NODE_ENV is usually local, development, qa, uat, staging or production
const envFile = dotenv.config({path: path.resolve(__dirname, "envs", `${process.env.NODE_ENV}.env`)});
if (envFile.error) {
  console.log('Error loading .env file:', envFile.error);
  process.exit(1);
}

// Load the .env file
dotenv.config(envFile);


console.log("-----------------------------------");
console.log('envFile:', envFile);
console.log('env', process.env.NODE_ENV);
console.log('env variables:', process.env);
console.log("-----------------------------------");

gateway()
  .load(path.join(__dirname, 'config'))
  .run();

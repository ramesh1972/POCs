module.exports = {
    version: '0.0.1',
    schema: {
      "$id": "https://express-gateway.io/schemas/plugins/my-plugin.json"
    },
    init: function (pluginContext) {
      const policy = require('./policies/verify-token.js');  // Correct path to the policy file
      pluginContext.registerPolicy(policy);  // Register the custom policy
    }
  }
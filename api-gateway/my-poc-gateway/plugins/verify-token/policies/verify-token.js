const axios = require('axios');

module.exports = {
  name: 'verify-token',
  schema: {
    $id: 'http://express-gateway.io/schemas/policies/example-policy.json',
    type: 'object'
  },
  policy: (actionParams) => {
    return async (req, res, next) => {
      console.log('verify-token policy:req - ', req.headers);
      const authHeader = req.headers['authorization'];
      console.log('authHeader', authHeader);
      if (!authHeader || !authHeader.startsWith('Bearer ')) {
        return res.status(401).send('Unauthorized');
      }

      const token = authHeader.split(' ')[1];
      const authUrl = `http://localhost:9010/auth?key=${token}`;
      console.log('authUrl', authUrl);
      console.log('token', token);
      try {
        const response = await axios.get(authUrl);
        console.log('auth response', response.data);
        if (response.data && response.data.data && response.data.data.key) {
          next();
        } else {
          res.status(401).send('Unauthorized');
        }
      } catch (error) {
        res.status(401).send('Unauthorized');
      }
    };
  },
};
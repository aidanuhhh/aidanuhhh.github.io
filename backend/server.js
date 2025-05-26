// server.js
require('dotenv').config();
const express = require('express');
const Parse = require('parse/node');

Parse.initialize(
  process.env.BACK4APP_APP_ID,
  process.env.BACK4APP_JS_KEY,
  process.env.BACK4APP_MASTER_KEY
);
Parse.serverURL = 'https://parseapi.back4app.com/';

const app = express();
app.use(express.json());

// User authentication endpoint
app.post('/login', async (req, res) => {
  try {
    const user = await Parse.User.logIn(req.body.username, req.body.password);
    res.json({ sessionToken: user.getSessionToken() });
  } catch (error) {
    res.status(401).json({ error: 'Authentication failed' });
  }
});

// Start server
app.listen(3000, () => {
  console.log('Back4App-connected server running on port 3000');
});

// Add to server.js
const { init } = require('@sentry/node');
init({ dsn: process.env.SENTRY_DSN });
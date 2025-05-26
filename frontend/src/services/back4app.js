// src/services/back4app.js
import Parse from 'parse';

export const initBack4App = () => {
  Parse.initialize(
    process.env.REACT_APP_BACK4APP_APP_ID,
    process.env.REACT_APP_BACK4APP_JS_KEY
  );
  Parse.serverURL = 'https://parseapi.back4app.com/';
};

// Example data fetch
export const fetchBannedUsers = async () => {
  const query = new Parse.Query('Bans');
  return query.find();
};
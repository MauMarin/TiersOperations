// Archivo que define mediante variables de ambiente host y puerto del API

const dotenv = require('dotenv');

dotenv.config();

const {
	REACT_APP_API_PORT,
	REACT_APP_API_HOST,
	REACT_APP_API_URL
} = process.env;

module.exports = {
	port: REACT_APP_API_PORT,
	host: REACT_APP_API_HOST,
	url: REACT_APP_API_URL,
};
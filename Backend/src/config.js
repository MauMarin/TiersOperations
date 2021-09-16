"use strict";

// Uso de variables de ambiente
const dotenv = require('dotenv');

// Se asegura que las variables indicadas sean ingresadas
const assert = require('assert');

dotenv.config();

// Define todas las variables como de ambiente
const {
	PORT,
	HOST,
	HOST_URL,
	COOKIE_ENCRYPT_PWD,
	SQL_SERVER,
	SQL_DATABASE,
	SQL_USER,
	SQL_PASSWORD,
	SQL_PORT
} = process.env;

// En caso de querer encriptar la base de datos
const sqlEncrypt = process.env.SQL_ENCRYPT === "true";

// Se aseguran estos valores. Si no se ingresan, no se puede proseguir con la aplicación
assert( PORT, "PORT is required" );
assert( HOST, "HOST is required" );

// Exporta las variables para que puedan ser accedidas desde cualquier parte de la aplicación
module.exports = {
	port: PORT,
	host: HOST,
	url: HOST_URL,
	cookiePwd: COOKIE_ENCRYPT_PWD,
	sql: {
		server: SQL_SERVER,
		database: SQL_DATABASE,
		user: SQL_USER,
		password: SQL_PASSWORD,
		port: SQL_PORT,
		options: {
			encrypt: sqlEncrypt,
			enableArithAbort: true
		}
	}
};
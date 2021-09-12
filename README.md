# TiersOperations

TiersOperations is the first iteration for a base application for the internal use of the administrative section of Medtronic Costa Rica. This, by far, is not the final product, and is treated as so, meaning that the project is still in development, but in a sufficiently advanced state to be used inside the company.

This project is composed by an internal API that runs using Node.js with Express, a frontend built in React and Axios, and a database structure in MSSQL.

Database Installation
The database is composed by two different applications: a docker container, and an instance of MSSQL 2019 in Azure Data Studio.

To create the container, and initiate the MSSQL database:

docker run -d --name sqlserver -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD="DB_PASSWORD"' -e 'MSSQL_PID=Developer' -p 1433:1433 mcr.microsoft.com/mssql/server:2019-latest

To setup the database structure, stored procedures, and base information, the container needs to be running.

1) Connect an instance in Azure Data Studio to the Docker container. This is done by a starting a new connection, and selecting 'SQL Login' as the authentication type

2) Create a new Query in the established connection

3) Run the 'Database_Setup.sql' file


Backend Hosting

Before running the application, be sure to change the .env variables to suit the needs of the user. It is supplied by default as 'localhost'

To start the API, run the following command:
npm run dev


Frontend Hosting

Before running the application, be sure to change the .env variables to be the same as those defined in the previous step.
npm start
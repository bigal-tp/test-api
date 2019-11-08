# test-api
BFF proof of concept Rest.js with Coldfusion backend

I did this without a database, so the get method data is hardcoded into a query in the cfc findAll() method.

A post request for an insert json body example.

{ 
	"name" : "Sagrada",
	"description" : "Dice Drafting",
	"rating" : 8
}

I did not write put or delete methods because there is not database, and these would require a table of data manipulation.

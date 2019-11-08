component displayname="boardgames.cfc" hint="This CFC is used for proof of concept with nest/js" output="true"
{
	remote struct function findAll(
		
	)
	 displayName="findAll"
	 description="Get All Games"
	 hint=""
	 output="true"
	 returnFormat="JSON"
	{
		/********** BEGIN DEFAULT RETURN VALUE **********/
			local.returnValue = {
				"statusCode" : 1000,
				"requestID" : createUUID(),
				"permissions" : "V",
				"message" : "Success",
				"eventName" : "findAll",
				"totalRows" : 0,
				"results" : [],
				"arguments" : {
				}
			};
		/********** END DEFAULT RETURN VALUE **********/


		/********** BEGIN CHECK FOR MISSING ARGUMENTS **********/
			try {
				//This is where I would normally put statements to check to see ensure all required arguments were passed.  However this method has no arguments.
			}
			catch ( any e ) {
				/***** END BEGIN ERROR MESSAGE *****/
					local.returnValue.statusCode = 5000;
					local.returnValue.message = "An error occurred while running the method <tt>" & ListLast(local.returnValue.eventName, '/') & "</tt>. The error message is " & e.Message & ".";

					if ( isDefined( "e.RootCause.Message" ) ) { local.returnValue.results[ 1 ][ "RootCause" ] = { "message" : e.RootCause.Message }; }
					if ( isDefined( "e.TagContext" ) ) { local.returnValue.results[ 1 ][ "tagContext" ] = e.TagContext; }
				/***** END BEGIN ERROR MESSAGE *****/

				/***** BEGIN LOG UPDATE *****/
					writeLog( file="boardgames", type="Error", text=local.returnValue.message );
				/***** END LOG UPDATE *****/
			}
		/********** END CHECK FOR MISSING ARGUMENTS **********/

		/********** BEGIN QUERY **********/
			try {
				if ( REFindNoCase( "1\d{3}", local.returnValue.statusCode ) ) {
					/********** BEGIN QUERY **********/
					local.thisQuery = queryNew("id,name,description,rating","Varchar,Varchar,Varchar,Integer", 
                [ 
                        {id=1,name="Azul",description="Tile drafting and laying game",rating=8}, 
						{id=2,name="Tapestry",description="Euro style civilization game",rating=7}, 
						{id=3,name="Arkaham Horror the Card Game",description="Cooperative, RPG style game within the Lovecraft Mythos",rating=10} 
                ]); 
					
					/********** END QUERY **********/
				}
			}
			catch ( any e ) {
				/***** END BEGIN ERROR MESSAGE *****/
					local.returnValue.statusCode = 5000;
					local.returnValue.message = "An error occurred while running the method <tt>" & ListLast(local.returnValue.eventName, '/') & "</tt>. The error message is " & e.Message & ".";

					if ( isDefined( "e.RootCause.Message" ) ) {
						 local.returnValue.results[ 1 ][ "RootCause" ] = { "message" : e.RootCause.Message };
					}

					if ( isDefined( "e.TagContext" ) ) {
						local.returnValue.results[ 1 ][ "tagContext" ] = e.TagContext;
					}
				/***** END BEGIN ERROR MESSAGE *****/

				/***** BEGIN LOG UPDATE *****/
					writeLog( file="acmeCars", type="Error", text=local.returnValue.message );
				/***** END LOG UPDATE *****/
			}
		/********** END QUERY **********/

		/********** BEGIN OUTPUT **********/
			try {
				if ( REFindNoCase( "1\d{3}", local.returnValue.statusCode ) ) {
					/***** BEGIN QUERY LOOP *****/
						local.thisCountA = 1;
						
						for ( local.A IN local.thisQuery ) {
							local.returnValue["results"][ local.thisCountA ] = {
									"id" : local.A[ "ID" ],
									"name" : local.A[ "NAME" ],
									"description" : local.A[ "DESCRIPTION" ],
									"rating" : local.A["RATING"]
									};
								local.thisCountA++;
							}
						}

						local.returnValue.totalRows = 3;
					/***** END QUERY LOOP *****/
				}
			
			catch ( any e ) {
				/***** END BEGIN ERROR MESSAGE *****/
					local.returnValue.statusCode = 5000;
					local.returnValue.message = "An error occurred while running the method <tt>" & ListLast(local.returnValue.eventName, '/') & "</tt>. The error message is " & e.Message & ".";

					if ( isDefined( "e.RootCause.Message" ) ) {
						 local.returnValue.results[ 1 ][ "RootCause" ] = { "message" : e.RootCause.Message };
					}

					if ( isDefined( "e.TagContext" ) ) {
						local.returnValue.results[ 1 ][ "tagContext" ] = e.TagContext;
					}
				/***** END BEGIN ERROR MESSAGE *****/

				/***** BEGIN LOG UPDATE *****/
					//writeLog( file="acmeCars", type="Error", text=local.returnValue.message );
				/***** END LOG UPDATE *****/
			}
		/********** BEGIN OUTPUT **********/

			return local.returnValue;
		/********** END OUTPUT **********/	
	}
	remote struct function post(
		
		
	)
     displayName="post"
	 description="inserts a new boardgame to the database"
	 hint=""
	 output="true"
	 returnFormat="JSON"
	{
		body = getHTTPRequestData();
		arguments = deserializeJSON(body.content);
		
		/********** BEGIN DEFAULT RETURN VALUE **********/
			local.returnValue = {
				"statusCode" : 1000,
				"requestID" : createUUID(),
				"permissions" : "V",
				"message" : "Success",
				"eventName" : "post",
				"totalRows" : 0,
				"results" : [],
				"arguments" : {
					"name" : {
						"value" : arguments.name,
						"type" : "string",
						"required" : true,
						"description" : "Name of Board GAme"
					},
					"description" : {
						"value" : arguments.description,
						"type" : "string",
						"required" : true,
						"description" : "Description of Board Game"
					},
					"rating" : {
						"value" : arguments.rating,
						"type" : "string",
						"required" : false,
						"description" : "The rating of the board game"
					}
				}
			};
		/********** END DEFAULT RETURN VALUE **********/
		
		/********** BEGIN QUERY **********/
			try {
				if ( REFindNoCase( "1\d{3}", local.returnValue.statusCode ) ) {
					/********** BEGIN QUERY **********/
						local.queryService = new query();
						local.queryService.setDatasource( "acmeCars" );
						local.queryService.setName( "thisQuery" );

						/***** BEGIN QUERY PARAMETERS *****/
							local.queryService.addParam( name="name", value=arguments.name, cfsqltype="cf_sql_varchar" );
							local.queryService.addParam( name="description", value=arguments.description, cfsqltype="cf_sql_varchar" );
							local.queryService.addParam( name="rating", value=arguments.rating, cfsqltype="cf_sql_integer" );
						/***** END QUERY PARAMETERS *****/

						/***** BEGIN QUERY STRING *****/
							local.queryService.sqlString = "
								INSERT INTO boardgame (
									name, 
									description, 
									rating)
								VALUES (
									:name, 
									:description, 
									:rating);
							";

						/***** END QUERY STRING *****/

						/***** BEGIN QUERY EXECUTE *****/
						//	local.queryResult = local.queryService.execute( sql= local.queryService.sqlString );
						/***** END QUERY EXECUTE *****/

						/***** BEGIN QUERY RESULTS *****/
						//	local.queryMetaData = local.queryResult.getPrefix();
						//	local.thisQuery = local.queryResult.getResult();
						/***** END QUERY RESULTS *****/
					/********** END QUERY **********/
					}
			}
			catch ( any e ) {
				/***** END BEGIN ERROR MESSAGE *****/
					local.returnValue.statusCode = 5000;
					local.returnValue.message = "An error occurred while running the method <tt>" & ListLast(local.returnValue.eventName, '/') & "</tt>. The error message is " & e.Message & ".";

					if ( isDefined( "e.RootCause.Message" ) ) {
						 local.returnValue.results[ 1 ][ "RootCause" ] = { "message" : e.RootCause.Message };
					}

					if ( isDefined( "e.TagContext" ) ) {
						local.returnValue.results[ 1 ][ "tagContext" ] = e.TagContext;
					}
				/***** END BEGIN ERROR MESSAGE *****/

				/***** BEGIN LOG UPDATE *****/
					writeLog( file="boardgames", type="Error", text=local.returnValue.message );
				/***** END LOG UPDATE *****/
			}
		/********** END QUERY **********/

		/********** BEGIN OUTPUT **********/
			try {
				if ( REFindNoCase( "1\d{3}", local.returnValue.statusCode ) ) {
					/***** BEGIN QUERY LOOP *****/
						
							
							local.returnValue["results"][ 1 ] = {
								"Query" : "INSERT INTO boardgame (name,description,rating)` VALUES ( " & arguments.name & ", " & arguments.description & ", " & arguments.rating & ")"
							};
					/***** END QUERY LOOP *****/
				}
				for ( local.A IN local.returnValue.arguments ) {
					for ( local.B in local.returnValue.arguments[ local.A ] ) { if ( !REFindNoCase( "^(message|value|error)$", local.B ) ) { StructDelete( local.returnValue.arguments[ local.A ], local.B, "True"); } }
					if ( StructIsEmpty( local.returnValue.arguments[ local.A ] ) ) { StructDelete( local.returnValue.arguments, local.A, "True"); }
				}
			}			
			catch ( any e ) {
				/***** END BEGIN ERROR MESSAGE *****/
					local.returnValue.statusCode = 5000;
					local.returnValue.message = "An error occurred while running the method <tt>" & ListLast(local.returnValue.eventName, '/') & "</tt>. The error message is " & e.Message & ".";

					if ( isDefined( "e.RootCause.Message" ) ) {
						 local.returnValue.results[ 1 ][ "RootCause" ] = { "message" : e.RootCause.Message };
					}

					if ( isDefined( "e.TagContext" ) ) {
						local.returnValue.results[ 1 ][ "tagContext" ] = e.TagContext;
					}
				/***** END BEGIN ERROR MESSAGE *****/

				/***** BEGIN LOG UPDATE *****/
					//writeLog( file="acmeCars", type="Error", text=local.returnValue.message );
				/***** END LOG UPDATE *****/
			}
		/********** BEGIN OUTPUT **********/

			return local.returnValue;
		/********** END OUTPUT **********/	
	}					
}
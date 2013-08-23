note
	description: "Summary description for {NULL_OAUTH_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	NULL_OAUTH_API

inherit

	OAUTH_API

feature --Create Service

	create_service (config: OAUTH_CONFIG): OAUTH_SERVICE_I
			-- Create a service
		do
			create {NULL_OAUTH_SERVICE} Result
		end

end

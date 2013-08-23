note
	description: "Summary description for {OAUTH_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	OAUTH_API

feature -- Service

	create_service (config: OAUTH_CONFIG): OAUTH_SERVICE_I
			-- Create a service
		deferred
		end

end

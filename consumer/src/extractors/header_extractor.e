note
	description: "Command object that generates an OAuth Authorization header to include in the request"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	HEADER_EXTRACTOR

feature -- Extractor

	extract (request: OAUTH_REQUEST): READABLE_STRING_GENERAL
			-- Generates an OAuth 'Authorization' Http header to include in requests as the signature.
		deferred
		end

end

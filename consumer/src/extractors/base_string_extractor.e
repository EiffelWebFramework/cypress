note
	description: "Simple command object that extracts a base string from a OAUTH_REQUEST"
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=OAuthSpec","src=http://oauth.net/core/1.0/#anchor14", "protocol=uri"

deferred class
	BASE_STRING_EXTRACTOR


feature -- Extract

	extract (a_request: OAUTH_REQUEST): STRING_32
			-- Extract an url-encoded base string from the `a_request'
		deferred
		end

end

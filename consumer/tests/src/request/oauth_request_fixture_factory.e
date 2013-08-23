note
	description: "Summary description for {OAUTH_REQUEST_FIXTURE_FACTORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OAUTH_REQUEST_FIXTURE_FACTORY

feature -- Factory

	default_request : OAUTH_REQUEST
		do
			create Result.make ("GET", "http://example.com" )
			Result.add_parameter ({OAUTH_CONSTANTS}.timestamp, "123456")
			Result.add_parameter ({OAUTH_CONSTANTS}.consumer_key, "AS#$^*@&")
			Result.add_parameter ({OAUTH_CONSTANTS}.callback, "http://example/callback")
			Result.add_parameter ({OAUTH_CONSTANTS}.signature, "OAuth-Signature")
		end

end

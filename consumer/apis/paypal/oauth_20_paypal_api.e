note
	description: "Summary description for {OAUTH_20_PAYPAL_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OAUTH_20_PAYPAL_API

inherit

	OAUTH_20_API
		redefine
			access_token_extractor,
			access_token_verb
		end

feature -- Access

	access_token_extractor: ACCESS_TOKEN_EXTRACTOR
		do
			create {JSON_TOKEN_EXTRACTOR} Result
		end

	access_token_verb: READABLE_STRING_GENERAL
		do
			Result := "POST"
		end

	access_token_endpoint: READABLE_STRING_GENERAL
			-- Url that receives the access token request
		do
			create {STRING_32} Result.make_from_string (ACCESS_TOKEN_SANDBOX_URL)
		end

	authorization_url (config: OAUTH_CONFIG): detachable READABLE_STRING_GENERAL
			-- Url where you should redirect your users to authneticate
		do
				--Do nothing
		end

feature -- Implementation

	Access_token_sandbox_url: STRING = "https://api.sandbox.paypal.com/v1/oauth2/token"

end

note
	description: "Summary description for {OAUTH_20_GEOLOQI_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Authentication", "src=https://developers.geoloqi.com/api/authentication", "protocol=uri"
	EIS: "name=OAuth 2.0", "src=https://developers.geoloqi.com/api/OAuth_2.0", "protocol=uri"

class
	OAUTH_20_GEOLOQI_API

inherit

	OAUTH_20_API
		redefine
			access_token_extractor,
			access_token_verb
		end

feature -- Access

	access_token_verb: READABLE_STRING_GENERAL
		do
			Result := "POST"
		end

	access_token_extractor: ACCESS_TOKEN_EXTRACTOR
		do
			create {JSON_TOKEN_EXTRACTOR} Result
		end

	access_token_endpoint: READABLE_STRING_GENERAL
			-- Url that receives the access token request
		do
			create {STRING_32} Result.make_from_string ("https://api.geoloqi.com/1/oauth/token")
		end

	authorization_url (config: OAUTH_CONFIG): detachable READABLE_STRING_GENERAL
			-- Url where you should redirect your users to authneticate
		local
		do
				--|GEOLOQUI only use POST 	request
		end

feature -- Implementation

	Template_authorization_url: STRING = "https://api.geoloqi.com/1/oauth/token"

end

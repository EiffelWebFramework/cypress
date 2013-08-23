note
	description: "Summary description for {OAUTH_20_CAMPAIGN_MONITOR_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OAUTH_20_CAMPAIGN_MONITOR_API

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
			create {STRING_32} Result.make_from_string ("https://api.createsend.com/oauth/token")
		end

	authorization_url (config: OAUTH_CONFIG): detachable READABLE_STRING_GENERAL
			-- Url where you should redirect your users to authneticate
		local
			l_result: STRING_32
		do
			create {STRING_32} l_result.make_from_string (TEMPLATE_AUTHORIZATION_URL)
			l_result.replace_substring_all ("$CLIENT_ID", config.api_key.as_string_8)
			if attached config.callback as l_callback then
				l_result.replace_substring_all ("$REDIRECT_URI", (create {OAUTH_ENCODER}).encoded_string (l_callback.as_string_32))
			end
			if attached config.scope as l_scope then
				l_result.replace_substring_all ("$SCOPE", (create {OAUTH_ENCODER}).encoded_string (l_scope.as_string_32))
				Result := l_result
			end
		end

feature -- Implementation

	Template_authorization_url: STRING = " https://api.createsend.com/oauth?type=web_server&client_id=$CLIENT_ID&redirect_uri=$REDIRECT_URI&scope=$SCOPE"

end

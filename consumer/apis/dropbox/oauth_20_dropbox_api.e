note
	description: "Summary description for {OAUTH_20_DROPBOX_API}."
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=Dropbox OAuth 2.0", "src=https://www.dropbox.com/developers/blog/45/using-oauth-20-with-the-core-api", "protocol=url"
class
	OAUTH_20_DROPBOX_API

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
			create {STRING_32} Result.make_from_string ("https://api.dropbox.com/1/oauth2/token")
		end

	authorization_url (config: OAUTH_CONFIG): detachable READABLE_STRING_GENERAL
			-- Url where you should redirect your users to authneticate
		local
			l_result: STRING_32
		do
			if attached config.state as l_state then
				create {STRING_32} l_result.make_from_string (Template_authorize_url)
				l_result.replace_substring_all ("$CLIENT_ID", config.api_key.as_string_8)
				if attached config.callback as l_callback then
					l_result.replace_substring_all ("$REDIRECT_URI", (create {OAUTH_ENCODER}).encoded_string (l_callback.as_string_32))
				end
				l_result.replace_substring_all ("$CSRF_TOKEN", l_state)
			else
				-- Check the API
			end
		end

feature -- Implementation

	Template_authorize_url: STRING = "https://www.dropbox.com/1/oauth2/authorize?client_id=$CLIENT_ID&response_type=code&redirect_uri=$REDIRECT_URI&state=$CSRF_TOKEN";

note
	copyright: "2013-2014, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
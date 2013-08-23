note
	description: "Summary description for {OAUTH_10_SSL_TWITTER_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OAUTH_10_SSL_TWITTER_API

inherit

	OAUTH_10_TWITTER_API
		redefine
			access_token_endpoint,
			request_token_endpoint,
			authorization_url
		end

feature -- Access

	access_token_endpoint : READABLE_STRING_GENERAL
		do
			Result := "https://" + Access_token_resource
		end


	request_token_endpoint: READABLE_STRING_GENERAL
		do
			Result := "https://" + Request_token_resource
		end

	authorization_url (token: OAUTH_TOKEN): detachable READABLE_STRING_GENERAL
			-- Url where you should redirect your users to authneticate
		local
			l_result: STRING
		do
			create l_result.make_from_string (Authenticate_url)
			l_result.replace_substring_all ("$OAUTH_TOKEN", token.token)
			Result := l_result
		end

feature {NONE} -- Implementation

	Authenticate_url: STRING = "https://api.twitter.com/oauth/authenticate?oauth_token=$OAUTH_TOKEN";
end

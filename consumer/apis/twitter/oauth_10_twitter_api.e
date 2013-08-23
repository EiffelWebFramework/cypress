note
	description: "Summary description for {OAUTH_10_TWITTER_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OAUTH_10_TWITTER_API

inherit

	OAUTH_10_API

feature -- Access

	access_token_endpoint : READABLE_STRING_GENERAL
		local
			l_result : STRING
		do
			l_result := "http://" + Access_token_resource
			Result := l_result
		end


	request_token_endpoint: READABLE_STRING_GENERAL
		local
			l_result : STRING
		do
			l_result := "http://" + Request_token_resource
			Result := l_result
		end

	authorization_url (token: detachable OAUTH_TOKEN): detachable READABLE_STRING_GENERAL
			-- Url where you should redirect your users to authneticate
		local
			l_result: STRING
		do
			create l_result.make_from_string (Authorize_url)
			if token /= Void then
				l_result.replace_substring_all ("$OAUTH_TOKEN", token.token)
			end
			Result := l_result
		end

feature {NONE} -- Implementation

	Authorize_url: STRING = "https://api.twitter.com/oauth/authorize?oauth_token=$OAUTH_TOKEN"
  	Request_token_resource: STRING = "api.twitter.com/oauth/request_token"
  	Access_token_resource: STRING = "api.twitter.com/oauth/access_token"

end

note
	description: "Summary description for {OAUTH_10_AWEBER_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"
	EIS : "name:OAuth Aweber", "src=https://labs.aweber.com/docs/authentication", "protocol=uri"
class
	OAUTH_10_AWEBER_API

inherit

	OAUTH_10_API

feature -- Access

	access_token_endpoint: READABLE_STRING_GENERAL
		do
			Result := Access_token_endpoint_url
		end

	authorization_url (a_token: detachable OAUTH_TOKEN) : READABLE_STRING_GENERAL
		local
			l_result : STRING
		do
			l_result := Authorize_url
			if a_token /= Void then
				l_result.append(a_token.token.as_string_8)
			end
			Result := l_result
		end

	request_token_endpoint: READABLE_STRING_GENERAL
		do
			Result := Request_token_endpoint_url
		end

feature {NONE} --Implemantation

	Authorize_url: STRING = "https://auth.aweber.com/1.0/oauth/authorize?oauth_token="
	Request_token_endpoint_url: STRING = "https://auth.aweber.com/1.0/oauth/request_token"
	Access_token_endpoint_url: STRING = "https://auth.aweber.com/1.0/oauth/access_token"

end

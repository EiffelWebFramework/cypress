note
	description: "Summary description for {OAUTH_10_GOOGLE_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OAUTH_10_GOOGLE_API

inherit

	OAUTH_10_API
		redefine
			access_token_verb,
			request_token_verb
		end

feature -- Access

	access_token_endpoint: READABLE_STRING_GENERAL
		do
			Result := "https://www.google.com/accounts/OAuthGetAccessToken"
		end

	request_token_endpoint:	READABLE_STRING_GENERAL
		do
			Result := "https://www.google.com/accounts/OAuthGetRequestToken"
		end

	access_token_verb: READABLE_STRING_GENERAL
		do
			Result := "GET"
		end

	request_token_verb: READABLE_STRING_GENERAL
		do
			Result := "GET"
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

feature {NONE} -- Implementation

	Authorize_url:STRING = "https://www.google.com/accounts/OAuthAuthorizeToken?oauth_token="

end

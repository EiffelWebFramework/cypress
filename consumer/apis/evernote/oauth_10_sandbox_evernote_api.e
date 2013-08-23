note
	description: "Summary description for {OAUTH_10_SANDBOX_EVERNOTE_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	OAUTH_10_SANDBOX_EVERNOTE_API

inherit

	OAUTH_10_EVERNOTE_API
		redefine
			access_token_endpoint,
			authorization_url,
			request_token_endpoint
		end

feature -- Success
	access_token_endpoint: READABLE_STRING_GENERAL
		do
			Result := Sandbox_access_token_endpoint_url
		end

	authorization_url (a_token: detachable OAUTH_TOKEN) : READABLE_STRING_GENERAL
		local
			l_result : STRING
		do
			l_result := Sandbox_authorize_url
			if a_token /= Void then
				l_result.append(a_token.token.as_string_8)
			end
			Result := l_result
		end

	request_token_endpoint: READABLE_STRING_GENERAL
		do
			Result := Sandbox_request_token_endpoint_url
		end

feature {NONE} -- Implementation

	Sandbox_authorize_url: STRING = "https://sandbox.evernote.com/OAuth.action?oauth_token="
	Sandbox_request_token_endpoint_url: STRING = "https://sandbox.evernote.com/oauth"
	Sandbox_access_token_endpoint_url: STRING = "https://sandbox.evernote.com/oauth"
end
